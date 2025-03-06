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
        <title>Login</title>
    </head>
    <body>
        <h3><center>Login</center></h3>
        <form method="post" action="login">

            <label for="username">Username</label>
            <input type="text" id="username"  name="username" value="${cookie.cuser.value}" placeholder="Username" required>

            <label for="password">Password</label>
            <input type="password" id="password"   name="password" value="${cookie.cpass.value}" placeholder="Password" required>


            <input type="checkbox"
                   ${cookie.crem!=null?'checked':''}
                   name="rem" value="ON"/> Remember me<br/>
            <input type="submit" value="Login"></p>
            <a href="register">Register</a>

        </form>		
        <c:if test="${not empty ms}">
        <center><h2 style="color: red">${ms}</h2></center>
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
    width: 400px; /* ✅ Tăng kích thước form */
    text-align: center;
}

label {
    display: block;
    margin: 15px 0 5px;
    font-weight: bold;
    font-size: 16px; /* ✅ Tăng kích thước chữ */
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

input[type="checkbox"] {
    margin-right: 5px;
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

