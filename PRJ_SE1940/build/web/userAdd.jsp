<%-- 
    Document   : userAdd
    Created on : Mar 5, 2025, 1:13:01 AM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New User</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                margin: 20px;
            }

            .container {
                width: 50%;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            h2 {
                color: #333;
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: bold;
                text-align: left;
                margin: 10px 0 5px;
            }

            input, select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .btn-container {
                display: flex;
                justify-content: space-between;
            }

            .btn {
                width: 48%;
                padding: 10px;
                font-size: 16px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                transition: 0.3s;
            }

            .submit-btn {
                background: #28a745;
                color: white;
            }

            .submit-btn:hover {
                background: #218838;
            }

            .cancel-btn {
                background: #dc3545;
                color: white;
            }

            .cancel-btn:hover {
                background: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Add New User</h2>
            <form action="userManagement?action=add" method="post">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="0">Admin</option>
                    <option value="1">User</option>
                </select>

                <div class="btn-container">
                    <button type="submit" class="btn submit-btn">
                        <i class="fas fa-user-plus"></i> Add User
                    </button>
                    <a href="userManagement" class="btn cancel-btn">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </body>
</html>

