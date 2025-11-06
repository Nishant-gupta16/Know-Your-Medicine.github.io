import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class MedicineServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("query");  // Get search query from user input

        // Handle empty or null query
        if (query == null || query.trim().isEmpty()) {
            response.getWriter().write("Please provide a valid search query.");
            return;
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        List<Medicine> medicines = new ArrayList<>();

        try {
            connection = DatabaseConnection.getConnection(); 
            String sql = "SELECT * FROM medicines WHERE name LIKE ?"; // SQL Query
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, "%" + query + "%"); // Set search query
            resultSet = preparedStatement.executeQuery();

            // Fetch data into Medicine objects
            while (resultSet.next()) {
                Medicine medicine = new Medicine(
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getString("dosage"),
                        resultSet.getString("side_effects"),
                        resultSet.getString("benefits"),
                        resultSet.getDouble("price")
                );
                medicines.add(medicine);
            }

            // Set attribute for JSP page
            request.setAttribute("medicines", medicines);
            request.getRequestDispatcher("/result.jsp").forward(request, response);

        } catch (SQLException e) {
            response.getWriter().write("Error connecting to database: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection); // Close DB connection
        }
    }
}
