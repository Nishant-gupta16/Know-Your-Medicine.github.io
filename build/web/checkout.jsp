<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Know Your Medicine</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #2d9e8f;
            --secondary-color: #1e7a68;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --text-color: #333333;
            --error-color: #e74c3c;
            --success-color: #2ecc71;
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background-color: var(--light-bg);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 20px 0;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        header h1 {
            font-size: 28px;
        }
        
        .checkout-section {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .order-summary, .payment-form {
            flex: 1;
            min-width: 300px;
            background-color: var(--white);
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .section-title {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 22px;
            border-bottom: 2px solid var(--light-bg);
            padding-bottom: 10px;
        }
        
        .cart-item {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        
        .item-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .item-price {
            color: #666;
            font-size: 14px;
        }
        
        .order-total {
            font-size: 20px;
            font-weight: bold;
            text-align: right;
            margin: 20px 0;
            color: var(--primary-color);
        }
        
        .back-to-cart {
            display: inline-flex;
            align-items: center;
            color: var(--primary-color);
            text-decoration: none;
            margin-top: 15px;
        }
        
        .back-to-cart i {
            margin-right: 5px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        
        .form-group input, 
        .form-group textarea, 
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: inherit;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus, 
        .form-group textarea:focus, 
        .form-group select:focus {
            border-color: var(--primary-color);
            outline: none;
        }
        
        .payment-methods {
            margin: 20px 0;
        }
        
        .payment-method {
            margin-bottom: 15px;
        }
        
        .payment-method input[type="radio"] {
            margin-right: 10px;
        }
        
        .place-order-btn {
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            padding: 15px 30px;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        .place-order-btn:hover {
            background-color: var(--secondary-color);
        }
        
        .user-info-section {
            background-color: var(--white);
            padding: 20px;
            border-radius: 8px;
            margin: 0 auto 30px;
            max-width: 1200px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .user-info-title {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-size: 20px;
            border-bottom: 2px solid var(--light-bg);
            padding-bottom: 10px;
        }
        
        .error-message {
            color: var(--error-color);
            background-color: #fdecea;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: none;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            background-color: var(--primary-color);
            color: var(--white);
            margin-top: 40px;
        }
        
        @media (max-width: 768px) {
            .checkout-section {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <%
        // Get user data from session
        String userName = (String) session.getAttribute("userName");
        String userEmail = (String) session.getAttribute("userEmail");
        
        if (userName == null || userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get cart from session
        ArrayList<Map<String, Object>> cart = (ArrayList<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("userWelcome.jsp");
            return;
        }
        
        // Calculate cart total
        double cartTotal = 0;
        for (Map<String, Object> item : cart) {
            cartTotal += (double) item.get("medicinePrice") * (int) item.get("quantity");
        }
        
        // Check for error message
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>

    <header>
        <div class="container">
            <h1>Checkout</h1>
        </div>
    </header>

    <div class="container">
        <!-- Display error message if any -->
        <% if (errorMessage != null) { %>
            <div class="error-message" id="errorMessage">
                <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
            </div>
            
            <script>
                // Show error message
                document.getElementById('errorMessage').style.display = 'block';
                
                // Hide error message after 5 seconds
                setTimeout(function() {
                    document.getElementById('errorMessage').style.display = 'none';
                }, 5000);
            </script>
        <% } %>

        <!-- User Information Section -->
        <div class="user-info-section">
            <h3 class="user-info-title">Customer Information</h3>
            <p><strong>Name:</strong> <%= userName %></p>
            <p><strong>Email:</strong> <%= userEmail %></p>
        </div>

        <div class="checkout-section">
            <div class="order-summary">
                <h2 class="section-title">Order Summary</h2>
                <% for (Map<String, Object> item : cart) { %>
                    <div class="cart-item">
                        <div>
                            <div class="item-name"><%= item.get("medicineName") %></div>
                            <div class="item-price">₹<%= String.format("%.2f", item.get("medicinePrice")) %> × <%= item.get("quantity") %></div>
                        </div>
                        <div>₹<%= String.format("%.2f", (double) item.get("medicinePrice") * (int) item.get("quantity")) %></div>
                    </div>
                <% } %>
                <div class="order-total">
                    Total: ₹<%= String.format("%.2f", cartTotal) %>
                </div>
                <a href="userWelcome.jsp" class="back-to-cart"><i class="fas fa-arrow-left"></i> Back to Cart</a>
            </div>
            
            <div class="payment-form">
                <h2 class="section-title">Shipping & Payment</h2>
                <form id="checkoutForm" action="PlaceOrderServlet" method="POST" onsubmit="return validateForm()">
                    <input type="hidden" name="totalAmount" value="<%= cartTotal %>">
                    <input type="hidden" name="userEmail" value="<%= userEmail %>">
                    
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" value="<%= userName %>" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Shipping Address</label>
                        <textarea id="address" name="address" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                    <div class="form-group">
                        <label for="state">State</label>
                        <input type="text" id="state" name="state" required>
                    </div>
                    <div class="form-group">
                        <label for="zip">ZIP Code</label>
                        <input type="text" id="zip" name="zip" required pattern="[0-9]{6}" title="6-digit ZIP code">
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" required pattern="[0-9]{10}" title="10-digit phone number">
                    </div>
                    
                    <h3 class="section-title">Payment Method</h3>
                    <div class="payment-methods">
                        <div class="payment-method">
                            <input type="radio" id="cod" name="paymentMethod" value="COD" checked>
                            <label for="cod">Cash on Delivery</label>
                        </div>
                        <div class="payment-method">
                            <input type="radio" id="card" name="paymentMethod" value="Card">
                            <label for="card">Credit/Debit Card</label>
                        </div>
                        <div class="payment-method" id="card-details" style="display:none;">
                            <div class="form-group">
                                <label for="cardNumber">Card Number</label>
                                <input type="text" id="cardNumber" name="cardNumber" pattern="[0-9]{16}" title="16-digit card number">
                            </div>
                            <div class="form-group">
                                <label for="expiry">Expiry Date</label>
                                <input type="text" id="expiry" name="expiry" placeholder="MM/YY" pattern="(0[1-9]|1[0-2])\/[0-9]{2}" title="MM/YY format">
                            </div>
                            <div class="form-group">
                                <label for="cvv">CVV</label>
                                <input type="text" id="cvv" name="cvv" pattern="[0-9]{3}" title="3-digit CVV">
                            </div>
                        </div>
                    </div>
                    
                    <button type="submit" class="place-order-btn">
                        <i class="fas fa-shopping-bag"></i> Place Order
                    </button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 Know Your Medicine. All rights reserved.
    </footer>

    <script>
        // Show/hide card details based on payment method selection
        document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const cardDetails = document.getElementById('card-details');
                if (this.value === 'Card') {
                    cardDetails.style.display = 'block';
                    // Make card fields required
                    document.getElementById('cardNumber').required = true;
                    document.getElementById('expiry').required = true;
                    document.getElementById('cvv').required = true;
                } else {
                    cardDetails.style.display = 'none';
                    // Make card fields not required
                    document.getElementById('cardNumber').required = false;
                    document.getElementById('expiry').required = false;
                    document.getElementById('cvv').required = false;
                }
            });
        });
        
        // Form validation
        function validateForm() {
            const form = document.getElementById('checkoutForm');
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            
            if (paymentMethod === 'Card') {
                const cardNumber = document.getElementById('cardNumber').value;
                const expiry = document.getElementById('expiry').value;
                const cvv = document.getElementById('cvv').value;
                
                // Simple card validation
                if (!/^\d{16}$/.test(cardNumber)) {
                    alert('Please enter a valid 16-digit card number');
                    return false;
                }
                
                if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) {
                    alert('Please enter expiry date in MM/YY format');
                    return false;
                }
                
                if (!/^\d{3}$/.test(cvv)) {
                    alert('Please enter a valid 3-digit CVV');
                    return false;
                }
            }
            
            return true;
        }
        
        // Format phone number input
        document.getElementById('phone').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        // Format ZIP code input
        document.getElementById('zip').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    </script>
</body>
</html>