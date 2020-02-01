<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>employees list</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!--员工添加模态框-->
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input"
                                   placeholder="dayu@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="F" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="M">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="emp_save_btn" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!--员工修改模态框-->
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p type="text" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input"
                                   placeholder="dayu@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="F" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="M"> 女
                        </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="emp_update_btn" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <!--头部标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--新增删除按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增员工</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">批量删除</button>
        </div>
    </div>
    <!--员工列表信息-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <td>#</td>
                    <td>姓名</td>
                    <td>性别</td>
                    <td>邮箱</td>
                    <td>部门</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <!--分页信息-->
        <div class="col-md-6" id="page_info_area"></div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    //全局总记录数
    var totalRecord,currentPage;

    $(function () {
        to_page(1);
    })

    function to_page(pageNumber) {
        $.ajax({
            url: "${APP_PATH}/empsx/",
            data: "pageNumber=" + pageNumber,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //alert(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析并显示分条信息
                build_page_nav(result);
            }

        });
    }

    //解析并显示员工数据#emps_table tbody
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //alert(item.empName);
            var checkBoxTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'F' ? '男' : '女');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            // <th>
            //     <button class="btn btn-primary btn-sm">
            //          <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            //          编辑
            //     </button>
            //     <button class="btn btn-danger btn-sm">
            //         <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
            //          删除
            //     </button>
            // </th>
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit_id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加属性表示id
            delBtn.attr("delete_id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析分页信息#page_info_area
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("<span></span>")
            .append("当前第" + result.extend.pageInfo.pageNum + "页,共" + result.extend.pageInfo.pages + "页,共" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        //更新员工信息后，需返回显示当前页
        currentPage=result.extend.pageInfo.pageNum;

    }

    //解析并显示分页条信息#page_nav_area
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>")
            .append($("<a></a>").attr("href", "#").attr("aria-label", "Previous").append($("<span></span>").attr("aria-hidden", "true").append("&laquo;")));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加翻页事件
            firstPageLi.click(function () {
                to_page(1)
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1)
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").attr("aria-label", "Next").append($("<span></span>").attr("aria-hidden", "true").append("&raquo;")));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //为元素添加翻页事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages)
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        if (result.extend.pageInfo.isFirstPage == true) {
            prePageLi.remove();
        }
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        if (result.extend.pageInfo.isLastPage == true) {
            nextPageLi.remove();
        }
        var nav = $("<nav></nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }

    function reset_form(ele) {
        //清除表单内容
        $(ele)[0].reset();
        //方式2：清除表单数据、重置（不推荐:关闭模态框前）
        // $("#empName_add_input").val("");
        // $("#email_add_input").val("");
        // $("#gender1_add_input").val("");
        // $("#dept_add_select").val("");
        //清除表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击成员新增弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据、重置（方式1推荐）
        reset_form("#empAddModal form");
        getDepts("#empAddModal select");
        //$("#empAddModal").empty();
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查出所有部门信息，显示在下拉列表
    function getDepts(selectName) {
        $(selectName).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                $(selectName).empty();
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>")
                        .attr("value", this.deptId)
                        .append(this.deptName);
                    optionEle.appendTo(selectName);
                })
            }
        });
    }

    $("#emp_save_btn").click(
        function () {

            //1、模态框中填写的数据提交到服务器进行保存
            //1、先对提交给服务器的数据进行校验
            if (!validate_add_form()) {
                return false;
            }
            //1、判断之前的ajax用户名校验是否成功
            if ($(this).attr("ajax-va") == "error") {
                // console.log("用户名判断校验错误");
                return false;
            }
            //console.log($("#empAddModal form").serialize());
            $.ajax({
                url: "${APP_PATH}/emp/",
                type: "POST",
                data: $("#empAddModal form")
                    .serialize(),
                success: function (result) {
                    if (result.code == 200) {
                        //员工保存成功
                        //1、关闭模态框
                        $("#empAddModal").modal('hide');
                        //3、来到最后一页，显示刚才保存的数据
                        //发送ajax请求显示最后一页数据即可
                        // to_page(9999);
                        to_page(totalRecord);
                    } else {
                        // 显示失败信息
                        console.log(result);
                        if (undefined != result.extend.errorFields.empName) {
                            //显示用户名的错误信息
                            show_validate_msg(
                                "#empName_add_input",
                                "error",
                                result.extend.errorFields.empName);
                        }
                        if (undefined != result.extend.errorFields.email) {
                            //显示邮箱的错误信息
                            show_validate_msg(
                                "#email_add_input",
                                "error",
                                result.extend.errorFields.email);
                        }
                        return false;
                    }
                }
            });
        })

    function show_validate_msg(ele, status, msg) {
        //首先清空当前元素
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text("");
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
        }
        $(ele).next("span").text(msg);
    }

    function validate_add_form() {
        //1、拿到要校验的数据
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "用户名为2-5中文或3-16英文数字组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        //2、校验邮箱信息
        var empEmail = $("#email_add_input").val();
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if (!regEmail.test(empEmail)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式错误");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //校验用户名是否可用
    $("#empName_add_input").change(
        function () {
            //发送ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
                url: "${APP_PATH}/checkUser/",
                data: "empName=" + empName,
                type: "POST",
                success: function (result) {
                    if (result.code == 200) {
                        show_validate_msg("#empName_add_input",
                            "success", "用户名可用");
                        $("#emp_save_btn").attr("ajax-va", "success");
                    } else {
                        show_validate_msg("#empName_add_input",
                            "error", result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va", "error");
                    }

                }
            })

        });
    //编辑
    //1、按钮创建之前就绑定click，所以帮不上
    //1）创建按钮时绑定、2）绑定点击.live（）
    //jQuery新版没有live，Tomcat7及其以上无live方法用on时间代替
    $(document).on("click", ".edit_btn", function () {
        //1、查出部门信息显示部门信息
        getDepts("#empUpdateModal select")
        //2、查处员工信息显示员工信息
        getEmp($(this).attr("edit_id"));
        //3、把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                //alert(result.extend.emp);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.deptId]);
            }
        });
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //1、验证
        var empEmail = $("#email_update_input").val();
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if (!regEmail.test(empEmail)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式错误");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //2、发送ajax请求，保存更新员工信息
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit_id"),
            type: "POST",
            data: $("#empUpdateModal form").serialize() + "&_method=PUT",
            success: function() {
                // alert(result.msg);
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
            }
        });
    });
    //单个删除
    $(document).on("click", ".delete_btn", function() {
        //1、弹出确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("delete_id");
        if (confirm("确认删除【" + empName + "】吗？")) {
            //发送ajax请求删除
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function(result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function() {
        var is_All_Check = $(this).prop("checked");
        $(".check_item").prop("checked", is_All_Check);
    });

    //check_item，复选框选择操作
    $(document).on("click", ".check_item", function() {
        //判断当前选择中的元素是否选满
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function() {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function() {
            //组装员工字符串
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组织员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除empNames多余的","
        empNames = empNames.substring(0, empNames.length - 1);
        //去除员工删除id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            //发送ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function(result) {
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                    $("#check_all").prop("checked", false);
                }
            })

        }
    });
</script>