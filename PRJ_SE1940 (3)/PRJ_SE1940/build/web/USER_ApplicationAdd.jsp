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
            /* Căn chỉnh form cho đẹp */
            .tile-body {
                background: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: auto;
            }

            /* Styling cho các ô nhập liệu */
            form .mb-6 {
                margin-bottom: 15px;
            }

            form .control-label {
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
            }

            form .form-control {
                border-radius: 5px;
                border: 1px solid #ccc;
                padding: 10px;
                font-size: 14px;
                transition: all 0.3s;
            }

            form .form-control:focus {
                border-color: #007bff;
                box-shadow: 0px 0px 8px rgba(0, 123, 255, 0.3);
            }

            /* Style cho button */
            .btn-save {
                background: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .btn-save:hover {
                background: #218838;
            }

            .btn-cancel {
                background: #dc3545;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: all 0.3s;
                margin-left: 10px;
            }

            .btn-cancel:hover {
                background: #c82333;
            }

            /* Điều chỉnh khoảng cách giữa các nút */
            .btn-save, .btn-cancel {
                display: inline-block;
                width: 120px;
                text-align: center;
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
            <div class="col-md-12">
                <div class="tile">
                    <h2 class="tile-title">Thêm người dùng mới</h2>
                    <div class="tile-body">
                        <form class="row" action="userApplication?action=addSave" method="post" onsubmit="return validateForm()" >
                            <input class="form-control" name="userId" type="hidden" required value="${user.userId}">
                            <div class="mb-6">
                                <label class="control-label">Tên nhân viên:</label>
                                <input class="form-control" readonly name="name" type="text" required value="${user.name}">
                            </div>
                            <div class="mb-6">
                                <label class="control-label">Chức vụ:</label>
                                <select class="form-control" name="roleId"disabled>
                                    <c:forEach items="${requestScope.rlist}" var="role" >
                                        <option value="${role.roleId}" ${user.roleId == role.roleId ? 'selected' : ''}>
                                            ${role.roleName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-6">
                                <label class="control-label">Phòng ban:</label>
                                <select class="form-control" name="departmentId" disabled>
                                    <c:forEach items="${requestScope.dlist}" var="department">
                                        <option value="${department.departmentId}" ${user.departmentId == department.departmentId ? 'selected' : ''}>
                                            ${department.departmentName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-6">
                                <label class="control-label">Tiêu đề</label>
                                <input class="form-control" name="title" type="text" required value="">
                            </div>

                            <div class="mb-6">
                                <label class="control-label">Ngày bắt đầu</label>
                                <input class="form-control" type="date" name="startDate" required value="">
                            </div>
                            <div class="mb-6">
                                <label class="control-label">Ngày kết thúc</label>
                                <input class="form-control" type="date" name="endDate" required value="">
                            </div>
                            <div class="mb-6">
                                <label class="control-label">Nội dung đơn</label>
                                <textarea class="form-control" type="text" row="4" name="reason" required value="${a.reason}"></textarea>
                            </div>
                            
                            <button class="btn btn-save" type="submit">Lưu lại</button>
                            <a class="btn btn-cancel" href="userApplication">Hủy bỏ</a>
                        </form>
                    </div>

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
                            function validateForm() {
                                let isValid = true; // Biến kiểm tra trạng thái hợp lệ của form

                                // Lấy giá trị của các input
                                let email = document.getElementById("email").value.trim();
                                let phone = document.getElementById("phone").value.trim();

                                // Lấy phần hiển thị lỗi
                                let emailError = document.getElementById("emailError");
                                let phoneError = document.getElementById("phoneError");

                                // Reset lỗi trước khi kiểm tra
                                emailError.innerText = "";
                                phoneError.innerText = "";

                                // Biểu thức chính quy kiểm tra email hợp lệ
                                let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                                if (!emailRegex.test(email)) {
                                    emailError.innerText = "Email không hợp lệ!";
                                    isValid = false;
                                }

                                // Biểu thức chính quy kiểm tra số điện thoại (10 số, bắt đầu bằng 0, không chứa ký tự đặc biệt)
                                let phoneRegex = /^(0[1-9][0-9]{8})$/;
                                if (!phoneRegex.test(phone)) {
                                    phoneError.innerText = "Số điện thoại không hợp lệ! (10 chữ số, bắt đầu bằng 0)";
                                    isValid = false;
                                }

                                return isValid; // Trả về `true` nếu hợp lệ, `false` nếu có lỗi (chặn gửi form)
                            }
        </script>
    </body>
</html>
