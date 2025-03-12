
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Application Dashboard</title>

        <link rel="shortcut icon" type="image/x-icon" href="img/logo.jpg" />
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
                    <p class="app-sidebar__user-name"><b>Admin : ${sessionScope.user.getName()}</b></p>

                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="userInfo"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Thông tin cá nhân</span></a></li>
                <li><a class="app-menu__item" href="userApplication"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Đơn của tôi</span></a></li>
                            <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">
                    <li><a class="app-menu__item" href="userApplicationDashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                                class="app-menu__label">Thống kê đơn</span></a></li>
                    <li><a class="app-menu__item" href="userApplicationManagement"><i class='app-menu__icon bx bx-user-voice'></i><span
                                class="app-menu__label">Phê duyệt đơn</span></a></li>
                            </c:if>
            </ul>
        </aside>
        <main class="app-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>Bảng điều khiển</b></a></li>
                        </ul>
                        <div id="clock"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
                        <!-- col-6 -->
                        <div class="col-md-4">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng số đơn</h4>
                                    <p><b>${requestScope.total} Đơn</b></p>
                                    <p class="info-tong">Tổng số đơn được quản lý.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-4">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng số đơn chưa được duyệt</h4>
                                    <p><b>${requestScope.inprogress} đơn</b></p>
                                    <p class="info-tong">Tổng số đơn chưa được duyệt.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-4">
                            <div class="widget-small warning coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng số đơn đã được duyệt</h4>
                                    <p><b>${requestScope.processed} đơn</b></p>
                                    <p class="info-tong">Tổng số đơn đã được duyệt.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
<!--                        <div class="col-md-6">
                            <div class="widget-small danger coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng số nhân viên</h4>
                                    <p><b>${requestScope.sUser} người</b></p>
                                    <p class="info-tong">Tổng số nhân viên được quản lý.</p>
                                </div>
                            </div>
                        </div>-->

                        <style>


                            /* Button used to open the contact form - fixed at the bottom of the page */
                            .open-button {
                                background-color: #555;
                                color: white;

                                border: none;
                                cursor: pointer;
                                opacity: 0.8;


                            }

                            /* The popup form - hidden by default */
                            .form-popup {
                                display: none;

                                right: 15px;
                                border: 3px solid #f1f1f1;
                                z-index: 9;
                            }

                            /* Add styles to the form container */
                            .form-container {
                                max-width: 300px;
                                padding: 10px;
                                background-color: white;
                            }

                            /* Full-width input fields */
                            .form-container input[type=text], .form-container input[type=password] {
                                width: 100%;
                                padding: 15px;
                                margin: 5px 0 22px 0;
                                border: none;
                                background: #f1f1f1;
                            }

                            /* When the inputs get focus, do something */
                            .form-container input[type=text]:focus, .form-container input[type=password]:focus {
                                background-color: #ddd;
                                outline: none;
                            }

                            /* Set a style for the submit/login button */
                            .form-container .btn {
                                background-color: #04AA6D;
                                color: white;
                                padding: 16px 20px;
                                border: none;
                                cursor: pointer;
                                width: 100%;
                                margin-bottom:10px;
                                opacity: 0.8;
                            }

                            /* Add a red background color to the cancel button */
                            .form-container .cancel {
                                background-color: red;
                            }

                            /* Add some hover effects to buttons */
                            .form-container .btn:hover, .open-button:hover {
                                opacity: 1;
                            }
                        </style>

                    </div>
                </div>
            </div>


            <!--            <div class="text-center" style="font-size: 13px">
                            <p><b>Copyright
                                    <script type="text/javascript">
                                        document.write(new Date().getFullYear());
                                    </script> Phần mềm quản lý Website
                                </b></p>
                        </div>-->
        </main>
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/main.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!--===============================================================================================-->
        <!--===============================================================================================-->
        <script type="text/javascript">
        var data = {
            labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"],
            datasets: [{
                    label: "Dữ liệu đầu tiên",
                    fillColor: "rgba(255, 213, 59, 0.767), 212, 59)",
                    strokeColor: "rgb(255, 212, 59)",
                    pointColor: "rgb(255, 212, 59)",
                    pointStrokeColor: "rgb(255, 212, 59)",
                    pointHighlightFill: "rgb(255, 212, 59)",
                    pointHighlightStroke: "rgb(255, 212, 59)",
                    data: [20, 59, 90, 51, 56, 100]
                },
                {
                    label: "Dữ liệu kế tiếp",
                    fillColor: "rgba(9, 109, 239, 0.651)  ",
                    pointColor: "rgb(9, 109, 239)",
                    strokeColor: "rgb(9, 109, 239)",
                    pointStrokeColor: "rgb(9, 109, 239)",
                    pointHighlightFill: "rgb(9, 109, 239)",
                    pointHighlightStroke: "rgb(9, 109, 239)",
                    data: [48, 48, 49, 39, 86, 10]
                }
            ]
        };
        var ctxl = $("#lineChartDemo").get(0).getContext("2d");
        var lineChart = new Chart(ctxl).Line(data);

        var ctxb = $("#barChartDemo").get(0).getContext("2d");
        var barChart = new Chart(ctxb).Bar(data);
        </script>
        <script type="text/javascript">
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
                m = checkTime(m);
                nowTime = h + ":" + m + "";
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
            function logout() {
                document.l.submit();
            }
            function openForm() {
                document.getElementById("myForm").style.display = "block";
            }

            function closeForm() {
                document.getElementById("myForm").style.display = "none";
            }
            function openForm1() {
                document.getElementById("myForm1").style.display = "block";
            }

            function closeForm1() {
                document.getElementById("myForm1").style.display = "none";
            }
        </script>
    </body>

</html>