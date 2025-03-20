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
            <h2>Danh Sách Đơn</h2>
            <button class="btn btn-success mb-3">
                <a href="userApplication?action=add" class="text-white" >Tạo đơn mới</a>
            </button>
            <table id="userTable" class="display table table-striped">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Tên người dùng</th>
                        <th>Chức vụ</th>
                        <th>Tiêu đề</th>
                        <th>Lý do</th>
                        <th>Ngày bắt đầu </th>
                        <th>Ngày kết thúc</th>
                        <th>Trạng thái</th>
                        <th>Người duyệt</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.alist}" var="a">
                        <tr>

                            <td>${a.applicationId}</td>
                            <td>${user.name}</td> 
                            <td>
                                <c:forEach items="${requestScope.ulist}" var="u">
                                    <c:if test="${u.userId == a.userId}">
                                        <c:forEach items="${requestScope.rlist}" var="r">
                                            <c:if test="${r.roleId == u.roleId}">
                                                ${r.roleName}
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </td> 
                            <td>${a.title}</td>
                            <td>${a.reason}</td>
                            <td>${a.startDate}</td>
                            <td>${a.endDate}</td>
                            <td>
                                <c:forEach items="${requestScope.slist}" var="status">
                                    <c:if test="${status.statusId == a.statusId}">
                                        ${status.statusName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach items="${requestScope.ulist}" var="u">
                                    <c:if test="${u.userId == a.approverId}">
                                        ${u.name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:if test="${a.statusId == 1}">
                                    <button class="btn btn-warning btn-sm edit-btn" data-bs-toggle="modal" data-bs-target="#editModal${a.applicationId}" title="Sửa">Sửa️</button>

                                    <button class="btn btn-danger btn-sm del" type="button" value="${a.applicationId}">Xóa️</button>
                                </c:if>
                            </td>
                        </tr>

                        <!-- Modal Edit -->
                    <div class="modal fade" id="editModal${a.applicationId}" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editModalLabel">Chỉnh sửa đơn</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="userApplication?action=edit" method="POST">
                                        <input type="hidden" name="applicationId" value="${a.applicationId}">
                                        <div class="mb-3">
                                            <label class="form-label">Tên nhân viên</label>
                                            <input type="text" class="form-control" id="editName" name="name" required value="${user.name}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="control-label">Tiêu đề</label>
                                            <input class="form-control" type="text" name="title" required value="${a.title}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="control-label">Ngày bắt đầu</label>
                                            <input class="form-control" type="date" name="startDate" required value="${a.startDate}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="control-label">Ngày kết thúc</label>
                                            <input class="form-control" type="date" name="endDate" required value="${a.endDate}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="control-label">Nội dung đơn</label>
                                            <textarea class="form-control" name="reason" rows="4" required>${a.reason}</textarea>
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
            // Hàm xử lý đơn dùng với SweetAlert
            $(document).ready(function () {
    $(document).on('click', '.del', function () {
        let applicationId = $(this).val(); // Lấy applicationId từ button
        console.log("Application ID cần xóa:", applicationId); 

        if (!applicationId) {
            alert("Lỗi: Không lấy được applicationId.");
            return;
        }

        swal({
            title: "Cảnh báo!",
            text: "Bạn có chắc chắn muốn xóa đơn này?",
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
                    window.location.href = "userApplication?action=delete&applicationId=" + applicationId;
                });
            }
        });
    });
});


        </script>
    </body>
</html>
