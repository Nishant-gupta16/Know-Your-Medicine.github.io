<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Know Your Medicine</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 600px;
            width: 90%;
        }
        .error-icon {
            font-size: 60px;
            color: #ff4d4d;
            margin-bottom: 20px;
        }
        .error-title {
            font-size: 24px;
            margin-bottom: 15px;
            color: #ff4d4d;
        }
        .error-message {
            margin-bottom: 25px;
            line-height: 1.6;
            padding: 15px;
            background-color: #ffeeee;
            border-radius: 4px;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: #2d9e8f;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin: 10px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #1e7a68;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1 class="error-title">Error Occurred</h1>
        <div class="error-message">
            <p><strong>${errorMessage}</strong></p>
            <p>We apologize for the inconvenience. Please try again later.</p>
            <% if (exception != null) { %>
                <p>Technical details: <%= exception.getMessage() %></p>
            <% } %>
        </div>
        <div>
            <a href="userWelcome.jsp" class="btn">Return to Home</a>
            <a href="javascript:history.back()" class="btn">Go Back</a>
        </div>
    </div>
</body>
</html>