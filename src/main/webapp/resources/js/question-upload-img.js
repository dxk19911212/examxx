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
			$("#dropzone").dropzone({
				url: "upload-img",
				maxFiles: 1,
				maxFilesize: 2,
				acceptedFiles: ".jpg,.gif,.png,.jpeg",
				addRemoveLinks: true,
				dictRemoveFile: "删除",
				dictMaxFilesExceeded: "最多只能上传1个文件！",
				dictResponseError: '文件上传失败！',
				dictInvalidFileType: "你不能上传该类型文件,文件类型只能是jpg、gif、png格式",
				dictFallbackMessage:"浏览器不受支持！",
				dictFileTooBig:"文件过大，超过上传文件最大支持！",
				success: function(file) {
					$("#question-upload-img").modal('hide');
					// 接受服务器返回的图片地址
					var fileUrl = file.xhr.response;
					var destination = $(".img-destination input").val();

					// 添加试题内容图片
					if (destination == -1) {
						var displayImg = $(".question-content").find(".diaplay-img");
						if (displayImg.length === 0) {
							$(".question-content textarea").after(
								"<a href=\"..\\" + fileUrl
								+ "\" class=\"diaplay-img display-content-img\" target=\"_blank\" data-url=\""
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
								"<a href=\"..\\" + fileUrl
								+ "\" class=\"diaplay-img display-opt-img\" target=\"_blank\" data-url=\""
								+ fileUrl + "\">预览图片</a>");
						} else {
							displayImg.attr("href", fileUrl);
						}
					}

				},
				queuecomplete: function () {
					// 每次上传完成后，清空图片队列
					this.removeAllFiles(true);
				}
			})
		},
		
		bindDisplayImg : function bindDisplayImg(){
			$("#bk-conent-question-content").delegate(".diaplay-img","click",function() {
				window.open(location.protocol + "//" + location.host + "/" + $(this).attr("href"));
				e.preventDefault();
			});
		}
		
};