<%-- 
    Document   : login
    Created on : Mar 5, 2025, 12:29:11 AM
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>  
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h3><center>Register</center></h3>
        <form method="post" action="register">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your full name" required>

            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter password" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter email" required>

            <label for="phone">Phone number</label>
            <input type="phone" id="phone" name="phone" placeholder="Enter phone number" required>

            <label for ="department">Department</label>
            <select class="form-select" id="exampleFormControlSelect1" name="departmentId">
                <c:forEach items="${requestScope.dlist}" var="d">
                    <option value="${d.getDepartmentId()}">
                        ${d.getDepartmentName()}
                    </option>
                </c:forEach>
            </select>

            <input type="submit" value="Register">
            <a href="login">Already have an account? Login here</a>
        </form>

        <c:if test="${not empty message}">
        <center><h2 style="color: red">${message}</h2></center>
        </c:if>
        <c:if test="${not empty successMessage}">
        <script>
            window.onload = function () {
                alert("${successMessage}");
                window.location.href = "login"; // Chuyển hướng về trang login sau khi đăng ký
            };
        </script>
    </c:if>
</body>
</html>
<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #6a11cb, #2575fc);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    h3 {
        color: white;
        text-align: center;
        font-size: 28px;
        margin-bottom: 20px;
    }

    form {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        width: 400px;
        text-align: center;
    }

    label {
        display: block;
        margin: 15px 0 5px;
        font-weight: bold;
        font-size: 16px;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border: 2px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
    }

    input[type="submit"] {
        background: #6a11cb;
        color: white;
        border: none;
        padding: 12px;
        width: 100%;
        border-radius: 8px;
        font-size: 18px;
        cursor: pointer;
        transition: 0.3s;
        font-weight: bold;
    }

    input[type="submit"]:hover {
        background: #2575fc;
    }

    a {
        display: block;
        margin-top: 15px;
        text-decoration: none;
        color: #6a11cb;
        font-weight: bold;
        font-size: 16px;
    }

    a:hover {
        color: #2575fc;
    }

</style>

