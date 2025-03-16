<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Thông tin người dùng</title>

        <link rel="shortcut icon" type="image/x-icon" href="support_images/logo1.png" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i>Logout </a>


                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <div>
                    <p class="app-sidebar__user-name"><b>User: ${sessionScope.user.getName()}</b></p>

                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="userInfo"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Thông tin cá nhân</span></a></li>
                <li><a class="app-menu__item" href="userApplication"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Đơn của tôi</span></a></li>
                            <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">
                    <li><a class="app-menu__item" href="userApplicationDashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                                class="app-menu__label">Thống kê đơn</span></a></li>
                    <li><a class="app-menu__item" href="userApplicationManagement"><i class='app-menu__icon bx bx-tachometer'></i><span
                                class="app-menu__label">Phê duyệt đơn</span></a></li>
                    <li><a class="app-menu__item" href="statistic"><i class='app-menu__icon bx bx-tachometer'></i><span
                                class="app-menu__label">Bảng dữ liệu</span></a></li>
                            </c:if>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Thông tin người dùng</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thông tin của tôi</h3>
                        <div class="tile-body">
                            <form class="row" action="userInfo?action=edit" method="post" onsubmit="return validateForm()" >

                                <input type="hidden" name="userId" type="text" required value="${user.userId}">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Tên người dùng</label>
                                    <input class="form-control" name="name" type="text" required value="${user.name}">
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Tên đăng nhập</label>
                                    <input class="form-control" name="username" type="text" required value="${user.username}">
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Mật khẩu </label>
                                    <input class="form-control" name="password" type="text" required value="${user.password}">
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Email</label>
                                    <input class="form-control" id="email" name="email" type="text" required value="${user.email}">
                                    <small id="emailError" class="text-danger"></small> <!-- Thông báo lỗi -->
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="control-label">Số điện thoại</label>
                                    <input class="form-control" id="phone" name="phone" type="text" required value="${user.phone}">
                                    <small id="phoneError" class="text-danger"></small> <!-- Thông báo lỗi -->
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Phòng ban</label>
                                    <select class="form-control" id="exampleFormControlSelect1" name="departmentId">
                                        <c:forEach items="${requestScope.dlist}" var="department">
                                            <option value="${department.departmentId}" ${user.departmentId == department.departmentId ? 'selected' : ''}>
                                                ${department.departmentName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Chức vụ</label>
                                    <select class="form-control" id="exampleFormControlSelect1" name="roleId">
                                        <c:forEach items="${requestScope.rlist}" var="role">
                                            <option value="${role.roleId}" ${user.roleId == role.roleId ? 'selected' : ''}>
                                                ${role.roleName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Trạng thái</label>
                                    <select class="form-control"  name="status">
                                        <option value="1" ${user.status == 1 ? 'selected' : ''}>Đang hoạt động</option>
                                        <option value="0" ${user.status == 0 ? 'selected' : ''}>Không hoạt động</option>
                                    </select>
                                </div>
                                <button class="btn btn-save" type="submit">Lưu lại</button>
                                <a class="btn btn-cancel" href="userInfo">Hủy bỏ</a>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </main>


        <!-- Essential javascripts for application to work-->
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
                                $('#sampleTable').DataTable();

                                //Thời Gian
                                function time() {
                                    var today = new Date();
                                    var weekday = new Array(7);
                                    weekday[0] = "Chủ Nhật";
                                    weekday[1] = "Thứ Hai";
                                    weekday[2] = "Thứ Ba";
                                    weekday[3] = "Thứ Tư";
                                    weekday[4] = "Thứ Năm";
                                    weekday[5] = "Thứ Sáu";
                                    weekday[6] = "Thứ Bảy";
                                    var day = weekday[today.getDay()];
                                    var dd = today.getDate();
                                    var mm = today.getMonth() + 1;
                                    var yyyy = today.getFullYear();
                                    var h = today.getHours();
                                    var m = today.getMinutes();
                                    var s = today.getSeconds();
                                    m = checkTime(m);
                                    s = checkTime(s);
                                    nowTime = h + " giờ " + m + " phút " + s + " giây";
                                    if (dd < 10) {
                                        dd = '0' + dd
                                    }
                                    if (mm < 10) {
                                        mm = '0' + mm
                                    }
                                    today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                                    tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                                            '</span>';
                                    document.getElementById("clock").innerHTML = tmp;
                                    clocktime = setTimeout("time()", "1000", "Javascript");

                                    function checkTime(i) {
                                        if (i < 10) {
                                            i = "0" + i;
                                        }
                                        return i;
                                    }
                                }
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

        <script>

            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
            //Phân trang
            $(document).ready(function () {
                // Hủy khởi tạo DataTable nếu đã tồn tại
                if ($.fn.dataTable.isDataTable('#sampleTable')) {
                    $('#sampleTable').DataTable().destroy();
                }

                // Khởi tạo lại DataTable
                $('#sampleTable').DataTable({
                    "aLengthMenu": [5, 10, 15, 20],
                    // Các cấu hình khác nếu cần
                });
            });
        </script>
    </body>

</html>