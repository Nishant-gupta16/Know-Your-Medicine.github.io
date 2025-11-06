<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Dashboard | Know Your Medicine</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2d9e8f;
                --secondary-color: #1e7a68;
                --accent-color: #3aa789;
                --light-color: #f4f7f6;
                --dark-color: #1a3a32;
                --success-color: #28a745;
                --danger-color: #dc3545;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --border-radius: 8px;
                --box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: var(--light-color);
                color: #333;
                line-height: 1.6;
            }

            header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 1.5rem 2rem;
                text-align: center;
                box-shadow: var(--box-shadow);
                position: relative;
                border-radius: 0;
            }

            header h1 {
                font-weight: 600;
                font-size: 2rem;
            }

            .logout-div {
                position: absolute;
                top: 1.5rem;
                right: 2rem;
                display: flex;
                gap: 1rem;
            }

            .home-button, .logout-button {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .home-button {
                background-color: white;
                color: var(--secondary-color);
            }

            .logout-button {
                background-color: var(--danger-color);
                color: white;
            }

            .home-button:hover {
                background-color: #e2e6ea;
                transform: translateY(-2px);
            }

            .logout-button:hover {
                background-color: #c82333;
                transform: translateY(-2px);
            }

            .container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1.5rem;
            }

            /* User Info Section */
            .user-info {
                background-color: white;
                padding: 2rem;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 1.5rem;
            }

            .user-details {
                display: flex;
                align-items: center;
                gap: 1.5rem;
            }

            .user-avatar {
                width: 70px;
                height: 70px;
                background: linear-gradient(135deg, var(--accent-color), var(--secondary-color));
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 2rem;
                font-weight: 600;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .user-text h3 {
                margin: 0;
                color: var(--dark-color);
                font-size: 1.5rem;
                font-weight: 600;
            }

            .user-text p {
                margin: 0.3rem 0 0;
                color: #666;
                font-size: 0.9rem;
            }

            .cart-summary {
                background: linear-gradient(135deg, #f5f7fa, #e4e8eb);
                padding: 1rem 1.5rem;
                border-radius: var(--border-radius);
                text-align: center;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }

            .cart-summary p {
                margin: 0.3rem 0;
                font-weight: 500;
            }

            .cart-summary strong {
                color: var(--secondary-color);
            }

            /* Welcome Section */
            .welcome-container {
                background-color: white;
                padding: 2rem;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 2rem;
                text-align: center;
            }

            .welcome-container h2 {
                color: var(--primary-color);
                margin-bottom: 1rem;
                font-weight: 600;
            }

            .welcome-container p {
                color: #666;
                max-width: 700px;
                margin: 0 auto;
            }

            /* Search Section */
            .search-section {
                margin-bottom: 2rem;
            }

            .search-section form {
                display: flex;
                max-width: 600px;
                margin: 0 auto;
                box-shadow: var(--box-shadow);
                border-radius: var(--border-radius);
                overflow: hidden;
            }

            .search-section input {
                flex: 1;
                padding: 0.8rem 1.2rem;
                border: none;
                font-size: 1rem;
                outline: none;
            }

            .search-section button {
                background: linear-gradient(135deg, var(--accent-color), var(--secondary-color));
                color: white;
                border: none;
                padding: 0 1.5rem;
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .search-section button:hover {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            }

            /* Cart Section */
            .cart-container {
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 2rem;
            }

            .cart-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 1.2rem 1.5rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .cart-header h3 {
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.7rem;
            }

            .cart-header span {
                background-color: rgba(255, 255, 255, 0.2);
                padding: 0.3rem 0.7rem;
                border-radius: 20px;
                font-size: 0.9rem;
            }

            .cart-items {
                padding: 1.5rem;
            }

            .empty-cart {
                text-align: center;
                padding: 2rem;
                color: #666;
            }

            .cart-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 0;
                border-bottom: 1px solid #eee;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .item-details {
                flex: 1;
                min-width: 200px;
            }

            .item-name {
                font-weight: 500;
                color: var(--dark-color);
                margin-bottom: 0.3rem;
            }

            .item-price {
                color: var(--success-color);
                font-weight: 600;
            }

            .quantity-form {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .quantity-btn {
                width: 30px;
                height: 30px;
                border: 1px solid #ddd;
                background-color: #f8f9fa;
                color: var(--dark-color);
                font-weight: bold;
                cursor: pointer;
                border-radius: 4px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: var(--transition);
            }

            .quantity-btn:hover {
                background-color: #e9ecef;
            }

            .quantity-input {
                width: 50px;
                height: 30px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-weight: 500;
            }

            .remove-item {
                color: var(--danger-color);
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                transition: var(--transition);
            }

            .remove-item:hover {
                color: #c82333;
                transform: translateY(-2px);
            }

            .cart-total {
                text-align: right;
                padding: 1rem 1.5rem;
                font-size: 1.2rem;
                font-weight: 600;
                color: var(--secondary-color);
                border-top: 1px solid #eee;
            }

            .checkout-btn {
                background: linear-gradient(135deg, var(--accent-color), var(--secondary-color));
                color: white;
                border: none;
                padding: 0.8rem 1.5rem;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 0.7rem;
                margin: 0 1.5rem 1.5rem auto;
                float: right;
            }

            .checkout-btn:hover {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* Footer */
            footer {
                background-color: #2d9e8f;
                color: white;
                text-align: center;
                padding: 1.5rem;
                margin-top: 2rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                header h1 {
                    font-size: 1.5rem;
                    padding-right: 120px;
                }
                
                .logout-div {
                    top: 1rem;
                    right: 1rem;
                }
                
                .user-info {
                    flex-direction: column;
                    text-align: center;
                }
                
                .user-details {
                    flex-direction: column;
                    text-align: center;
                }
                
                .cart-item {
                    flex-direction: column;
                    align-items: flex-start;
                }
                
                .quantity-form {
                    width: 100%;
                    justify-content: flex-start;
                }
                
                .checkout-btn {
                    width: 100%;
                    justify-content: center;
                    margin: 0 0 1.5rem 0;
                    float: none;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Get user data from session
            String userName = (String) session.getAttribute("userName");
            String userEmail = (String) session.getAttribute("userEmail");
            
            // Get cart from session and database
            ArrayList<Map<String, Object>> cart = (ArrayList<Map<String, Object>>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                
                // Load cart from database if user is logged in
                if (userEmail != null) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
                        
                        String sql = "SELECT * FROM cart_items WHERE user_email = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userEmail);
                        rs = pstmt.executeQuery();
                        
                        while (rs.next()) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("medicineId", rs.getString("medicine_id"));
                            item.put("medicineName", rs.getString("medicine_name"));
                            item.put("medicinePrice", rs.getDouble("price"));
                            item.put("quantity", rs.getInt("quantity"));
                            cart.add(item);
                        }
                        
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
                
                session.setAttribute("cart", cart);
            }
            
            // Handle remove item request
            String removeIndex = request.getParameter("remove");
            if (removeIndex != null) {
                try {
                    int index = Integer.parseInt(removeIndex);
                    if (index >= 0 && index < cart.size()) {
                        String medicineId = (String) cart.get(index).get("medicineId");
                        
                        // Remove from database
                        if (userEmail != null) {
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
                                
                                String sql = "DELETE FROM cart_items WHERE user_email = ? AND medicine_id = ?";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, userEmail);
                                pstmt.setString(2, medicineId);
                                pstmt.executeUpdate();
                                
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (pstmt != null) pstmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                        
                        // Remove from session cart
                        cart.remove(index);
                        session.setAttribute("cart", cart);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            
            // Handle quantity update
            String updateIndex = request.getParameter("update");
            if (updateIndex != null) {
                try {
                    int index = Integer.parseInt(updateIndex);
                    if (index >= 0 && index < cart.size()) {
                        int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                        if (newQuantity > 0) {
                            String medicineId = (String) cart.get(index).get("medicineId");
                            
                            // Update database
                            if (userEmail != null) {
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
                                    
                                    String sql = "UPDATE cart_items SET quantity = ? WHERE user_email = ? AND medicine_id = ?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setInt(1, newQuantity);
                                    pstmt.setString(2, userEmail);
                                    pstmt.setString(3, medicineId);
                                    pstmt.executeUpdate();
                                    
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (pstmt != null) pstmt.close();
                                        if (conn != null) conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                            
                            // Update session cart
                            cart.get(index).put("quantity", newQuantity);
                            session.setAttribute("cart", cart);
                        } else {
                            // If quantity is 0 or less, remove the item
                            String medicineId = (String) cart.get(index).get("medicineId");
                            
                            // Remove from database
                            if (userEmail != null) {
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
                                    
                                    String sql = "DELETE FROM cart_items WHERE user_email = ? AND medicine_id = ?";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, userEmail);
                                    pstmt.setString(2, medicineId);
                                    pstmt.executeUpdate();
                                    
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (pstmt != null) pstmt.close();
                                        if (conn != null) conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                            
                            // Remove from session cart
                            cart.remove(index);
                            session.setAttribute("cart", cart);
                        }
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            
            // Calculate cart total
            double cartTotal = 0;
            for (Map<String, Object> item : cart) {
                cartTotal += (double) item.get("medicinePrice") * (int) item.get("quantity");
            }
        %>

        <!-- Header Section -->
        <header>
            <h1><i class="fas fa-capsules"></i> Welcome to Know Your Medicine</h1>
            <div class="logout-div">
                <a href="index.jsp">
                    <button type="button" class="home-button">
                        <i class="fas fa-home"></i> Home
                    </button>
                </a>
                <form action="logout" method="POST">
                    <button type="submit" class="logout-button">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </header>

        <div class="container">
            <!-- User Information Section -->
            <div class="user-info">
                <div class="user-details">
                    <div class="user-avatar">
                        <%= userName != null && !userName.isEmpty() ? userName.charAt(0) : 'U' %>
                    </div>
                    <div class="user-text">
                        <h3><%= userName != null ? userName : "Guest" %></h3>
                        <p><%= userEmail != null ? userEmail : "Not logged in" %></p>
                    </div>
                </div>
                <div class="cart-summary">
                    <p><strong>Items in Cart:</strong> <%= cart.size() %></p>
                    <p><strong>Total:</strong> ₹<%= String.format("%.2f", cartTotal) %></p>
                </div>
            </div>

            <!-- Welcome Message Section -->
            <section class="welcome-container">
                <h2>Welcome, <%= userName != null ? userName : "Guest" %>!</h2>
                <p>We are glad to have you here. Explore the latest medicines and get personalized recommendations.</p>
            </section>

            <!-- Medicine Search Section -->
            <div class="search-section">
                <form action="search" method="GET">
                    <input type="text" name="query" placeholder="Search for a medicine..." required>
                    <button type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>

            <!-- Cart Section -->
            <div class="cart-container">
                <div class="cart-header">
                    <h3><i class="fas fa-shopping-cart"></i> Your Medicine Cart</h3>
                    <span><%= cart.size() %> item(s)</span>
                </div>
                
                <div class="cart-items">
                    <% if (cart.isEmpty()) { %>
                        <div class="empty-cart">
                            <p>Your cart is empty. Search for medicines to add them to your cart.</p>
                        </div>
                    <% } else { %>
                        <% for (int i = 0; i < cart.size(); i++) { 
                            Map<String, Object> item = cart.get(i);
                        %>
                            <div class="cart-item">
                                <div class="item-details">
                                    <div class="item-name"><%= item.get("medicineName") %></div>
                                    <div class="item-price">₹<%= String.format("%.2f", item.get("medicinePrice")) %></div>
                                </div>
                                <form action="userWelcome.jsp" method="GET" class="quantity-form">
                                    <input type="hidden" name="update" value="<%= i %>">
                                    <button type="button" class="quantity-btn minus" onclick="this.parentNode.querySelector('input[type=number]').stepDown(); this.parentNode.submit();">-</button>
                                    <input type="number" name="quantity" value="<%= item.get("quantity") %>" min="1" class="quantity-input" onchange="this.form.submit()">
                                    <button type="button" class="quantity-btn plus" onclick="this.parentNode.querySelector('input[type=number]').stepUp(); this.parentNode.submit();">+</button>
                                </form>
                                <a href="userWelcome.jsp?remove=<%= i %>" class="remove-item">
                                    <i class="fas fa-trash"></i> Remove
                                </a>
                            </div>
                        <% } %>
                    <% } %>
                </div>
                
                <% if (!cart.isEmpty()) { %>
                    <div class="cart-total">
                        Total: ₹<%= String.format("%.2f", cartTotal) %>
                    </div>
                    
                    <form action="checkout.jsp" method="POST">
                        <button type="submit" class="checkout-btn">
                            <i class="fas fa-credit-card"></i> Proceed to Checkout
                        </button>
                    </form>
                    <div style="clear: both;"></div>
                <% } %>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            &copy; 2025 Know Your Medicine. All rights reserved.
        </footer>
    </body>
</html>