<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Danh sách đơn</title>

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
                    <p class="app-sidebar__user-name"><b>User : ${sessionScope.user.getName()}</b></p>

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
                    <li class="breadcrumb-item active"><a href="#"><b>Bảng thống kê</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="In"
                                       onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i> In dữ liệu</a>
                                </div>
                            </div>
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
        </script>
        <script>
            $(document).ready(function () {
                $(document).on('click', '.trash', function () {
                    swal({
                        title: "Cảnh báo",
                        text: "Bạn có chắc chắn là muốn hủy đơn này?",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                    }).then((willDelete) => {
                        if (willDelete) {
                            window.location = "userApplication?action=delete&applicationId=" + $(this).attr("value");
                            swal("Đã xóa thành công.!", {});
                        }
                    });
                });
            });


        </script>
        <style>
            /* Căn chỉnh form */
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

    </body>

</html>