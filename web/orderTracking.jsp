<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<%
    String orderId = request.getParameter("orderId");
    String orderStatus = "Processing"; // Default status
    Timestamp orderDate = null;
    String paymentMethod = "";
    double totalAmount = 0.0;
    
    // Database connection to get order details
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
        
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, orderId);
        ResultSet result = statement.executeQuery();
        
        if (result.next()) {
            orderStatus = result.getString("status");
            orderDate = result.getTimestamp("order_date");
            paymentMethod = result.getString("payment_method");
            totalAmount = result.getDouble("total_amount");
        }
        
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Tracking - Know Your Medicine</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            text-align: center;
            padding: 20px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin: 10px;
        }
        .container {
            width: 80%;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .tracking-container {
            margin: 30px 0;
        }
        .tracking-steps {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin: 40px 0;
        }
        .tracking-steps::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 3px;
            background: #ddd;
            z-index: 1;
        }
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 2;
            flex: 1;
        }
        .step-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            color: white;
        }
        .step.active .step-icon {
            background: #2d9e8f;
        }
        .step-text {
            font-size: 14px;
            text-align: center;
        }
        .order-details {
            display: flex;
            gap: 30px;
            margin: 30px 0;
        }
        .detail-card {
            flex: 1;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .detail-card h3 {
            margin-top: 0;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2d9e8f;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #1e7a68;
        }
        .order-items {
            margin: 20px 0;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>
    <header>
        <h1>Order Tracking</h1>
    </header>

    <div class="container">
        <div class="order-header">
            <div>
                <h2>Order #<%= orderId %></h2>
                <p>Placed on <%= orderDate != null ? orderDate.toString() : "" %></p>
            </div>
            <div style="text-align: right;">
                <h3>Status: <%= orderStatus %></h3>
                <p>Total: ₹<%= String.format("%.2f", totalAmount) %></p>
            </div>
        </div>
        
        <div class="tracking-container">
            <h3>Tracking Information</h3>
            <div class="tracking-steps">
                <div class="step <%= orderStatus.equals("Processing") || orderStatus.equals("Shipped") || orderStatus.equals("Delivered") ? "active" : "" %>">
                    <div class="step-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="step-text">Order Placed</div>
                </div>
                <div class="step <%= orderStatus.equals("Shipped") || orderStatus.equals("Delivered") ? "active" : "" %>">
                    <div class="step-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="step-text">Processing</div>
                </div>
                <div class="step <%= orderStatus.equals("Shipped") || orderStatus.equals("Delivered") ? "active" : "" %>">
                    <div class="step-icon">
                        <i class="fas fa-truck"></i>
                    </div>
                    <div class="step-text">Shipped</div>
                </div>
                <div class="step <%= orderStatus.equals("Delivered") ? "active" : "" %>">
                    <div class="step-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <div class="step-text">Delivered</div>
                </div>
            </div>
        </div>
        
        <div class="order-details">
            <div class="detail-card">
                <h3>Shipping Information</h3>
                <p><strong>Status:</strong> <%= orderStatus %></p>
                <p><strong>Estimated Delivery:</strong> 
                    <% if (orderStatus.equals("Delivered")) { %>
                        Delivered on <%= new java.util.Date().toString() %>
                    <% } else { %>
                        Within 3-5 business days
                    <% } %>
                </p>
            </div>
            
            <div class="detail-card">
                <h3>Payment Information</h3>
                <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
                <p><strong>Total Amount:</strong> ₹<%= String.format("%.2f", totalAmount) %></p>
                <p><strong>Payment Status:</strong> <%= paymentMethod.equals("COD") ? "Pending" : "Paid" %></p>
            </div>
        </div>
        
        <div class="order-items">
            <h3>Order Items</h3>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
                    
                    String sql = "SELECT * FROM order_items WHERE order_id = ?";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setString(1, orderId);
                    ResultSet result = statement.executeQuery();
                    
                    while (result.next()) {
            %>
                        <div class="order-item">
                            <div>
                                <div><%= result.getString("medicine_name") %></div>
                                <div>Qty: <%= result.getInt("quantity") %></div>
                            </div>
                            <div>₹<%= String.format("%.2f", result.getDouble("price") * result.getInt("quantity")) %></div>
                        </div>
            <%
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
        
        <a href="userWelcome.jsp" class="btn">Back to Dashboard</a>
    </div>
</body>
</html>