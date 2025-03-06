<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Danh sách người dùng | Quản trị Admin</title>

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
                <li><a class="app-nav__item" href="dashboard"><i class='bx bx-log-out bx-rotate-180'></i> Home </a>


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
                <li><a class="app-menu__item" href="adminDashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item" href="adminUserManagement"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Quản lý người dùng</span></a></li>
                <li><a class="app-menu__item" href="productmanager"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item" href="ordermanager"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý đơn hàng</span></a></li>
                <li><a class="app-menu__item" href="moneyrequestmanager" ><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý yêu cầu nạp tiền </span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách người dùng</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thêm người dùng mới</h3>
                        <div class="tile-body">
                            <form class="row" action="adminUserManagement?action=add" method="post" >
                                <div class="form-group col-md-3">
                                    <label class="control-label">Tên người dùng</label>
                                    <input class="form-control" name="name" type="text" required value="">
                                </div>
                                <div class="form-group  col-md-3">
                                    <label class="control-label">Tên đăng nhập</label>
                                    <input class="form-control" name="username" type="text" value="">
                                </div>
                                <div class="form-group  col-md-3">
                                    <label class="control-label">Mật khẩu </label>
                                    <input class="form-control" name="password" type="text" value="">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Email</label>
                                    <input class="form-control"  name="email" type="text" value="">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Số điện thoại</label>
                                    <input class="form-control" name="phone" type="text"  value="">
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Phòng ban</label>
                                    <select class="form-select" id="exampleFormControlSelect1" name="departmentId">
                                        <c:forEach items="${requestScope.dlist}" var="department">
                                            <option value="${department.departmentId}">${department.departmentName}</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="form-group  col-md-3">
                                    <label class="control-label">Số lượng vào kho</label>
                                    <input class="form-control" name="stock" type="text" value="">
                                </div>                                                      

                                <div class="form-group col-md-12">
                                    <label class="control-label">Ảnh sản phẩm</label>
                                    <div id="myfileupload">
                                        <input type="file" id="uploadfile" name="product_img" onchange="readURL(this);" />
                                    </div>
                                    <div id="thumbbox">
                                        <img height="450" width="400" alt="Thumb image" id="thumbimage" style="display: none" />
                                        <a class="removeimg" href="javascript:"></a>
                                    </div>
                                    <div id="boxchoice">
                                        <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                                        <p style="clear:both"></p>
                                    </div>

                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                    &nbsp;
                                    <a class="btn btn-cancel" href="postmanagement">Hủy bỏ</a>
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
        </script>
        <script>
            $(document).ready(function () {
                $(document).on('click', '.trash', function () {
                    swal({
                        title: "Cảnh báo",
                        text: "Bạn có chắc chắn là muốn xóa người dùng này?",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                    }).then((willDelete) => {
                        if (willDelete) {
                            window.location = "adminUserManagement?action=delete&userId=" + $(this).attr("value");
                            swal("Đã xóa thành công.!", {});
                        }
                    });
                });
            });
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