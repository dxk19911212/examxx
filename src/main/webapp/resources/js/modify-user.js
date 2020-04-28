$(function() {
	create_account.initial();
});

var create_account = {
	initial : function initial() {
		this.bindSubmitForm();
		this.bindOpenPwdModal();
		this.bindchangePwdForm();
	},

	// 修改个人信息
	bindSubmitForm : function bindSubmitForm() {
		$("#btn-update-info").click(function () {
			var result = create_account.verifyInput();
			if (result) {
				var data = new Object();
				data.username = $("#username").val();
				data.email = $("#email").val();
				data.phone = $("#phone").val();
				$.ajax({
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					type : "POST",
					url : "setting",
					data : JSON.stringify(data),
					success : function(message, tst, jqXHR) {
						if (message.result == "success") {
							util.success("修改成功", function() {
								window.location.reload();
							});
						} else {
							util.error("修改个人信息失败");
						}
					},
					error : function(jqXHR, textStatus) {
						util.error("修改个人信息失败");
					}
				});
			}
		})
	},

	// 打开修改密码modal
	bindOpenPwdModal : function bindOpenPwdModal(){
		// 先清空modal中的值
		$("#password").val("");
		$("#password-confirm").val("");
		// 再弹出
		$("#btn-change-pwd").click(function() {
			$("#change-pwd-modal").modal({backdrop:true,keyboard:true});
		});
	},

	// 修改密码
	bindchangePwdForm : function bindchangePwdForm() {
		$("#form-change-password").click(function () {
			var result = create_account.verifyInput();
			if (result) {
				var user = new Object();
				var password = $("#password").val();
				var password_confirm = $("#password-confirm").val();
				if(password !== password_confirm){
					$(".form-password-confirm .form-message").text("两次密码不一致！");
					return false;
				}
				if(password.length > 10 || password.length <6){
					$(".form-password .form-message").text("长度请保持在6到10之间！");
					return false;
				}
				user.password = password;
				$.ajax({
				   headers : {
					   'Accept' : 'application/json',
					   'Content-Type' : 'application/json'
				   },
				   type : "POST",
				   url : "student/change-pwd",
				   data : JSON.stringify(user),
				   success : function(message, tst, jqXHR) {
					   if (!util.checkSessionOut(jqXHR))
						   return false;
					   if (message.result == "success") {
						   util.success("修改密码成功！", function() {
							   $("#change-pwd-modal").modal('hide');
						   });
					   } else {
						   util.error("修改密码失败");
					   }
				   },
				   error : function(jqXHR, textStatus) {
					   util.error("修改密码失败");
				   }
			   });
			}
		})
	},

	verifyInput : function verifyInput() {
		$(".form-message").empty();
		var result = true;
		var check_e = this.checkEmail();
		result = check_e;
		return result;
	},
	checkEmail : function checkEmail() {
		var email = $(".form-email input").val();
		if (email == "") {
			$(".form-email .form-message").text("邮箱不能为空");
			return false;
		} else if (email.length > 40 || email.length < 5) {
			$(".form-email .form-message").text("请保持在5-40个字符以内");
			return false;
		} else {
			var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		   if(re.test(email)){
			   return true;
		   }else{
			   $(".form-email .form-message").text("无效的邮箱");
				return false;
		   }
		}
		return true;
	},
};