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
                    .dashboard {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            padding: 20px;
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

        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4>Admin: ${sessionScope.user.getName()}</h4>
            <ul>
                <li><a href="adminDashboard">Bảng điều khiển</a></li>
                <li><a href="adminUserManagement">Quản lý người dùng</a></li>
            </ul>
            <a href="logout" class="logout-btn">Đăng xuất</a>
        </div>
        <div class="content">
            <h2>Bảng điều khiển</h2>

            <div class="dashboard">
                <div class="dashboard-item">
                    <h4>Tổng số người dùng</h4>
                    <p>${requestScope.totalUser} người</p>
                    <p class="info-tong">Tổng số người dùng được quản lý.</p>
                </div>
                <div class="dashboard-item">
                    <h4>Tổng số trưởng phòng</h4>
                    <p>${requestScope.dmUser} người</p>
                    <p class="info-tong">Tổng số trưởng phòng được quản lý.</p>
                </div>
                <div class="dashboard-item">
                    <h4>Tổng số trưởng nhóm</h4>
                    <p>${requestScope.glUser} người</p>
                    <p class="info-tong">Tổng số trưởng nhóm được quản lý.</p>
                </div>
                <div class="dashboard-item">
                    <h4>Tổng số nhân viên</h4>
                    <p>${requestScope.sUser} người</p>
                    <p class="info-tong">Tổng số nhân viên được quản lý.</p>
                </div>
            </div>
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
