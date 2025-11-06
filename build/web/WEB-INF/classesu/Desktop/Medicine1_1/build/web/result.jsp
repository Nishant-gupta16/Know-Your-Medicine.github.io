<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Search Results</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #2d9e8f;
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 36px;
            font-weight: 500;
            position: relative;
        }
        .home-link {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            align-items: center;
            font-size: 16px;
            color: #fff;
            text-decoration: none;
            cursor: pointer;
        }
        .home-link i {
            font-size: 30px;
            margin-right: 10px;
        }
        .home-link:hover {
            color: #007BFF;
        }
        .container {
            width: 85%;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #2d9e8f;
            color: white;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .search-info {
            margin: 10px 0;
            font-size: 18px;
            color: #666;
            font-weight: 500;
        }
        footer {
            text-align: center;
            padding: 15px;
            background-color: #2d9e8f;
            color: white;
            font-size: 14px;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .buy-button, .cart-button, .go-to-cart-button {
            padding: 8px 16px;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .buy-button {
            background-color: #2d9e8f;
        }
        .buy-button:hover {
            background-color: #1e7a68;
        }
        .cart-button {
            background-color: #ff9800;
        }
        .cart-button:hover {
            background-color: #e68a00;
        }
        .go-to-cart-button {
            background-color: #9c27b0;
            margin-top: 10px;
        }
        .go-to-cart-button:hover {
            background-color: #7b1fa2;
        }
        .cart-button i, .buy-button i, .go-to-cart-button i {
            margin-right: 5px;
        }
        @media screen and (max-width: 768px) {
            table, th, td {
                font-size: 14px;
                padding: 8px;
            }
            .container {
                width: 95%;
            }
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
        }
    </style>
</head>
<body>
    <header>
        Know Your Medicine - Search Results
        <a href="index.jsp" class="home-link">
            <i class="fas fa-home"></i>
            Back to Home
        </a>
    </header>

    <div class="container">
        <div class="search-info">
            <strong>Search Results for: </strong>
            <span><%= request.getParameter("query") %></span>
        </div>

        <!-- Go to Cart Button -->
        <form action="userWelcome.jsp" method="GET">
            <button type="submit" class="go-to-cart-button">
                <i class="fas fa-shopping-cart"></i> Go to Cart
            </button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Dosage</th>
                    <th>Side Effects</th>
                    <th>Benefits</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String query = request.getParameter("query");
                    if (query != null && !query.trim().isEmpty()) {
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            String dbURL = "jdbc:mysql://localhost:3306/medicine_db";
                            String dbUser = "root";
                            String dbPassword = "";
                            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            String sql = "SELECT * FROM medicines WHERE name LIKE ?";
                            preparedStatement = connection.prepareStatement(sql);
                            preparedStatement.setString(1, "%" + query + "%");
                            resultSet = preparedStatement.executeQuery();

                            boolean hasResults = false;
                            while (resultSet.next()) {
                                hasResults = true;
                %>
                                <tr>
                                    <td><%= resultSet.getString("name") %></td>
                                    <td><%= resultSet.getString("description") %></td>
                                    <td><%= resultSet.getString("dosage") %></td>
                                    <td><%= resultSet.getString("side_effects") %></td>
                                    <td><%= resultSet.getString("benefits") %></td>
                                    <td>?<%= String.format("%.2f", resultSet.getDouble("price")) %></td>
                                    <td>
                                        <div class="action-buttons">
                                            <form action="ProcessBuyNowServlet" method="POST" style="margin:0;">
                                                <input type="hidden" name="medicineId" value="<%= resultSet.getInt("id") %>">
                                                <input type="hidden" name="medicineName" value="<%= resultSet.getString("name") %>">
                                                <input type="hidden" name="medicinePrice" value="<%= resultSet.getDouble("price") %>">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="buy-button"><i class="fas fa-shopping-bag"></i> Buy Now</button>
                                            </form>
                                            <form action="AddToCartServlet" method="POST" style="margin:0;">
                                                <input type="hidden" name="medicineId" value="<%= resultSet.getInt("id") %>">
                                                <input type="hidden" name="medicineName" value="<%= resultSet.getString("name") %>">
                                                <input type="hidden" name="medicinePrice" value="<%= resultSet.getDouble("price") %>">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="cart-button"><i class="fas fa-cart-plus"></i> Add to Cart</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                <%
                            }

                            if (!hasResults) {
                %>
                                <tr>
                                    <td colspan="7" style="text-align: center;">No Medicine found for "<%= query %>"</td>
                                </tr>
                <%
                            }

                        } catch (ClassNotFoundException e) {
                            out.println("<tr><td colspan='7' style='color:red;text-align:center;'>MySQL JDBC Driver not found: " + e.getMessage() + "</td></tr>");
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='7' style='color:red;text-align:center;'>Database connection error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try {
                                if (resultSet != null) resultSet.close();
                                if (preparedStatement != null) preparedStatement.close();
                                if (connection != null) connection.close();
                            } catch (SQLException e) {
                                out.println("<tr><td colspan='7' style='color:red;text-align:center;'>Error closing resources: " + e.getMessage() + "</td></tr>");
                            }
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="7" style="text-align: center;">Please enter a valid search query.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <footer>
        &copy; 2025 Know Your Medicine. All Rights Reserved.
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>