<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
        }

        header {
            text-align: center;
            padding: 15px 20px; /* Reduced padding for a tighter header */
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            margin-bottom: 0; /* Remove gap below header */
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #2d9e8f;
            color: white;
            position: fixed;
            width: 100%;
            bottom: 0;
            box-shadow: 0 -5px 15px rgba(0, 0, 0, 0.2);
            font-size: 14px;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding: 20px;
            width: 100%;
            box-sizing: border-box;
        }

        .form-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 400px;
            text-align: center;
            margin-top: 20px; /* Bring the form closer to the header */
        }

        .form-box h2 {
            margin-bottom: 15px; /* Reduced margin for a tighter heading */
        }

        .form-box label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-box input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid #2d9e8f;
            border-radius: 8px;
        }

        .form-box button {
            width: 100%;
            padding: 10px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .form-box button:hover {
            background: linear-gradient(145deg, #1e7a68, #2d9e8f);
            transform: translateY(-2px);
        }

        /* Go to Home Button */
        .home-button {
            position: absolute;
            top: 15px;
            left: 20px;
            padding: 10px 20px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .home-button:hover {
            background: linear-gradient(145deg, #1e7a68, #2d9e8f);
            transform: translateY(-2px);
        }

        /* Message Styling */
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 16px;
            text-align: center;
            width: 90%;
            max-width: 400px;
        }

        .success {
            background-color: #4caf50;
            color: white;
        }

        .error {
            background-color: #f44336;
            color: white;
        }

        .password-mismatch {
            background-color: #ff9800;
            color: white;
        }

    </style>
</head>
<body>

    <!-- Back Button -->
    <form action="index.jsp" method="POST" style="display: inline;">
        <button type="submit" class="home-button">Go to Home</button>
    </form>

    <!-- Header Section -->
    <header>
        <h1><i class="fas fa-store icon"></i> Store Registration</h1>
        <p>Fill out the form to register your store.</p>
    </header>

    <!-- Display Success/Error Messages -->
    <div class="form-container">
        <% if (request.getParameter("message") != null) { %>
            <div class="message 
                <%= request.getParameter("message").equals("success") ? "success" : 
                    request.getParameter("message").equals("password-mismatch") ? "password-mismatch" : "error" %>">
                <%= request.getParameter("message").equals("success") ? "Registration Successful!" : 
                    request.getParameter("message").equals("password-mismatch") ? "Error: Passwords do not match." : 
                    "Error: Registration failed. Please try again." %>
            </div>
        <% } %>
    </div>

    <!-- Registration Form -->
    <section class="form-container">
        <div class="form-box">
            <h2><i class="fas fa-store icon"></i> Register Store</h2>
            <form action="storeRegistration" method="POST">
                <label for="storeName">Store Name:</label>
                <input type="text" id="storeName" name="storeName" placeholder="Enter store name" required>

                <label for="storeEmail">Store Email:</label>
                <input type="email" id="storeEmail" name="storeEmail" placeholder="Enter store email" required>

                <label for="storeLocation">Location:</label>
                <input type="text" id="storeLocation" name="storeLocation" placeholder="Enter store location" required>

                <label for="storeContact">Contact Number:</label>
                <input type="text" id="storeContact" name="storeContact" placeholder="Enter contact number" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>

                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>

                <button type="submit">Register Store</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

</body>
</html>
