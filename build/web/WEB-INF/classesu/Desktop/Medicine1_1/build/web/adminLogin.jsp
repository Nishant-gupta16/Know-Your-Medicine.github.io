<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Know Your Medicine</title>
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
            padding: 20px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
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
            justify-content: center;
            height: 80vh;
        }

        .form-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
        }

        .form-box h2 {
            margin-bottom: 20px;
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

        /* Back Button Styling */
        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            width: auto;
            padding: 10px 20px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .back-button:hover {
            background: linear-gradient(145deg, #1e7a68, #2d9e8f);
            transform: translateY(-2px);
        }

        /* Message Styling */
        .message {
            margin-top: 20px;
            font-size: 16px;
            font-weight: bold;
        }

        .message.success {
            color: green;
        }

        .message.error {
            color: red;
        }
    </style>
</head>
<body>

    <!-- Back Button -->
    <button class="back-button" onclick="window.location.href='index.jsp'">
        <i class="fas fa-arrow-left icon"></i> Back
    </button>

    <!-- Header Section -->
    <header>
        <h1><i class="fas fa-capsules icon"></i> Admin Login</h1>
        <p>Access the administration panel</p>
    </header>

    <!-- Login Form -->
    <section class="form-container">
        <div class="form-box">
            <h2><i class="fas fa-lock icon"></i> Admin Login</h2>

            <!-- Message display -->
            <div class="message">
                <% if (request.getParameter("error") != null) { %>
                    <div class="message error">Invalid admin credentials</div>
                <% } %>
            </div>

            <form action="adminLogin" method="POST">
                <label for="username">Admin Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter admin username" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <button type="submit">Login</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>
</body>
</html>