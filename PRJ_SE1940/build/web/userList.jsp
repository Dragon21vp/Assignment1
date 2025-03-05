<%-- 
    Document   : userList
    Created on : Mar 5, 2025, 12:33:33 AM
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management </title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    </head>
    <body>
        <h2>User Management</h2>

        <!-- Logout & Add User Buttons -->
        <div class="top-buttons">
            <a href="userAdd.jsp" class="add-btn">
                <i class="fas fa-user-plus"></i> Add User
            </a>

            <form action="logout" method="get">
                <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userId}">
                <button type="submit" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>

        <table>
            <tr>
                <th>UserID</th>
                <th>Name</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <c:forEach var="user" items="${ulist}">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.name}</td>
                    <td>${user.role}</td>
                    <td>
                        <!-- Edit Button -->
                        <form action="userManagement?action=edit" method="post" style="display:inline;">
                            <input type="hidden" name="userId" value="${user.userId}">
                            <button type="submit" class="icon-btn edit-btn">
                                <i class="fas fa-edit"></i>
                            </button>
                        </form>

                        <!-- Delete Button -->
                        <form action="userManagement?action=delete" method="post" style="display:inline;">
                            <input type="hidden" name="userId" value="${user.userId}">
                            <button type="submit" class="icon-btn delete-btn">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        text-align: center;
        margin: 20px;
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
    }

    .top-buttons {
        display: flex;
        justify-content: space-between;
        width: 80%;
        margin: auto;
        padding-bottom: 10px;
    }

    .top-buttons form {
        display: inline;
    }

    table {
        width: 80%;
        margin: auto;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        border-radius: 12px;
        overflow: hidden;
    }

    th, td {
        padding: 14px;
        border-bottom: 1px solid #ddd;
        text-align: center;
        font-size: 16px;
    }

    th {
        background: #007bff;
        color: white;
        text-transform: uppercase;
        font-weight: bold;
    }

    tr:hover {
        background: #f8f9fa;
        transition: 0.3s ease-in-out;
    }

    .icon-btn {
        background: none;
        border: none;
        cursor: pointer;
        font-size: 18px;
        margin: 5px;
    }

    .edit-btn {
        color: #ffc107;
    }

    .delete-btn {
        color: #dc3545;
    }

    .logout-btn {
        background: #dc3545;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        transition: 0.3s;
    }

    .logout-btn:hover {
        background: #c82333;
    }

    .add-btn {
        background: #28a745;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
        transition: 0.3s;
        text-decoration: none;
    }

    .add-btn:hover {
        background: #218838;
    }
</style>
