$(function() {

	question_list.initial();
});

var question_list = {
	initial : function initial() {
		this.bindChangeSearchParam();
		this.bindChangeSearchParam2();
		this.bindChangeProperty();
		this.bindUpdateExampaper();
		this.publishPaper();
		this.deletePaper();
		this.offlinePaper();
	},
	
	bindChangeSearchParam : function bindChangeSearchParam(){
		$("#question-filter dl dd span").click(function(){
			if($(this).hasClass("label"))return false;

			var genrateParamOld = question_list.genrateParamOld();
			
			if($(this).parent().parent().attr("id") == "question-filter-status"){
				genrateParamOld.status = $(this).data("id");
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

	// 多选框查询
	bindChangeSearchParam2 : function bindChangeSearchParam2(){
		$("#question-filter-search").click(function(){
			var genrateParamOld = question_list.genrateParamOld();

			if($(this).parent().parent().attr("id") == "question-filter-status"){
				genrateParamOld.status = $(this).data("id");
				question_list.redirectUrl(genrateParamOld);
			} else if ($(this).parent().parent().attr("id") == "question-filter-starttime") {
				genrateParamOld.starttime = $('#laydate2-hidden').val();
				question_list.redirectUrl(genrateParamOld);
			} else if ($(this).parent().parent().attr("id") == "question-filter-title-input") {
				genrateParamOld.name = $('#question-filter-title-input').val();
				question_list.redirectUrl(genrateParamOld);
			} else if ($(this).parent().parent().attr("id") == "question-filter-department") {
				var departments = $("#question-filter-department select").val();
				if (departments != null) {
					genrateParamOld.departments = departments.toString();
				}
				question_list.redirectUrl(genrateParamOld);
			} else {
				var categories = $("#question-filter-category select").val();
				if (categories != null) {
					genrateParamOld.categories = categories.toString();
				}
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

	publishPaper : function publishPaper(){
		$(".publish-paper").click(function(){
			var paper_id = $(this).parent().parent().find("input").val();
			if (confirm("确定上线吗？上线后的试卷将可以进行考试")) {
				$.ajax({
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					type : "POST",
					url : "admin/paper-publish",
					data : JSON.stringify(paper_id),
					success : function(message, tst, jqXHR) {
						if (!util.checkSessionOut(jqXHR))
							return false;
						if (message.result == "success") {
							util.success("试卷成功上线",function(){
								window.location.reload();
							});
						} else {
							util.error("操作失败请稍后尝试:" + message.result);
						}
	
					},
					error : function(jqXHR, textStatus) {
						util.error("操作失败请稍后尝试");
					}
				});
			}
		});
	},
	
	offlinePaper : function offlinePaper(){
		$(".offline-paper").click(function(){
			var paper_id = $(this).parent().parent().find("input").val();
			if (confirm("确定下线吗？下线后的试卷将无法再进行考试")) {
				$.ajax({
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					type : "POST",
					url : "admin/paper-offline",
					data : JSON.stringify(paper_id),
					success : function(message, tst, jqXHR) {
						if (!util.checkSessionOut(jqXHR))
							return false;
						if (message.result == "success") {
							util.success("试卷已成功下线",function(){
								window.location.reload();
							});
						} else {
							util.error("操作失败请稍后尝试:" + message.result);
						}
	
					},
					error : function(jqXHR, textStatus) {
						util.error("操作失败请稍后尝试");
					}
				});
			}
		});
	},
	
	deletePaper : function deletePaper(){
		$(".delete-paper").click(function(){
			var paper_id = $(this).parent().parent().find("input").val();
			if (confirm("确定删除？")) {
				$.ajax({
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					type : "POST",
					url : "admin/paper-delete",
					data : JSON.stringify(paper_id),
					success : function(message, tst, jqXHR) {
						if (!util.checkSessionOut(jqXHR))
							return false;
						if (message.result == "success") {
							util.success("删除成功",function(){
								window.location.reload();
								
							});
							
						} else {
							util.error("操作失败请稍后尝试:" + message.result);
						}
	
					},
					error : function(jqXHR, textStatus) {
						util.error("操作失败请稍后尝试");
					}
				});
			}
		});
	},
	
	genrateParamOld :function genrateParamOld(){
		var data = new Object();
		var status = $("#question-filter-status dd .label").data("id");
		var starttime = $("#laydate2-hidden").val();
		var name = $("#question-filter-title-input").val();
		var departments = $("#question-filter-department select").val();
		var categories = $("#question-filter-category select").val();

		data.status = status;
		data.starttime = starttime != '' ? starttime : 0;
		data.name = name != '' ? name : 0;
		data.departments = departments != null ? departments.toString() : 0;
		data.categories = categories != null ? categories.toString() : 0;
		data.page = 1;
		return data;
	},

	redirectUrl : function(newparam) {
		var status = newparam.status;
		var starttime = newparam.starttime;
		if (starttime != 0) {
			starttime = starttime.replace(/-/g, "/");
			starttime = new Date(starttime).getTime();
		}
		var departments = newparam.departments;
		var categories = newparam.categories;
		var paramurl = status + "-" + departments
					   + "-" + categories + "-" + starttime
					   + "-" + newparam.name + "-" + newparam.page + ".html";

		document.location.href = document.getElementsByTagName('base')[0].href
				+ 'admin/paper-' + paramurl;
	},
	
	bindChangeProperty : function bindChangeProperty(){
		$(".change-property").click(function(){
			$("#change-property-modal").modal({backdrop:true,keyboard:true});

			$('.add-update-department select').select2({
				   placeholder: "请选择",
				   multiple: true,
					width:'200px',
				   data: [
					   {id: 1, text: '刑事部门'},
					   {id: 2, text: '治安部门'},
					   {id: 3, text: '交通管理部门'},
					   {id: 4, text: '消防部门'},
					   {id: 5, text: '出入境部门'},
					   {id: 6, text: '人口管理部门'},
					   {id: 7, text: '内安全保卫部门'}]
			   });

			$('.add-update-category select').select2({
				placeholder: "请选择",
				 multiple: true,
				 width:'200px',
				data: [
					 {id: 1, text: '治安警察'},
					 {id: 2, text: '交通警察'},
					 {id: 3, text: '外事警察'},
					 {id: 4, text: '禁毒警察'},
					 {id: 5, text: '监所警察'},
					 {id: 6, text: '公安法医'}]
			 });
			
			var tr = $(this).parent().parent();
			var paper_name = tr.find(".td-paper-name").text();
			var paper_type = tr.find(".td-paper-type").data("id");
			var paper_duration  = tr.find(".td-paper-duration").text();
			var paper_starttime  = tr.find(".td-paper-starttime").text();
			var paper_departments  = tr.find(".td-paper-departments").text();
			var paper_categories  = tr.find(".td-paper-categories").text();
			var paper_id =  $(this).parent().parent().find(":checkbox").val();
			$(".add-update-exampapername input").val(paper_name);
			$(".add-update-duration input").val(paper_duration);
			$("#exampaper-type-select").val(paper_type);
			$("#add-update-exampaperid").text(paper_id);
			$("#laydate1").val(paper_starttime.trim());
			// 多选框赋值
			$(".add-update-department select").val(paper_departments.split(',')).trigger('change');
			$(".add-update-category select").val(paper_categories.split(',')).trigger('change');
		});
	},

	bindUpdateExampaper : function bindUpdateExampaper(){
		$("#update-exampaper-btn").click(function(){
			var verify_result = question_list.verifyInput();
			var paper_id = $("#add-update-exampaperid").text();
			if (verify_result) {
				
				var data = new Object();
				data.id = paper_id;
				data.name = $(".add-update-exampapername input").val();
				data.duration = $(".add-update-duration input").val();
				// data.paper_type = $("#exampaper-type-select").val();
				data.start_time = $("#laydate1-hidden").val();
				data.departments = $(".add-update-department select").val().toString();
				data.categories = $(".add-update-category select").val().toString();
				$.ajax({
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					type : "POST",
					url : "admin/paper-update",
					data : JSON.stringify(data),
					success : function(message, tst, jqXHR) {
						if (!util.checkSessionOut(jqXHR))
							return false;
						if (message.result == "success") {
							util.success("修改成功", function(){
								window.location.reload();
							});
						} else {
							util.error("操作失败请稍后尝试:" + message.result);
						}

					},
					error : function(jqXHR, textStatus) {
						util.error("操作失败请稍后尝试");
					}
				});
			}
		});
	},
	
	verifyInput : function verifyInput() {
		$(".form-message").empty();
		$(".has-error").removeClass("has-error");
		var result = true;
		var r_checkName = question_list.checkName();
		var r_checkDuration = question_list.checkDuration();
		var r_checkStarttime = question_list.checkStarttime();
		var r_checkDepartment = question_list.checkDepartment();
		var r_checkCategory = question_list.checkCategory();
		result = r_checkName && r_checkDuration && r_checkStarttime && r_checkDepartment && r_checkCategory;
		return result;
	},
	checkDuration : function checkDuration() {
		var duration = $(".add-update-duration input").val();
		if (duration == "") {
			$(".add-update-duration .form-message").text("请输入考试时长（如：120）");
			return false;
		} else if (isNaN(duration)) {
			$(".add-update-duration .form-message").text("请输入数字");
			return false;
		} else if (!(duration > 30 && duration < 241)) { 
			$(".add-update-duration .form-message").text("数字范围无效，考试的时长必须设置在30到240的范围内");
			return false;
		} else {
			return true;
		}
	},

	checkStarttime : function checkStarttime() {
		var starttime = $("#laydate1").val();
		if (starttime == "" || starttime == null) {
			$(".add-update-starttime .form-message").text("请输入开放时间");
			return false;
		} else {
			return true;
		}
	},

	checkDepartment : function checkDepartment() {
		var departments = $(".add-update-department select").val();
		if (departments == "" || departments == null) {
			$(".add-update-department .form-message").text("请输入开放部门");
			return false;
		} else {
			return true;
		}
	},

	checkCategory : function checkCategory() {
		var categories = $(".add-update-category select").val();
		if (categories == "" || categories == null) {
			$(".add-update-category .form-message").text("请输入警种");
			return false;
		} else {
			return true;
		}
	},

	checkName : function checkName() {
		var name = $(".add-update-exampapername input").val();
		if (name == "") {
			$(".add-update-exampapername .form-message").text("请输入试卷名称");
			$(".add-update-exampapername input").focus();
			$(".add-update-exampapername input").addClass("has-error");
			return false;
		} else if (name.length > 10) {
			$(".add-update-exampapername .form-message").text("内容过长，请保持在10个字符以内");
			$(".add-update-exampapername input").focus();
			$(".add-update-exampapername input").addClass("has-error");
			return false;
		} else {
			return true;
		}
	},
};