import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ClearCartServlet")
public class ClearCartServlet extends HttpServlet {
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
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Delete all cart items for this user
            String sql = "DELETE FROM cart_items WHERE user_email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userEmail);
            pstmt.executeUpdate();
            
            // Clear session cart
            session.removeAttribute("cart");
            
            response.sendRedirect("userWelcome.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error clearing cart: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}