import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userRegistration")
public class UserRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database Configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/medicine_db";
    private static final String DB_USER = "root"; // Replace with your MySQL username
    private static final String DB_PASSWORD = ""; // Replace with your MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate if password and confirm password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("userRegistration.jsp?message=password-mismatch");
            return;
        }

        // Database connection and user insertion
        try {
            // Ensure JDBC driver is loaded (optional as newer versions of Tomcat/JSP handle it automatically)
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, fullName);
                    preparedStatement.setString(2, email);
                    preparedStatement.setString(3, password);

                    // Execute the insert query
                    int rowsInserted = preparedStatement.executeUpdate();
                    if (rowsInserted > 0) {
                        response.sendRedirect("userRegistration.jsp?message=success");
                    } else {
                        response.sendRedirect("userRegistration.jsp?message=error");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            response.getWriter().println("Error: MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            response.getWriter().println("Database connection error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
