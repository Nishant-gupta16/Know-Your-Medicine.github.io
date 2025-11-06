<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Selection</title>
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

        /* Selection Section */
        .selection-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 80vh;
        }

        .selection-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: center;
        }

        .selection-box h2 {
            margin-bottom: 20px;
        }

        .selection-box button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .selection-box button:hover {
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

    </style>
</head>
<body>

    <!-- Back Button -->
    <button class="back-button" onclick="window.history.back()">
        <i class="fas fa-arrow-left icon"></i> Back
    </button>

    <!-- Header Section -->
    <header>
        <h1><i class="fas fa-user-plus icon"></i>Registration Selection</h1>
        <p>Please select the type of registration.</p>
    </header>

    <!-- Selection Section -->
    <section class="selection-container">
        <div class="selection-box">
            <h2><i class="fas fa-users icon"></i>Choose Registration Type</h2>

            <button onclick="window.location.href='userRegistration.jsp'">
                <i class="fas fa-user icon"></i> User Registration
            </button>

            <button onclick="window.location.href='storeRegistration.jsp'">
                <i class="fas fa-store icon"></i> Store Registration
            </button>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

</body>
</html>
