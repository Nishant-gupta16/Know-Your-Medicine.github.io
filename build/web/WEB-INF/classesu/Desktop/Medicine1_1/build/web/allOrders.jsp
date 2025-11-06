<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Similar styling as other pages -->
</head>
<body>
    <!-- Header and navigation similar to other pages -->
    
    <div class="container">
        <h1>My Orders</h1>
        <table class="orders-table">
            <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Items</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                Integer userId = (Integer) session.getAttribute("userId");
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/medicine_db", "root", "");
                    
                    String sql = "SELECT o.*, COUNT(oi.item_id) as item_count " +
                                "FROM orders o LEFT JOIN order_items oi ON o.order_id = oi.order_id " +
                                "WHERE o.user_id = ? " +
                                "GROUP BY o.order_id " +
                                "ORDER BY o.order_date DESC";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setInt(1, userId);
                    ResultSet result = statement.executeQuery();
                    
                    while (result.next()) {
            %>
                        <tr>
                            <td><%= result.getInt("order_id") %></td>
                            <td><%= result.getTimestamp("order_date") %></td>
                            <td><%= result.getInt("item_count") %></td>
                            <td>₹<%= String.format("%.2f", result.getDouble("total_amount")) %></td>
                            <td><span class="status <%= result.getString("status").toLowerCase() %>">
                                <%= result.getString("status") %>
                            </span></td>
                            <td>
                                <a href="orderTracking.jsp?orderId=<%= result.getInt("order_id") %>" class="btn">View Details</a>
                            </td>
                        </tr>
            <%
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</body>
</html>