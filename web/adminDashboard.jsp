<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Know Your Medicine</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Your existing CSS styles remain the same */
        :root {
            --primary-color: #2d9e8f;
            --secondary-color: #1e7a68;
            --accent-color: #3aa789;
            --light-color: #f4f7f6;
            --dark-color: #1a3a32;
            --danger-color: #d32f2f;
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

        /* Admin Info Section */
        .admin-info {
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

        .admin-details {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .admin-avatar {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--danger-color), #b71c1c);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .admin-text h3 {
            margin: 0;
            color: var(--dark-color);
            font-size: 1.5rem;
            font-weight: 600;
        }

        .admin-text p {
            margin: 0.3rem 0 0;
            color: #666;
            font-size: 0.9rem;
        }

        /* Stats Section */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .stat-card i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .stat-card h3 {
            font-size: 1.8rem;
            color: var(--secondary-color);
            margin-bottom: 0.5rem;
        }

        .stat-card p {
            color: #666;
            font-size: 1rem;
        }

        /* Tables Section */
        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 1.5rem;
        }

        .tab-button {
            padding: 0.8rem 1.5rem;
            background: none;
            border: none;
            cursor: pointer;
            font-weight: 500;
            color: #666;
            position: relative;
            transition: var(--transition);
        }

        .tab-button.active {
            color: var(--primary-color);
        }

        .tab-button.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: var(--primary-color);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .table-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .action-btn {
            padding: 0.3rem 0.6rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
            margin-right: 0.5rem;
        }

        .edit-btn {
            background-color: var(--warning-color);
            color: #333;
        }

        .delete-btn {
            background-color: var(--danger-color);
            color: white;
        }

        .action-btn:hover {
            opacity: 0.8;
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
            
            .admin-info {
                flex-direction: column;
                text-align: center;
            }
            
            .admin-details {
                flex-direction: column;
                text-align: center;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <%
        // Check if admin is logged in
        String userType = (String) session.getAttribute("userType");
        if (userType == null || !userType.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String adminName = (String) session.getAttribute("userName");
        String adminEmail = (String) session.getAttribute("userEmail");
        
        // Database connection
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        // Initialize counts
        int userCount = 0;
        int storeCount = 0;
        int medicineCount = 0;
        int orderCount = 0;
        
        // Initialize lists
        ArrayList<Map<String, String>> users = new ArrayList<>();
        ArrayList<Map<String, String>> stores = new ArrayList<>();
        ArrayList<Map<String, String>> medicines = new ArrayList<>();
        ArrayList<Map<String, String>> orders = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
            
            // Get counts
            stmt = conn.createStatement();
            
            // User count
            rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM users");
            if (rs.next()) userCount = rs.getInt("count");
            
            // Store count
            rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM stores");
            if (rs.next()) storeCount = rs.getInt("count");
            
            // Medicine count
            rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM medicines");
            if (rs.next()) medicineCount = rs.getInt("count");
            
            // Order count
            rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM orders");
            if (rs.next()) orderCount = rs.getInt("count");
            
            // Get user list - UPDATED QUERY TO INCLUDE ALL USERS
            rs = stmt.executeQuery("SELECT id, full_name, email, created_at FROM users");
            while (rs.next()) {
                Map<String, String> user = new HashMap<>();
                user.put("id", rs.getString("id"));
                user.put("name", rs.getString("full_name"));
                user.put("email", rs.getString("email"));
                user.put("created_at", rs.getString("created_at"));
                users.add(user);
            }
            
            // Get store list
            rs = stmt.executeQuery("SELECT * FROM stores");
            while (rs.next()) {
                Map<String, String> store = new HashMap<>();
                store.put("id", rs.getString("id"));
                store.put("name", rs.getString("store_name"));
                store.put("email", rs.getString("store_email"));
                store.put("location", rs.getString("location"));
                store.put("contact", rs.getString("contact_number"));
                store.put("created_at", rs.getString("created_at"));
                stores.add(store);
            }
            
            // Get medicine list
            rs = stmt.executeQuery("SELECT m.*, s.store_name FROM medicines m LEFT JOIN stores s ON m.store_id = s.id");
            while (rs.next()) {
                Map<String, String> medicine = new HashMap<>();
                medicine.put("id", rs.getString("id"));
                medicine.put("name", rs.getString("name"));
                medicine.put("description", rs.getString("description"));
                medicine.put("price", rs.getString("price"));
                medicine.put("quantity", rs.getString("quantity"));
                medicine.put("store", rs.getString("store_name"));
                medicine.put("created_at", rs.getString("created_at"));
                medicines.add(medicine);
            }
            
            // Get order list
            rs = stmt.executeQuery("SELECT o.*, u.full_name AS user_name FROM orders o LEFT JOIN users u ON o.user_id = u.id");
            while (rs.next()) {
                Map<String, String> order = new HashMap<>();
                order.put("id", rs.getString("id"));
                order.put("user", rs.getString("user_name"));
                order.put("total", rs.getString("total_amount"));
                order.put("status", rs.getString("status"));
                order.put("created_at", rs.getString("created_at"));
                orders.add(order);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Add error handling to display in the page
            request.setAttribute("errorMessage", "Error retrieving data: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <!-- Header Section -->
    <header>
        <h1><i class="fas fa-capsules"></i> Admin Dashboard</h1>
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
        <!-- Admin Information Section -->
        <div class="admin-info">
            <div class="admin-details">
                <div class="admin-avatar">
                    <%= adminName != null && !adminName.isEmpty() ? adminName.charAt(0) : 'A' %>
                </div>
                <div class="admin-text">
                    <h3><%= adminName != null ? adminName : "Admin" %></h3>
                    <p><%= adminEmail != null ? adminEmail : "Administrator" %></p>
                </div>
            </div>
            <div class="admin-actions">
                <button class="action-btn edit-btn" onclick="location.href='adminSettings.jsp'">
                    <i class="fas fa-cog"></i> Settings
                </button>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-users"></i>
                <h3><%= userCount %></h3>
                <p>Registered Users</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-store"></i>
                <h3><%= storeCount %></h3>
                <p>Registered Stores</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-pills"></i>
                <h3><%= medicineCount %></h3>
                <p>Medicines</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-shopping-cart"></i>
                <h3><%= orderCount %></h3>
                <p>Total Orders</p>
            </div>
        </div>

        <!-- Tabs Section -->
        <div class="tabs">
            <button class="tab-button active" onclick="openTab(event, 'users-tab')">Users</button>
            <button class="tab-button" onclick="openTab(event, 'stores-tab')">Stores</button>
            <button class="tab-button" onclick="openTab(event, 'medicines-tab')">Medicines</button>
            <button class="tab-button" onclick="openTab(event, 'orders-tab')">Orders</button>
        </div>

        <!-- Users Tab -->
        <div id="users-tab" class="tab-content active">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Registered On</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (users.isEmpty()) { %>
                            <tr>
                                <td colspan="5" style="text-align: center;">No users found</td>
                            </tr>
                        <% } else { 
                            for (Map<String, String> user : users) { %>
                            <tr>
                                <td><%= user.get("id") %></td>
                                <td><%= user.get("name") %></td>
                                <td><%= user.get("email") %></td>
                                <td><%= user.get("created_at") %></td>
                                <td>
                                    <button class="action-btn edit-btn">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="action-btn delete-btn">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Stores Tab -->
        <div id="stores-tab" class="tab-content">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Store Name</th>
                            <th>Email</th>
                            <th>Location</th>
                            <th>Contact</th>
                            <th>Registered On</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (stores.isEmpty()) { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No stores found</td>
                            </tr>
                        <% } else { 
                            for (Map<String, String> store : stores) { %>
                            <tr>
                                <td><%= store.get("id") %></td>
                                <td><%= store.get("name") %></td>
                                <td><%= store.get("email") %></td>
                                <td><%= store.get("location") %></td>
                                <td><%= store.get("contact") %></td>
                                <td><%= store.get("created_at") %></td>
                                <td>
                                    <button class="action-btn edit-btn">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="action-btn delete-btn">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Medicines Tab -->
        <div id="medicines-tab" class="tab-content">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Store</th>
                            <th>Added On</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (medicines.isEmpty()) { %>
                            <tr>
                                <td colspan="8" style="text-align: center;">No medicines found</td>
                            </tr>
                        <% } else { 
                            for (Map<String, String> medicine : medicines) { %>
                            <tr>
                                <td><%= medicine.get("id") %></td>
                                <td><%= medicine.get("name") %></td>
                                <td><%= medicine.get("description") != null ? medicine.get("description").length() > 30 ? 
                                    medicine.get("description").substring(0, 30) + "..." : medicine.get("description") : "" %></td>
                                <td>?<%= medicine.get("price") %></td>
                                <td><%= medicine.get("quantity") %></td>
                                <td><%= medicine.get("store") %></td>
                                <td><%= medicine.get("created_at") %></td>
                                <td>
                                    <button class="action-btn edit-btn">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="action-btn delete-btn">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Orders Tab -->
        <div id="orders-tab" class="tab-content">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Order Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (orders.isEmpty()) { %>
                            <tr>
                                <td colspan="6" style="text-align: center;">No orders found</td>
                            </tr>
                        <% } else { 
                            for (Map<String, String> order : orders) { %>
                            <tr>
                                <td><%= order.get("id") %></td>
                                <td><%= order.get("user") %></td>
                                <td>?<%= order.get("total") %></td>
                                <td><span style="color: 
                                    <%= order.get("status").equals("Completed") ? "green" : 
                                        order.get("status").equals("Pending") ? "orange" : "red" %>">
                                    <%= order.get("status") %>
                                </span></td>
                                <td><%= order.get("created_at") %></td>
                                <td>
                                    <button class="action-btn edit-btn">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="action-btn delete-btn">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

    <script>
        function openTab(evt, tabName) {
            // Hide all tab contents
            const tabContents = document.getElementsByClassName("tab-content");
            for (let i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove("active");
            }
            
            // Remove active class from all tab buttons
            const tabButtons = document.getElementsByClassName("tab-button");
            for (let i = 0; i < tabButtons.length; i++) {
                tabButtons[i].classList.remove("active");
            }
            
            // Show the current tab and add active class to the button
            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");
        }
        
        // Confirm before deleting
        const deleteButtons = document.querySelectorAll(".delete-btn");
        deleteButtons.forEach(button => {
            button.addEventListener("click", function() {
                if (confirm("Are you sure you want to delete this item?")) {
                    // Here you would typically make an AJAX call to delete the item
                    alert("Item deleted (this is a demo - no actual deletion occurred)");
                }
            });
        });
    </script>
</body>
</html>