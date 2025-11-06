import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/medicine_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = ""; // Change to your actual password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        ArrayList<Map<String, Object>> cart = (ArrayList<Map<String, Object>>) session.getAttribute("cart");
        
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Your cart is empty. Please add items to your cart before checkout.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Get form data with validation
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zip");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");
        double totalAmount;
        
        try {
            totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid total amount. Please try again.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Validate required fields
        if (fullName == null || fullName.trim().isEmpty() ||
            address == null || address.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            state == null || state.trim().isEmpty() ||
            zip == null || zip.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Please fill all required fields.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Validate phone number
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("errorMessage", "Please enter a valid 10-digit phone number.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Validate ZIP code
        if (!zip.matches("\\d{6}")) {
            request.setAttribute("errorMessage", "Please enter a valid 6-digit ZIP code.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // If card payment, validate card details
        if ("Card".equals(paymentMethod)) {
            String cardNumber = request.getParameter("cardNumber");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");
            
            if (cardNumber == null || !cardNumber.matches("\\d{16}") ||
                expiry == null || !expiry.matches("(0[1-9]|1[0-2])\\/\\d{2}") ||
                cvv == null || !cvv.matches("\\d{3}")) {
                
                request.setAttribute("errorMessage", "Please enter valid card details.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }
        }
        
        // Generate order ID
        String orderId = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false); // Start transaction
            
            // 1. Insert order into orders table
            String orderSql = "INSERT INTO orders (order_id, user_email, full_name, address, city, " +
                             "state, zip, phone, payment_method, total_amount, order_date, status) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), 'Processing')";
            
            pstmt = conn.prepareStatement(orderSql);
            pstmt.setString(1, orderId);
            pstmt.setString(2, userEmail);
            pstmt.setString(3, fullName);
            pstmt.setString(4, address);
            pstmt.setString(5, city);
            pstmt.setString(6, state);
            pstmt.setString(7, zip);
            pstmt.setString(8, phone);
            pstmt.setString(9, paymentMethod);
            pstmt.setDouble(10, totalAmount);
            
            int orderRows = pstmt.executeUpdate();
            if (orderRows == 0) {
                throw new SQLException("Failed to create order");
            }
            
            // 2. Insert order items
            String itemSql = "INSERT INTO order_items (order_id, medicine_id, medicine_name, " +
                           "quantity, price) VALUES (?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(itemSql);
            for (Map<String, Object> item : cart) {
                String medicineId = item.get("medicineId").toString(); // Convert to String
                String medicineName = item.get("medicineName").toString(); // Convert to String
                int quantity = Integer.parseInt(item.get("quantity").toString()); // Ensure it's an integer
                double price = Double.parseDouble(item.get("medicinePrice").toString()); // Ensure it's a double
                
                pstmt.setString(1, orderId);
                pstmt.setString(2, medicineId);
                pstmt.setString(3, medicineName);
                pstmt.setInt(4, quantity);
                pstmt.setDouble(5, price);
                pstmt.addBatch();
            }
            
            int[] itemRows = pstmt.executeBatch();
            for (int rows : itemRows) {
                if (rows == 0) {
                    throw new SQLException("Failed to insert order items");
                }
            }
            
            // 3. Update medicine quantities in inventory
            String updateInventorySql = "UPDATE medicines SET stock = stock - ? WHERE medicine_id = ?";
            pstmt = conn.prepareStatement(updateInventorySql);
            for (Map<String, Object> item : cart) {
                String medicineId = item.get("medicineId").toString(); // Convert to String
                int quantity = Integer.parseInt(item.get("quantity").toString()); // Ensure it's an integer
                
                pstmt.setInt(1, quantity);
                pstmt.setString(2, medicineId);
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            
            // 4. Clear cart items for this user from database
            String clearCartSql = "DELETE FROM cart_items WHERE user_email = ?";
            pstmt = conn.prepareStatement(clearCartSql);
            pstmt.setString(1, userEmail);
            pstmt.executeUpdate();
            
            // Commit transaction
            conn.commit();
            
            // Clear session cart
            session.removeAttribute("cart");
            
            // Redirect to order confirmation page
            response.sendRedirect("orderConfirmation.jsp?orderId=" + orderId);
            
        } catch (ClassNotFoundException e) {
            handleError(conn, request, response, "Database driver not found: " + e.getMessage());
        } catch (SQLException e) {
            handleError(conn, request, response, "Database error: " + e.getMessage());
        } catch (Exception e) {
            handleError(conn, request, response, "Error placing order: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private void handleError(Connection conn, HttpServletRequest request, 
                           HttpServletResponse response, String errorMessage) 
                           throws ServletException, IOException {
        try {
            if (conn != null) conn.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}