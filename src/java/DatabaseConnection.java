import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/medicine_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Method to establish and return a database connection
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found. Make sure you have added MySQL connector JAR.", e);
        } catch (SQLException e) {
            throw new SQLException("Unable to connect to the database. Check your URL, username, or password.", e);
        }
        return connection;
    }

    // Method to close the database connection
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error while closing the connection: " + e.getMessage());
            }
        }
    }
}