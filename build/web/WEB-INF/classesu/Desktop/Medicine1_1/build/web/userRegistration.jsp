<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesome for icons -->
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

        /* Home Button Styling */
        .home-button {
            position: absolute;
            top: 20px;
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

        .message.password-mismatch {
            color: orange;
        }
    </style>
</head>
<body>

    <!-- Go to Home Button -->
    <form action="index.jsp" method="POST" style="display: inline;">
        <button type="submit" class="home-button">
            <i class="fas fa-home icon"></i> Go to Home
        </button>
    </form>

    <!-- Header Section -->
    <header>
        <h1><i class="fas fa-user-plus icon"></i> User Registration</h1>
        <p>Fill out the form to create a user account.</p>
    </header>

    <!-- Registration Form -->
    <section class="form-container">
        <div class="form-box">
            <h2><i class="fas fa-user icon"></i> Register User</h2>

            <!-- Message display -->
            <div class="message">
                <!-- Dynamically populated based on URL parameters -->
                <script>
                    const urlParams = new URLSearchParams(window.location.search);
                    const message = urlParams.get('message');
                    const messageElement = document.querySelector('.message');

                    if (message === 'success') {
                        messageElement.textContent = 'Registration successful! Please log in.';
                        messageElement.classList.add('success');
                    } else if (message === 'error') {
                        messageElement.textContent = 'An error occurred. Please try again.';
                        messageElement.classList.add('error');
                    } else if (message === 'password-mismatch') {
                        messageElement.textContent = 'Passwords do not match!';
                        messageElement.classList.add('password-mismatch');
                    }
                </script>
            </div>

            <form action="UserRegistrationServlet" method="POST">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>

                <button type="submit">Register</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

</body>
</html>
