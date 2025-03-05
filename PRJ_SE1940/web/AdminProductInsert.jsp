
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Thêm sản phẩm | Quản trị Admin | Watch-Pro</title>

        <link rel="shortcut icon" type="image/x-icon" href="img/logo.jpg" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
        <script>

            function readURL(input, thumbimage) {
                if (input.files && input.files[0]) { //Sử dụng  cho Firefox - chrome
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#thumbimage").attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                } else { // Sử dụng cho IE
                    $("#thumbimage").attr('src', input.value);

                }
                $("#thumbimage").show();
                $('.filename').text($("#uploadfile").val());
                $('.Choicefile').css('background', '#14142B');
                $('.Choicefile').css('cursor', 'default');
                $(".removeimg").show();
                $(".Choicefile").unbind('click');

            }
            $(document).ready(function () {
                $(".Choicefile").bind('click', function () {
                    $("#uploadfile").click();

                });
                $(".removeimg").click(function () {
                    $("#thumbimage").attr('src', '').hide();
                    $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
                    $(".removeimg").hide();
                    $(".Choicefile").bind('click', function () {
                        $("#uploadfile").click();
                    });
                    $('.Choicefile').css('background', '#14142B');
                    $('.Choicefile').css('cursor', 'pointer');
                    $(".filename").text("");
                });
            })
        </script>
    </head>

    <body class="app sidebar-mini rtl">
        <style>
            .Choicefile {
                display: block;
                background: #14142B;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                /* border: 3px solid red; */
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                /* color: #FFF; */
                /* background-color: #DC403B; */
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }
        </style>
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="dashboard"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <div>
                    <p class="app-sidebar__user-name"><b>Admin : ${sessionScope.account.getFullname()}</b></p>

                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item" href="customermanager"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Quản lý khách hàng</span></a></li>
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
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Danh sách sản phẩm</li>
                    <li class="breadcrumb-item"><a href="#">Thêm sản phẩm</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tạo mới sản phẩm</h3>
                        <div class="tile-body">


                            <form class="row" action="productmanager?action=insertproduct" method="post" >


                                <div class="form-group col-md-3">
                                    <label class="control-label">Tên sản phẩm</label>
                                    <input class="form-control" name="product_name" type="text" value="">
                                </div>
                                <div class="form-group  col-md-3">
                                    <label class="control-label">Mô tả</label>
                                    <input class="form-control" name="description" type="text" value="">
                                </div>
                                <div class="form-group  col-md-3">
                                    <label class="control-label">Giá bán </label>
                                    <input class="form-control" name="price" type="text" value="">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Kiểu loại</label>
                                    <input class="form-control"  name="category" type="text" value="">
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Hãng</label>
                                    <input class="form-control" name="brand" type="text"  value="">
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



        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="admin/js/main.js"></script>
        <script src="admin/js/plugins/pace.min.js"></script>
        <script>
                                            const inpFile = document.getElementById("inpFile");
                                            const loadFile = document.getElementById("loadFile");
                                            const previewContainer = document.getElementById("imagePreview");
                                            const previewContainer = document.getElementById("imagePreview");
                                            const previewImage = previewContainer.querySelector(".image-preview__image");
                                            const previewDefaultText = previewContainer.querySelector(".image-preview__default-text");
                                            const object = new ActiveXObject("Scripting.FileSystemObject");
                                            inpFile.addEventListener("change", function () {
                                                const file = this.files[0];
                                                if (file) {
                                                    const reader = new FileReader();
                                                    previewDefaultText.style.display = "none";
                                                    previewImage.style.display = "block";
                                                    reader.addEventListener("load", function () {
                                                        previewImage.setAttribute("src", this.result);
                                                    });
                                                    reader.readAsDataURL(file);
                                                }
                                            });
                                            



        </script>
    </body>

</html>
