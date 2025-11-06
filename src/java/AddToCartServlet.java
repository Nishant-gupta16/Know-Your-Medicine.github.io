import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/medicine_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get or create the cart in session
        ArrayList<Map<String, Object>> cart = (ArrayList<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        // Get medicine details from request
        String medicineId = request.getParameter("medicineId");
        String medicineName = request.getParameter("medicineName");
        double medicinePrice = Double.parseDouble(request.getParameter("medicinePrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Database connection objects
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Check if item already exists in user's cart
            String checkSql = "SELECT * FROM cart_items WHERE user_email = ? AND medicine_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, medicineId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Update existing item quantity in database
                String updateSql = "UPDATE cart_items SET quantity = quantity + ? " +
                                 "WHERE user_email = ? AND medicine_id = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, quantity);
                pstmt.setString(2, userEmail);
                pstmt.setString(3, medicineId);
                pstmt.executeUpdate();
            } else {
                // Insert new item into database
                String insertSql = "INSERT INTO cart_items (user_email, medicine_id, medicine_name, quantity, price) " +
                                  "VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, userEmail);
                pstmt.setString(2, medicineId);
                pstmt.setString(3, medicineName);
                pstmt.setInt(4, quantity);
                pstmt.setDouble(5, medicinePrice);
                pstmt.executeUpdate();
            }
            
            // Update session cart
            boolean itemExists = false;
            for (Map<String, Object> item : cart) {
                if (item.get("medicineId").equals(medicineId)) {
                    int currentQty = (int) item.get("quantity");
                    item.put("quantity", currentQty + quantity);
                    itemExists = true;
                    break;
                }
            }
            
            if (!itemExists) {
                Map<String, Object> newItem = new HashMap<>();
                newItem.put("medicineId", medicineId);
                newItem.put("medicineName", medicineName);
                newItem.put("medicinePrice", medicinePrice);
                newItem.put("quantity", quantity);
                cart.add(newItem);
            }
            
            session.setAttribute("cart", cart);
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        
        // Redirect back to previous page
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : "userWelcome.jsp");
    }
}