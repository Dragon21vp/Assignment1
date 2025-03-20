<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý người dùng</title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="styles.css"> <!-- Đảm bảo bạn có file CSS riêng -->
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- SweetAlert -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <style>
            body {
                display: flex;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: #343a40;
                color: white;
                padding: 20px;
                position: fixed;
                left: 0;
                top: 0;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
            }
            .sidebar ul li {
                padding: 10px 0;
            }
            .sidebar ul li a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px;
                border-radius: 5px;
            }
            .sidebar ul li a:hover {
                background: #495057;
            }
            .logout-btn {
                background: #dc3545;
                color: white;
                display: block;
                text-align: center;
                margin-top: 20px;
                padding: 10px;
                border-radius: 5px;
                text-decoration: none;
            }
            .logout-btn:hover {
                background: #c82333;
            }
            .content {
                margin-left: 270px;
                padding: 20px;
                width: 100%;
            }
            .dashboard-item {
                background: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .dashboard-item:hover {
                transform: translateY(-5px);
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
            }

            .dashboard-item h4 {
                font-size: 18px;
                color: #343a40;
                margin-bottom: 10px;
            }

            .dashboard-item p {
                font-size: 20px;
                font-weight: bold;
                color: #007bff;
            }

            .dashboard-item .info-tong {
                font-size: 14px;
                color: #6c757d;
            }
            .dashboard {
                display: flex;
                justify-content: space-between; /* Căn đều các phần tử */
                flex-wrap: wrap; /* Nếu không đủ chỗ, các item sẽ tự xuống hàng */
                gap: 20px; /* Khoảng cách giữa các phần tử */
            }

            .dashboard-item {
                flex: 1; /* Để các item có cùng kích thước */
                min-width: 200px; /* Đảm bảo không bị quá nhỏ khi thu hẹp */
            }
            form {
                margin-bottom: 20px;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* Style cho label và select */
            label {
                font-weight: bold;
                color: #333;
            }

            select, button {
                padding: 6px 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                background-color: #28a745; /* Xanh lá cây đậm */
                color: white;
                cursor: pointer;
                transition: background 0.3s;
            }

            button:hover {
                background-color: #218838; /* Xanh lá cây tối hơn */
            }

            /* Style bảng */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 8px;
                text-align: center;
                border: 1px solid #ddd;
            }

            th {
                background-color: #28a745; /* Xanh lá cây đậm */
                color: white;
            }

            /* Màu sắc cho ô nghỉ và đi làm */
            .absent {
                background-color: #ff9999; /* Màu đỏ dịu */
            }

            .present {
                background-color: #b2f2bb; /* Màu xanh lá cây dịu */
            }

            /* Hiệu ứng hover */
            tr:hover {
                background-color: #f1f1f1;
            }

        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4>User: ${sessionScope.user.getName()}</h4>
            <ul>
               
                <li><a href="userApplication">Đơn của tôi</a></li>
                    <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">
                    
                    <li><a href="userApplicationManagement">Quản lý đơn</a></li>
                    <li><a href="statistic">Bảng dữ liệu</a></li>
                    </c:if>
            </ul>
            <a href="logout" class="logout-btn">Đăng xuất</a>
        </div>
        <div class="content">
            <form method="get" action="statistic">
                <label>Chọn tháng:</label>
                <select name="month">
                    <c:forEach var="m" begin="1" end="12">
                        <option value="${m}" ${m == month ? 'selected' : ''}>${m}</option>
                    </c:forEach>
                </select>

                <label>Chọn năm:</label>
                <select name="year">
                    <c:forEach var="y" begin="2020" end="2030">
                        <option value="${y}" ${y == year ? 'selected' : ''}>${y}</option>
                    </c:forEach>
                </select>

                <button type="submit">Xem lịch nghỉ</button>
            </form>
            <h2>Thống kê nghỉ làm tháng ${month}/${year}</h2>
            <table>
                <thead>
                    <tr>
                        <th>Nhân viên</th>
                            <c:forEach var="day" begin="1" end="${daysInMonth}">
                            <th>${day}</th>
                            </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.name}</td>
                            <c:forEach var="day" begin="1" end="${daysInMonth}">
                                <c:set var="isAbsent" value="${userAbsentDays[user.userId] ne null && userAbsentDays[user.userId].contains(day)}"/>
                                <td class="${isAbsent ? 'absent' : 'present'}"></td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>



        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#userTable').DataTable();
            });

        </script>
    </body>
</html>
