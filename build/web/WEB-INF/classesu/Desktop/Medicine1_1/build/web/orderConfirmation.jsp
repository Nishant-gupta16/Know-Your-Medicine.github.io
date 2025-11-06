<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - Know Your Medicine</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #2d9e8f;
            --secondary-color: #1e7a68;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --text-color: #333333;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background-color: var(--light-bg);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .confirmation-container {
            flex: 1;
            width: 90%;
            max-width: 800px;
            margin: 50px auto;
            background: var(--white);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .confirmation-icon {
            font-size: 80px;
            color: var(--primary-color);
            margin-bottom: 25px;
            animation: bounce 1s ease infinite alternate;
        }
        
        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-10px); }
        }
        
        .confirmation-title {
            font-size: 32px;
            margin-bottom: 20px;
            color: var(--primary-color);
        }
        
        .order-id {
            font-size: 22px;
            margin: 30px 0;
            padding: 15px;
            background-color: #f0f0f0;
            border-radius: 6px;
            display: inline-block;
            border-left: 4px solid var(--primary-color);
        }
        
        .confirmation-message {
            margin-bottom: 30px;
            line-height: 1.8;
            font-size: 18px;
        }
        
        .btn-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 15px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            min-width: 200px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }
        
        .btn-secondary {
            background-color: var(--white);
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }
        
        .btn-secondary:hover {
            background-color: var(--light-bg);
        }
        
        .btn i {
            margin-right: 10px;
        }
        
        .order-details-link {
            margin-top: 30px;
            font-size: 16px;
        }
        
        .order-details-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
        }
        
        .order-details-link a:hover {
            text-decoration: underline;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            background-color: var(--primary-color);
            color: var(--white);
        }
        
        @media (max-width: 600px) {
            .confirmation-container {
                padding: 30px 20px;
                width: 95%;
            }
            
            .confirmation-title {
                font-size: 26px;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h1 class="confirmation-title">Order Confirmed!</h1>
        <p class="confirmation-message">
            Thank you for your purchase, <%= session.getAttribute("userName") %>!<br>
            Your order has been successfully placed and is being processed.<br>
            A confirmation email has been sent to <strong><%= session.getAttribute("userEmail") %></strong>.
        </p>
        <div class="order-id">
            Order ID: <strong><%= request.getParameter("orderId") %></strong>
        </div>
        
        <div class="btn-container">
            <a href="userWelcome.jsp" class="btn btn-primary">
                <i class="fas fa-shopping-bag"></i> Continue Shopping
            </a>
            <a href="orderHistory.jsp" class="btn btn-secondary">
                <i class="fas fa-history"></i> View Order History
            </a>
        </div>
        
        <div class="order-details-link">
            Need help? <a href="contact.jsp">Contact our support team</a>
        </div>
    </div>

    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>
</body>
</html>