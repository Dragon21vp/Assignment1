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
            <h2>Danh Sách Người Dùng</h2>
            <button class="btn btn-success mb-3">
                <a href="adminUserManagement?action=add" class="text-white" >Thêm người dùng mới</a>
            </button>
            <table id="userTable" class="display table table-striped">
                <thead>
                    <tr>
                        <th>Mã người dùng</th>
                        <th>Tên người dùng</th>
                        <th>Tài khoản</th>
                        <th>Mật khẩu</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Phòng ban</th>
                        <th>Chức vụ</th>
                        <th>Trạng thái</th>
                        <th>Chỉnh sửa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.ulist}" var="user">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.name}</td>                                          
                            <td>${user.username}</td>
                            <td>${user.password}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>
                                <c:forEach items="${requestScope.dlist}" var="department">
                                    <c:if test="${department.departmentId == user.departmentId}">
                                        ${department.departmentName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach items="${requestScope.rlist}" var="role">
                                    <c:if test="${role.roleId == user.roleId}">
                                        ${role.roleName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.status == 1}">Đang hoạt động</c:when>
                                    <c:otherwise>Không hoạt động</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-warning btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editModal${user.userId}" title="Sửa">Sửa️</button>

                                <button class="btn btn-danger btn-sm del" type="button" value="${user.userId}">Xóa️</button>
                            </td>
                        </tr>

                        <!-- Modal Edit -->
                    <div class="modal fade" id="editModal${user.userId}" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editModalLabel">Chỉnh sửa người dùng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="adminUserManagement?action=edit" method="POST" onsubmit="return validateForm()"> 
                                        <div class="mb-3">
                                            <label class="form-label">Mã người dùng</label>
                                            <input type="text" class="form-control" id="editUserID" readonly name="userId" value="${user.userId}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tên người dùng</label>
                                            <input type="text" class="form-control" id="editName" name="name" required value="${user.name}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tên đăng nhập</label>
                                            <input type="text" class="form-control" id="editUsername" name="username" required value="${user.username}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu</label>
                                            <input type="text" class="form-control" id="editPassword" name="password" required value="${user.password}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="text" class="form-control" id="editEmail" name="email" required value="${user.email}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số điện thoại</label>
                                            <input type="text" class="form-control" id="editPhone" name="phone" required value="${user.phone}">
                                        </div>

                                        <div class="mb-3">
                                            <label >Phòng ban</label>
                                            <select  name="departmentId">
                                                <c:forEach items="${requestScope.dlist}" var="department">
                                                    <option value="${department.departmentId}" ${user.departmentId == department.departmentId ? 'selected' : ''}>
                                                        ${department.departmentName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label >Chức vụ</label>
                                            <select  name="roleId">
                                                <c:forEach items="${requestScope.rlist}" var="role">
                                                    <option value="${role.roleId}" ${user.roleId == role.roleId ? 'selected' : ''}>
                                                        ${role.roleName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label >Trạng thái</label>
                                            <select name="status">
                                                <option value="1" ${user.status == 1 ? 'selected' : ''}>Đang hoạt động</option>
                                                <option value="0" ${user.status == 0 ? 'selected' : ''}>Không hoạt động</option>
                                            </select>
                                        </div>

                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>

                                    </form>
                                            
                                </div>
                            </div>
                        </div>
                    </div>
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
            // Hàm xử lý xóa người dùng với SweetAlert
            $(document).ready(function () {
                $(document).on('click', '.del', function () {
                    let userId = $(this).val(); // Lấy userId từ button
                    console.log("User ID cần xóa:", userId); // Kiểm tra xem có lấy đúng userId không

                    if (!userId) {
                        alert("Lỗi: Không lấy được userId.");
                        return;
                    }

                    swal({
                        title: "Cảnh báo!",
                        text: "Bạn có chắc chắn muốn xóa người dùng này?",
                        icon: "warning",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                        dangerMode: true,
                    }).then((confirmDelete) => {
                        if (confirmDelete) {
                            swal("Đã xóa thành công!", {
                                icon: "success",
                                timer: 1500,
                                buttons: false
                            }).then(() => {
                                window.location.href = "adminUserManagement?action=delete&userId=" + userId;
                            });
                        }
                    });
                });
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
