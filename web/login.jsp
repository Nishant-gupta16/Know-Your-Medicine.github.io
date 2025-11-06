<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
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

        .message.password-mismatch {
            color: orange;
        }

        .registration-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .registration-link a {
            color: #2d9e8f;
            text-decoration: none;
            font-weight: bold;
        }

        .registration-link a:hover {
            text-decoration: underline;
        }

        .login-type-selector {
            display: flex;
            margin-bottom: 15px;
            border-radius: 8px;
            overflow: hidden;
            border: 2px solid #2d9e8f;
        }

        .login-type-selector button {
            flex: 1;
            padding: 8px;
            background: white;
            color: #2d9e8f;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-type-selector button.active {
            background: #2d9e8f;
            color: white;
        }

        .admin-login {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .admin-login-toggle {
            color: #2d9e8f;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            display: inline-block;
            margin-bottom: 10px;
        }

        .admin-login-toggle:hover {
            text-decoration: underline;
        }

        .hidden {
            display: none;
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
        <h1><i class="fas fa-capsules icon"></i> Know Your Medicine</h1>
        <p>Login to access personalized features.</p>
    </header>

    <!-- Login Form -->
    <section class="form-container">
        <div class="form-box">
            <h2><i class="fas fa-sign-in-alt icon"></i> Login</h2>

            <!-- Message display -->
            <div class="message">
                <!-- Dynamically populated based on URL parameters -->
                <script>
                    const urlParams = new URLSearchParams(window.location.search);
                    const message = urlParams.get('message');
                    const messageElement = document.querySelector('.message');

                    if (message === 'success') {
                        messageElement.textContent = 'Login successful!';
                        messageElement.classList.add('success');
                    } else if (message === 'error') {
                        messageElement.textContent = 'Invalid email or password.';
                        messageElement.classList.add('error');
                    } else if (message === 'password-mismatch') {
                        messageElement.textContent = 'Passwords do not match!';
                        messageElement.classList.add('password-mismatch');
                    }
                </script>
            </div>

            <div class="login-type-selector">
                <button id="userLoginBtn" class="active" onclick="toggleLoginType('user')">User</button>
                <button id="storeLoginBtn" onclick="toggleLoginType('store')">Store</button>
            </div>

            <form id="userLoginForm" action="login" method="POST">
                <label for="loginEmail">Email:</label>
                <input type="email" id="loginEmail" name="email" placeholder="Enter your email" required>

                <label for="loginPassword">Password:</label>
                <input type="password" id="loginPassword" name="password" placeholder="Enter your password" required>

                <button type="submit">Login</button>
            </form>

            <form id="storeLoginForm" action="login" method="POST" class="hidden">
                <label for="storeLoginEmail">Store Email:</label>
                <input type="email" id="storeLoginEmail" name="email" placeholder="Enter store email" required>

                <label for="storeLoginPassword">Password:</label>
                <input type="password" id="storeLoginPassword" name="password" placeholder="Enter your password" required>

                <button type="submit">Login as Store</button>
            </form>

            <div class="admin-login-toggle" onclick="toggleAdminLogin()">
                <i class="fas fa-user-shield"></i> Admin Login
            </div>

            <form id="adminLoginForm" action="login" method="POST" class="admin-login hidden">
                <label for="adminEmail">Admin Email:</label>
                <input type="email" id="adminEmail" name="email" placeholder="Enter admin email" required>

                <label for="adminPassword">Password:</label>
                <input type="password" id="adminPassword" name="password" placeholder="Enter admin password" required>

                <button type="submit" style="background: linear-gradient(145deg, #d32f2f, #b71c1c);">Login as Admin</button>
            </form>

            <!-- Registration Link -->
            <p class="registration-link">
                New here? <a href="registrationSelection.jsp">Register Now</a>
            </p>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

    <script>
        function toggleLoginType(type) {
            const userLoginBtn = document.getElementById('userLoginBtn');
            const storeLoginBtn = document.getElementById('storeLoginBtn');
            const userLoginForm = document.getElementById('userLoginForm');
            const storeLoginForm = document.getElementById('storeLoginForm');
            
            if (type === 'user') {
                userLoginBtn.classList.add('active');
                storeLoginBtn.classList.remove('active');
                userLoginForm.classList.remove('hidden');
                storeLoginForm.classList.add('hidden');
            } else {
                userLoginBtn.classList.remove('active');
                storeLoginBtn.classList.add('active');
                userLoginForm.classList.add('hidden');
                storeLoginForm.classList.remove('hidden');
            }
        }
        
        function toggleAdminLogin() {
            const adminLoginForm = document.getElementById('adminLoginForm');
            const adminLoginToggle = document.querySelector('.admin-login-toggle');
            
            if (adminLoginForm.classList.contains('hidden')) {
                adminLoginForm.classList.remove('hidden');
                adminLoginToggle.innerHTML = '<i class="fas fa-times"></i> Close Admin Login';
            } else {
                adminLoginForm.classList.add('hidden');
                adminLoginToggle.innerHTML = '<i class="fas fa-user-shield"></i> Admin Login';
            }
        }
    </script>
</body>
</html>