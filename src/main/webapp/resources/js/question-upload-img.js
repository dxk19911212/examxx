$(function() {
	question_upload_img.init();
});

var question_upload_img = {
		init: function init(){
			this.prepareUploadify();
			this.prepareDialog();
			this.bindDisplayImg();
		},
		
		prepareDialog : function prepareDialog() {
			$("#question-add-form").on("click",".add-img",function() {
				$("#question-upload-img").modal({backdrop:true,keyboard:true});

//				$("#add-question-img-dialog").dialog("open");
				$("#file-name").empty();
				
				if($(this).hasClass("add-content-img")){
					$(".img-destination label").text("试题内容");
					$(".img-destination input").val(-1);
				}else if($(this).hasClass("add-opt-img")){
					$(".img-destination label").text("试题选项 ");
					var this_index = $(".add-opt-img").index($(this));
					$(".img-destination label").append(String.fromCharCode(65 + this_index));
					$(".img-destination input").val(this_index);
				}
			});
		},

		prepareUploadify : function prepareUploadify(){
			$("#btn_upload").click(function () {
				$.ajax({
				   headers : {
					   'Accept' : 'application/json',
					   'Content-Type' : 'application/json'
				   },
				   type : "GET",
				   url : "get-qiniu-token",
				   success : function(message, tst, jqXHR) {
					   if (!util.checkSessionOut(jqXHR))
						   return false;
					   // 从后台获取七牛token
					   if (message.success === 1) {
						   var file = $("#upload-img")[0].files[0];
						   var domain = message.domain;
						   var key = message.imgUrl;
						   var token = message.token;
						   var putExtra = {
							   fname: "",
							   params: {},
							   mimeType: ["image/png", "image/jpeg", "image/gif"]
						   };
						   var config = {
							   useCdnDomain: true,
							   region: qiniu.region.z0
						   };
						   // 将文件上传七牛云
						   var observable = qiniu.upload(file, key, token, putExtra, config);
						   observable.subscribe({
							next: (res) => {
							},
							error: (err) => {
								util.error("图片上传失败，请稍后重试");
								console.log(err);
							},
							complete: (res) => {
								util.success("图片上传成功！");
								// 组装完整url
								var fileUrl = 'http://' + domain + '/' + key;
								var destination = $(".img-destination input").val();

								// 添加试题内容图片
								if (destination == -1) {
									var displayImg = $(".question-content").find(".diaplay-img");
									if (displayImg.length === 0) {
										$(".question-content textarea").after(
											"<a href=\"" + fileUrl + "\" class=\"diaplay-img display-content-img\" target=\"_blank\" data-url=\""
											+ fileUrl + "\">预览图片</a>");
									} else {
										displayImg.attr("href", fileUrl);
									}
								}
								// 添加试题选项图片
								else {
									var thisopt = $($(".add-opt-item")[destination]);
									var displayImg = thisopt.find(".diaplay-img");

									if (displayImg.length === 0) {
										thisopt.find("input.form-question-opt-item").after(
											"<a href=\"" + fileUrl + "\" class=\"diaplay-img display-content-img\" target=\"_blank\" data-url=\""
											+ fileUrl + "\">预览图片</a>");
									} else {
										displayImg.attr("href", fileUrl);
									}
								}

								// 添加图片完毕，modal去除，input值清空，预览图清空
								$("#question-upload-img").modal('hide');
								$("#upload-img").val('');
								$("#img_preview").attr("src", "");
							}
						});
					   }
				   },
				   error : function(jqXHR, textStatus) {
					   util.error("获取token失败！");
				   }
			   });
			})
		},
		
		bindDisplayImg : function bindDisplayImg(){
			$("#bk-conent-question-content").delegate(".diaplay-img","click",function() {
				window.open(location.protocol + "//" + location.host + "/" + $(this).attr("href"));
				e.preventDefault();
			});
		}
		
};