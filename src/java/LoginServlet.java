import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/medicine_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check admin table first
            String sqlAdmin = "SELECT * FROM admins WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sqlAdmin);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String adminName = rs.getString("name");
                session.setAttribute("userName", adminName);
                session.setAttribute("userEmail", email);
                session.setAttribute("userType", "admin");
                response.sendRedirect("adminDashboard.jsp");
                return;
            }

            // Check users table
            String sqlUser = "SELECT * FROM users WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sqlUser);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String fullName = rs.getString("full_name");
                session.setAttribute("userName", fullName);
                session.setAttribute("userEmail", email);
                session.setAttribute("userType", "user");
                response.sendRedirect("userWelcome.jsp");
                return;
            }

            // Check stores table
            String sqlStore = "SELECT * FROM stores WHERE store_email = ? AND password = ?";
            pstmt = conn.prepareStatement(sqlStore);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storeName = rs.getString("store_name");
                session.setAttribute("userName", storeName);
                session.setAttribute("userType", "store");
                response.sendRedirect("storeWelcome.jsp");
            } else {
                response.sendRedirect("login.jsp?message=error");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
}