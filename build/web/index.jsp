<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Know Your Medicine</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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
            margin: 10px;
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
        }

        #map-button {
            display: block;
            margin: 20px auto;
            padding: 15px 30px;
            font-size: 18px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease, transform 0.3s ease;
        }

        #map-button:hover {
            background: linear-gradient(145deg, #1e7a68, #2d9e8f);
            transform: translateY(-2px);
        }

        #search-section {
            text-align: center;
            margin-top: 20px;
        }

        #search-section input {
            padding: 10px;
            font-size: 16px;
            width: 300px;
            border-radius: 8px;
            border: 2px solid #2d9e8f;
        }

        #search-section button {
            padding: 10px 20px;
            font-size: 16px;
            margin-top: 10px;
            border-radius: 8px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            border: none;
            cursor: pointer;
        }

        #medical-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 30px;
        }

        .medical-symbol {
            font-size: 80px;
            color: #2d9e8f;
        }

        .icon {
            margin-right: 8px;
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

        .login-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background: linear-gradient(145deg, #2d9e8f, #1e7a68);
            color: white;
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .login-button:hover {
            background: linear-gradient(145deg, #1e7a68, #2d9e8f);
            transform: translateY(-2px);
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: 50px;
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
    <div style="position: absolute; top: 20px; right: 20px;">
        <% 
        String userName = (String) session.getAttribute("userName");
        String userType = (String) session.getAttribute("userType");
        if (userName != null && !userName.isEmpty()) {
            String firstInitial = userName.substring(0, 1).toUpperCase();
        %>
            <button class="profile-button" onclick="toggleDropdown()"><%= firstInitial %></button>
            <div id="profileDropdown" class="dropdown-content">
                <a href="<%= "user".equals(userType) ? "userWelcome.jsp" : "storeWelcome.jsp" %>">
                    <i class="fas fa-user"></i> Profile
                </a>
                <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        <% } else { %>
            <button class="login-button" onclick="window.location.href='login.jsp'">
                <i class="fas fa-user icon"></i> Login
            </button>
        <% } %>
    </div>

    <header>
        <h1><i class="fas fa-capsules icon"></i> Know Your Medicine</h1>
        <p>Find detailed information about medicines and their uses.</p>
    </header>

    <button id="map-button" onclick="findNearbyMedicalStoresHospitals()">
        <i class="fas fa-map-marker-alt icon"></i> Find Nearby Medical Stores & Hospitals
    </button>

    <section id="search-section">
        <form action="search" method="GET" id="searchForm">
            <input type="text" name="query" id="medicineSearch" placeholder="Search for a medicine...">
            <button type="submit"><i class="fas fa-search icon"></i> Search</button>
        </form>
    </section>

    <section id="medical-section">
        <div class="medical-symbol">
            <i class="fas fa-stethoscope"></i>
        </div>
        <p>Explore reliable medical information here!</p>
    </section>

    <footer>
        <p>&copy; 2025 Know Your Medicine. All rights reserved.</p>
    </footer>

    <script>
        document.getElementById('searchForm').onsubmit = function(event) {
            const query = document.getElementById('medicineSearch').value.trim();
            if (!query) {
                event.preventDefault();
                alert('Please enter a medicine name.');
            }
        };

        function findNearbyMedicalStoresHospitals() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    const googleMapsUrl = `https://www.google.com/maps/search/medical+store+or+hospital+near+me/@${latitude},${longitude},15z`;
                    window.open(googleMapsUrl, '_blank');
                }, function(error) {
                    switch(error.code) {
                        case error.PERMISSION_DENIED:
                            alert("Location access denied. Please enable location permissions to use this feature.");
                            break;
                        case error.POSITION_UNAVAILABLE:
                            alert("Location information is unavailable.");
                            break;
                        case error.TIMEOUT:
                            alert("The request to get user location timed out.");
                            break;
                        case error.UNKNOWN_ERROR:
                            alert("An unknown error occurred.");
                            break;
                    }
                });
            } else {
                alert('Geolocation is not supported by your browser.');
            }
        }

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