$(function() {
	question_list.initial();
});

var question_list = {
	initial : function initial() {
		this.bindChangeSearchParam();
		this.bindChangeSearchParam2();
		this.uploadFile();
		this.deleteMedia();
	},

	// 上传文件到七牛
	uploadFile: function uploadFile() {
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
					   // 先从后台获取七牛token
					   if (message.success === 1) {
						   console.log("message: "+JSON.stringify(message));

						   // 参数校验
						   var verify_result = question_list.verifyInput();
						   if (verify_result) {
							   var file = $("#upload-img")[0].files[0];
							   var domain = message.domain;
							   var key = message.imgUrl;
							   var token = message.token;
							   var putExtra = {
								   fname: "",
								   params: {},
								   mimeType: ["image/png", "image/jpeg", "image/gif", "application/pdf", "video/mp4"]
							   };
							   var config = {
								   useCdnDomain: true,
								   region: qiniu.region.z0
							   };
							   // 再将文件上传七牛云
							   var observable = qiniu.upload(file, key, token, putExtra, config);
							   observable.subscribe({
									next: (res) => {
									},
									error: (err) => {
										util.error("资料上传失败，请稍后重试");
										console.log(err);
									},
									complete: (res) => {
										util.success("资料上传成功！");
										// 上传成功后将文件信息保存后端
										// 获得文件扩展名，组装完整url
										var fileSuff = file.name.split('.').pop();
										var fileUrl = 'http://' + domain + '/' + key + '.' + fileSuff;
										// 获取文件缩略图
										// 暂不支持
										var imgLink = fileUrl;
										// var imgLink = qiniu.imageView2({
										//    mode: 3,       // 缩略模式，共6种[0-5]
										//    w: 100,        // 具体含义由缩略模式决定
										//    h: 100,        // 具体含义由缩略模式决定
										//    q: 100,        // 新图的图像质量，取值范围：1-100
										//    format: 'png'  // 新图的输出格式，取值范围：jpg，gif，png，webp等
										// }, key, domain)
										// 保存
										question_list.saveMedia(fileUrl, imgLink);
									}
								});
						   }
					   }
				   },
				   error : function(jqXHR, textStatus) {
					   util.error("获取token失败！");
				   }
			});
		})
	},

	// 保存media信息到后端
	saveMedia: function saveMedia(file_url, thumbnail_url) {
		var verify_result = question_list.verifyInput();
		if (verify_result) {
				var data = new Object();
				data.url = file_url;
				data.thumbnailUrl = thumbnail_url;
				data.title = $('.add-update-mediatitle input').val();
				data.desc = $('.add-update-mediadesc textarea').val();
				$.ajax({
				   headers : {
					   'Accept' : 'application/json',
					   'Content-Type' : 'application/json'
				   },
				   type : "POST",
				   url : "admin/media-add",
				   data : JSON.stringify(data),
				   success : function(message, tst, jqXHR) {
					   if (!util.checkSessionOut(jqXHR))
						   return false;
					   if (message.result == "success") {
						   util.success("添加成功", function() {
							   document.location.href = document.getElementsByTagName('base')[0].href + 'admin/media';
						   });
					   } else {
						   util.error("保存资料失败");
					   }
				   },
				   error : function(jqXHR, textStatus) {
					   util.error("保存资料失败");
				   }
			   });
			}
	},

	// 自动搜索的查询条件
	bindChangeSearchParam : function bindChangeSearchParam(){
		$("#question-filter dl dd span").click(function(){
			if($(this).hasClass("label"))return false;

			var genrateParamOld = question_list.genrateParamOld();
			
			if($(this).parent().parent().attr("id") == "question-filter-type"){
				genrateParamOld.type = $(this).data("id");
				question_list.redirectUrl(genrateParamOld);
			}
		});
		
		$(".pagination li a").click(function(){
			var pageId = $(this).data("id");
			if(pageId == null || pageId == "")return false;
			var genrateParamOld = question_list.genrateParamOld();
			genrateParamOld.page = pageId;
			question_list.redirectUrl(genrateParamOld);
			
		});
	},

	// 手动搜索的查询条件
	bindChangeSearchParam2 : function bindChangeSearchParam2(){
		$("#question-filter-search").click(function(){
			var genrateParamOld = question_list.genrateParamOld();

			if($(this).parent().parent().attr("id") == "question-filter-type"){
				genrateParamOld.type = $(this).data("id");
				question_list.redirectUrl(genrateParamOld);
			} else if ($(this).parent().parent().attr("id") == "question-filter-title-input") {
				genrateParamOld.title = $('#question-filter-title-input').val();
				question_list.redirectUrl(genrateParamOld);
			}
		});

		$(".pagination li a").click(function(){
			var pageId = $(this).data("id");
			if(pageId == null || pageId == "")return false;
			var genrateParamOld = question_list.genrateParamOld();
			genrateParamOld.page = pageId;
			question_list.redirectUrl(genrateParamOld);

		});
	},

	// 获取查询条件的旧值
	genrateParamOld :function genrateParamOld(){
		var data = new Object();
		var type = $("#question-filter-type dd .label").data("id");
		var title = $("#question-filter-title-input").val();

		data.type = type;
		data.title = title != '' ? title : 0;
		data.page = 1;
		return data;
	},

	// 按条件查询list 转发请求
	redirectUrl : function(newparam) {
		var type = newparam.type;
		var title = newparam.title;
		var paramurl = type + "-" + title + "-" + newparam.page + ".html";
		document.location.href =
			document.getElementsByTagName('base')[0].href + 'admin/media-' + paramurl;
	},

	// 删除media
	deleteMedia : function deletePaper(){
		$(".delete-media").click(function(){
			var media_id = $(this).parent().parent().find("input").val();
			if (confirm("确定删除？")) {
				$.ajax({
						   headers : {
							   'Accept' : 'application/json',
							   'Content-Type' : 'application/json'
						   },
						   type : "POST",
						   url : "admin/media-delete",
						   data : JSON.stringify(media_id),
						   success : function(message, tst, jqXHR) {
							   if (!util.checkSessionOut(jqXHR))
								   return false;
							   if (message.result == "success") {
								   util.success("删除成功",function(){
									   window.location.reload();
								   });
							   } else {
								   util.error("删除失败，请稍后尝试:" + message.result);
							   }
						   },
						   error : function(jqXHR, textStatus) {
							   util.error("删除失败，请稍后尝试");
						   }
					   });
			}
		});
	},

	// 合法性校验
	verifyInput : function verifyInput() {
		$(".form-message").empty();
		$(".has-error").removeClass("has-error");
		var result = true;
		var r_checkTitle = question_list.checkTitle();
		var r_checkDesc = question_list.checkDesc();
		result = r_checkTitle && r_checkDesc;
		return result;
	},
	checkTitle : function checkTitle() {
		var title = $(".add-update-mediatitle input").val();
		if (title == "") {
			$(".add-update-mediatitle .form-message").text("请输入资料标题！");
			$(".add-update-mediatitle input").focus();
			$(".add-update-mediatitle input").addClass("has-error");
			return false;
		} else if (title.length > 50) {
			$(".add-update-mediatitle .form-message").text("标题过长，请保持在50个字符以内");
			$(".add-update-mediatitle input").focus();
			$(".add-update-mediatitle input").addClass("has-error");
			return false;
		} else {
			return true;
		}
	},
	checkDesc : function checkDesc() {
		var desc = $(".add-update-mediadesc textarea").val();
		if (desc == "") {
			$(".add-update-mediadesc .form-message").text("请输入资料标题！");
			$(".add-update-mediadesc textarea").focus();
			$(".add-update-mediadesc textarea").addClass("has-error");
			return false;
		} else if (desc.length > 200) {
			$(".add-update-mediadesc .form-message").text("描述过长，请保持在200个字符以内");
			$(".add-update-mediadesc textarea").focus();
			$(".add-update-mediadesc textarea").addClass("has-error");
			return false;
		} else {
			return true;
		}
	}
};