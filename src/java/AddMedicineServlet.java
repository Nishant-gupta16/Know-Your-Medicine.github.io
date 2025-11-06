import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddMedicineServlet")
public class AddMedicineServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/medicine_db";
    private static final String DB_USER = "root";  
    private static final String DB_PASSWORD = "";  

    private Connection conn;
    private PreparedStatement stmt;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Handle GET request to display available medicines
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Medicine> medicines = getMedicinesFromDB();
        request.setAttribute("medicines", medicines);
        request.getRequestDispatcher("storeWelcome.jsp").forward(request, response);
    }

    // Handle POST request (form submission)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String medicineName = request.getParameter("medicineName");
        double price = Double.parseDouble(request.getParameter("price"));

        String sql = "INSERT INTO storemedicines (name, price) VALUES (?, ?)";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, medicineName);
            stmt.setDouble(2, price);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                request.setAttribute("message", "Medicine added successfully!");
                request.setAttribute("medicineName", medicineName);
                request.setAttribute("price", price);
            } else {
                request.setAttribute("message", "Failed to add medicine.");
            }

            // Fetch updated list of medicines
            List<Medicine> medicines = getMedicinesFromDB();
            request.setAttribute("medicines", medicines);

            // Forward to storeWelcome.jsp to show updated data
            request.getRequestDispatcher("storeWelcome.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("storeWelcome.jsp").forward(request, response);
        }
    }

    // Method to fetch medicines from the database
    private List<Medicine> getMedicinesFromDB() {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT * FROM storemedicines";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                medicines.add(new Medicine(name, price));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medicines;
    }

    public void destroy() {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper class to represent a medicine
    private static class Medicine {
        String name;
        double price;

        public Medicine(String name, double price) {
            this.name = name;
            this.price = price;
        }

        public String getName() {
            return name;
        }

        public double getPrice() {
            return price;
        }
    }
}           