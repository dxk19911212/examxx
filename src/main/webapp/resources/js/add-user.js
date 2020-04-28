$(function() {
    create_account.initial();
});

var create_account = {

    initial : function initial() {
        this.bindOpenAddUserModal();
        this.bindAddUserForm();
        this.bindOpenUpdateUserModal();
        this.bindchangePwdForm();
    },

    // 打开添加用户modal
    bindOpenAddUserModal : function bindOpenAddUserModal() {
        $("#btn-add-user").click(function() {
            // 先清空modal中的值
            $("#department-selector").val("");
            $("#category-selector").val("");
            // 再弹出
            $("#btn-add-user").click(function () {
                $("#add-user-modal").modal({backdrop: true, keyboard: true});
            });
        })
    },

    // 保存用户
    bindAddUserForm : function bindAddUserForm() {
        $("#btn-save").click(function () {
            var result = create_account.verifyInput();
            if (result) {
                var data = new Object();
                data.username = $("#name").val();
                data.password = $("#password").val();
                data.department = $("#department-selector").val();
                data.category = $("#category-selector").val();
                data.officer_number = $("#officer_number").val();
                $.ajax({
                  headers : {
                      'Accept' : 'application/json',
                      'Content-Type' : 'application/json'
                  },
                  type : "POST",
                  url : "admin/add-user",
                  data : JSON.stringify(data),
                  success : function(message, tst, jqXHR) {
                      if (message.result == "success") {
                          util.success("添加会员成功！");
                          document.location.href =
                              document.getElementsByTagName('base')[0].href + "admin/user-list";
                      } else {
                          if (message.result == "duplicate-username") {
                              $(".form-username .form-message").text(message.messageInfo);
                          } else if (message.result == "captch-error") {

                          } else if (message.result == "duplicate-email") {
                              $(".form-email .form-message").text(message.messageInfo);
                          } else {
                              util.error(message.result);
                          }
                      }
                  },
                   error : function(jqXHR, textStatus) {
                       util.error("添加会员失败");
                   }
              });
            }
        })
    },

    // 打开修改用户modal
    bindOpenUpdateUserModal : function bindOpenUpdateUserModal() {
        $(".btn-update-user").click(function(){
            $("#update-user-modal").modal({backdrop:true,keyboard:true});
            $('#update-department-selector').select2({
                  placeholder: "请选择",
                  width:'150px',
                  data: [
                      {id: 1, text: '刑事部门'},
                      {id: 2, text: '治安部门'},
                      {id: 3, text: '交通管理部门'},
                      {id: 4, text: '消防部门'},
                      {id: 5, text: '出入境部门'},
                      {id: 6, text: '人口管理部门'},
                      {id: 7, text: '内安全保卫部门'}]
              });

            $('#update-category-selector').select2({
                placeholder: "请选择",
                width:'150px',
                data: [
                    {id: 1, text: '治安警察'},
                    {id: 2, text: '交通警察'},
                    {id: 3, text: '外事警察'},
                    {id: 4, text: '禁毒警察'},
                    {id: 5, text: '监所警察'},
                    {id: 6, text: '公安法医'}]
            });

            var tr = $(this).parent().parent();
            var user_id =  $(this).parent().parent().find(":checkbox").val();
            var user_username = tr.find(".td-username").text();
            var user_department = tr.find(".td-department").text();
            var user_category = tr.find(".td-category").text();
            var user_officer_number = tr.find(".td-officer_number").text();
            $("#add-update-userid").text(user_id);
            $("#update-name").val(user_username);
            $("#update-department-selector").val(user_department.split(',')).trigger('change');
            $("#update-category-selector").val(user_category.split(',')).trigger('change');
            $("#update-officer_number").val(user_officer_number);
        });
    },

    // 修改用户
    bindchangePwdForm : function bindchangePwdForm() {
        $("#btn-update").click(function () {
            // var verify_result = create_account.verifyInput();
            var user_id = $("#add-update-userid").text();
            // if (verify_result) {
                var data = new Object();
                data.id = user_id;
                data.username = $("#update-name").val();
                data.department = $("#update-department-selector").val();
                data.category = $("#update-category-selector").val();
                data.officer_number = $("#update-officer_number").val();

                $.ajax({
                   headers : {
                       'Accept' : 'application/json',
                       'Content-Type' : 'application/json'
                   },
                   type : "POST",
                   url : "setting",
                   data : JSON.stringify(data),
                   success : function(message, tst, jqXHR) {
                       if (!util.checkSessionOut(jqXHR))
                           return false;
                       if (message.result == "success") {
                           util.success("修改成功！", function(){
                               window.location.reload();
                           });
                       } else {
                           util.error("修改用户信息失败: " + message.result);
                       }

                   },
                   error : function(jqXHR, textStatus) {
                       util.error("修改用户信息失败");
                   }
               });
            // }
        })
    },

    verifyInput : function verifyInput() {
        $(".form-message").empty();
        var result = true;
        var check_u = this.checkUsername();
        var check_p = this.checkPassword();
        var check_dep = this.checkDepartment();
        var check_cat = this.checkCategory();
        var check_off = this.checkOfficerNumber();
        result = check_u && check_p && check_dep && check_cat && check_off;
        return result;
    },

    checkUsername : function checkUsername() {
        var username = $(".form-username input").val();
        if (username == "") {
            $(".form-username .form-message").text("用户名不能为空");
            return false;
        } else if (username.length > 20 || username.length < 5) {
            $(".form-username .form-message").text("请保持在5-20个字符以内");
            return false;
        } else {
            var re=/[\+|\-|\\|\/||&|!|~|@|#|\$|%|\^|\*|\(|\)|=|\?|´|"|<|>|\.|,|:|;|\]|\[|\{|\}|\|]+/;
            if(re.test(username)){
                $(".form-username .form-message").text("只能是数字字母或者下划线的组合");
                return false;
            }else return true;


        }
        return true;
    },

    checkPassword : function checkPassword() {
        var password = $(".form-password input").val();
        if (password == "") {
            $(".form-password .form-message").text("密码不能为空");
            return false;
        } else if (password.length < 6 || password.length > 20) {
            $(".form-password .form-message").text("密码请保持在6到20个字符以内");
            return false;
        } else {
            return true;
        }
        return true;
    },

    checkDepartment : function checkDepartment() {
        var department = $("#department-selector").val();
        if (department == "") {
            $(".form-department .form-message").text("部门不能为空");
            return false;
        }
        return true;
    },

    checkCategory : function checkCategory() {
        var category = $("#category-selector").val();
        if (category == "") {
            $(".form-category .form-message").text("警种不能为空！");
            return false;
        }
        return true;
    },

    checkOfficerNumber : function checkOfficerNumber() {
        var officer_number = $(".form-officer_number input").val();
        if (officer_number == "") {
            $(".form-officer_number .form-message").text("警号不能为空！");
            return false;
        }
        return true;
    }
};