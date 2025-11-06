<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
            position: relative;
        }

        header {
            text-align: center;
            padding: 20px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            margin: 10px;
        }

        .welcome-container {
            text-align: center;
            margin-top: 50px;
        }

        .welcome-container h2 {
            font-size: 24px;
        }

        .welcome-container p {
            font-size: 18px;
            margin: 20px 0;
        }

        .medicine-form {
            margin-top: 30px;
            text-align: center;
        }

        .input-field {
            padding: 10px;
            margin: 10px;
            width: 250px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .add-button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .add-button:hover {
            background-color: #218838;
        }

        .logout-button {
            background-color: #ff4d4d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .logout-button:hover {
            background-color: #e04d4d;
        }

        .home-button {
            background-color: green;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
        }

        .home-button:hover {
            background-color: #4caf50;
        }

        .button-container {
            margin-top: 30px;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #2d9e8f;
            color: white;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        .medicine-details {
            font-size: 18px;
            margin-top: 20px;
        }

        .profile-button {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease, transform 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-button:hover {
            background: linear-gradient(145deg, #1e7a68, #2d9e8f);
            transform: translateY(-2px);
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: 70px;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 8px;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            border-radius: 8px;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .show {
            display: block;
        }
    </style>
</head>
<body>
    <!-- Profile Button -->
    <div style="position: absolute; top: 20px; right: 20px;">
        <% 
        String userName = (String) session.getAttribute("userName");
        if (userName != null && !userName.isEmpty()) {
            String firstInitial = userName.substring(0, 1).toUpperCase();
        %>
            <button class="profile-button" onclick="toggleDropdown()"><%= firstInitial %></button>
            <div id="profileDropdown" class="dropdown-content">
                <a href="storeWelcome.jsp"><i class="fas fa-user"></i> Profile</a>
                <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        <% } %>
    </div>

    <!-- Header Section -->
    <header>
        <h1>Welcome to Know Your Medicine</h1>
    </header>

    <!-- Welcome Message Section -->
    <section class="welcome-container">
        <h2>Welcome, <%= userName != null ? userName : "Store User" %>!</h2>
        <p>Manage your store and products, and view your sales analytics.</p>

        <!-- Medicine Add Form -->
        <div class="medicine-form">
            <h3>Add New Medicine</h3>
            <form action="AddMedicineServlet" method="POST">
                <input type="text" name="medicineName" class="input-field" placeholder="Enter Medicine Name" required><br>
                <input type="number" name="price" class="input-field" placeholder="Enter Price" required><br>
                <button type="submit" class="add-button">Add Medicine</button>
            </form>
        </div>

        <!-- Show Success or Error Message -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println("<div class='message'>" + message + "</div>");
            }
        %>

        <% 
            // Show the added medicine details if available
            String medicineName = (String) request.getAttribute("medicineName");
            Double price = (Double) request.getAttribute("price");
            if (medicineName != null && price != null) {
        %>
            <div class="medicine-details">
                <h4>Added Medicine:</h4>
                <p>Name: <%= medicineName %></p>
                <p>Price: <%= price %></p>
            </div>
        <% 
            }
        %>

        <!-- Buttons -->
        <div class="button-container">
            <form action="index.jsp" method="POST" style="display: inline;">
                <button type="submit" class="home-button">Go to Home</button>
            </form>

            <form action="logout" method="POST" style="display: inline;">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

    <script>
        function toggleDropdown() {
            document.getElementById("profileDropdown").classList.toggle("show");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.profile-button')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</body>
</html>