<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>试题管理</title>
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">

		<link href="resources/css/question-add.css" rel="stylesheet">
		<link href="resources/css/exam.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
		<link href="resources/css/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" type="text/css" />
		<style>
			.examing-point{
				display:block;
				font-size:10px;
				margin-top:5px;
			}
			.question-name-td{
				width:300px;
			}
			.change-property, .delete-question, .add-tag-btn{
				cursor:pointer;
			}
			span.add-img{
				text-decoration: underline;
				cursor:pointer;
			}
			span.add-img:hover{
				text-decoration: underline;
			}
			.add-content-img{
				display:block;
			}
		</style>
	</head>

	<body>
		<header>
<%--			<div class="container">--%>
				<div class="row" style="background-image: url(resources/images/bpic.png); margin-right: 0">
					<div class="col-xs-1">
						<div class="logo">
							<h1><a href="#"><img alt="" src="resources/images/blogo.png"></a></h1>
						</div>
					</div>
					<div class="col-xs-11" id="login-info">
						<c:choose>
							<c:when test="${not empty sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
								<div id="login-info-user">

									<a href="#" id="system-info-account">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
									<span>|</span>
									<a href="j_spring_security_logout"><i class="fa fa-sign-out"></i> 退出</a>
								</div>
							</c:when>
							<c:otherwise>
								<a class="btn btn-primary" href="user-register">用户注册</a>
								<a class="btn btn-success" href="user-login-page">登录</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
<%--			</div>--%>
		</header>

		<!-- Navigation bar starts -->
		<div class="navbar bs-docs-nav" role="banner">
<%--			<div class="container">--%>
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<ul class="nav navbar-nav">
						<li>
							<a href="home">教学资料</a>
						</li>
						<li class="active">
							<a href="admin/question">综合管理</a>
						</li>
					</ul>
				</nav>
<%--			</div>--%>
		</div>
		<!-- Navigation bar ends -->

		<div style="margin-bottom: 100px;">
<%--			<div class="container">--%>
<%--				<div class="row">--%>
					<div class="col-xs-2" style="padding-left:0">
						<ul class="nav default-sidenav" style="border-right: 1px solid #666;">
							<li class="active">
								<a href="admin/question"> <i class="fa fa-list-ul"></i> 试题管理 </a>
							</li>
							<li>
								<a href="admin/paper"> <i class="fa fa-list-ul"></i> 试卷管理 </a>
							</li>
							<li>
								<a href="admin/media"> <i class="fa fa-list-ul"></i> 资料上传 </a>
							</li>
						</ul>
					</div>

					<div class="col-xs-10">
<%--						<div class="page-header">--%>
<%--							<h1><i class="fa fa-list-ul"></i> 试题管理 </h1>--%>
<%--						</div>--%>
						<div class="page-content row">

							<div id="question-filter">
								<dl id="question-filter-field">
									<dt>
										题库：
									</dt>
									<dd>
										<c:choose>
											<c:when test="${questionFilter.fieldId == 0 }">
												<span data-id="0" class="label label-info">全部</span>
											</c:when>
											<c:otherwise>
												<span data-id="0">全部</span>
											</c:otherwise>
										</c:choose>
										<c:forEach items="${fieldList}" var="field">
											<c:choose>
												<c:when test="${questionFilter.fieldId == field.fieldId }">
													<span class="label label-info" data-id="${field.fieldId}">${field.fieldName}</span>
												</c:when>
												<c:otherwise>
													<span data-id="${field.fieldId}">${field.fieldName}</span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</dd>
								</dl>
								<dl id="question-filter-qt">
									<dt>
										试题类型：
									</dt>
									<dd>
										<c:choose>
											<c:when test="${questionFilter.questionType == 0 }">
												<span data-id="0" class="label label-info">全部</span>
											</c:when>
											<c:otherwise>
												<span data-id="0">全部</span>
											</c:otherwise>
										</c:choose>
										<c:forEach items="${questionTypeList}" var="questionType">
											<c:choose>
												<c:when test="${questionFilter.questionType == questionType.id }">
													<span data-id="${questionType.id}" class="label label-info">${questionType.name}</span>
												</c:when>
												<c:otherwise>
													<span data-id="${questionType.id}">${questionType.name}</span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</dd>
								</dl>
								<dl id="question-filter-knowledge">
									<dt>
										知识分类：
									</dt>
									<dd>
										<c:choose>
											<c:when test="${questionFilter.knowledge == 0 }">
												<span data-id="0" class="label label-info">全部</span>
											</c:when>
											<c:otherwise>
												<span data-id="0">全部</span>
											</c:otherwise>
										</c:choose>
										<c:forEach items="${knowledgeList}" var="knowledge">
											<c:choose>
												<c:when test="${questionFilter.knowledge == knowledge.pointId }">
													<span data-id="${knowledge.pointId}" class="label label-info">${knowledge.pointName}</span>
												</c:when>
												<c:otherwise>
													<span data-id="${knowledge.pointId}">${knowledge.pointName}</span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</dd>
								</dl>
								<dl id="question-filter-title" style="margin-left: 10px;">
									<span>试题名称：</span>
									<span>
										<input id="question-filter-title-input" type="text" value="${questionFilter.searchParam}"
											   class="form-control" style="background-color: #ffffff">
									</span>
									<a class="btn btn-primary">查询</a>
								</dl>
							</div>
							<div class="col-md-10">
								<a class="btn btn-primary" data-toggle="modal" data-target=".question-add">添加试题</a>
								<a class="btn btn-primary" data-toggle="modal" data-target=".question-import">导入试题</a>
							</div>
							<div class="page-link-content">
								<ul class="pagination pagination-sm">${pageStr}</ul>
							</div>
							<div id="question-list">
								<input id="field-id-hidden" value="${fieldId }" type="hidden">
								<input id="knowledge-hidden" value="${knowledge }" type="hidden">
								<input id="question-type-hidden" value="${questionType }" type="hidden">
								<input id="search-param-hidden" value="${searchParam }" type="hidden">
								<table class="table-striped table">
									<thead>
									<tr>
										<td></td>
										<td>ID</td>
										<td class="question-name-td" style="width:240px">试题名称</td>
										<td style="width:80px">试题类型</td>
										<td>专业</td>
										<td>知识类</td>
										<!-- <td>关键字</td> -->
										<td>操作</td>
									</tr>
									</thead>
									<tbody>
									<c:forEach items="${questionList }" var="items">
										<tr>
											<td>
												<input type="checkbox" value="${items.id }">
											</td>
											<td>${items.id }</td>
											<td>
												<a href="admin/question-preview/${items.id }" target="_blank" title="预览">${items.name }</a>
												<!-- 此处改成标签 -->
												<span class="examing-point">${items.examingPoint} </span>
											</td>
											<td>${items.questionTypeName }</td>
											<td>${items.fieldName }</td>
											<td>${items.pointName }</td>
											<%-- <td>${items.keyword }</td> --%>
											<td style="width:50px;">
												<a class="change-property">修改</a>
												<a class="delete-question">删除</a>
											</td>
										</tr>
									</c:forEach>
									</tbody>
									<tfoot></tfoot>
								</table>
								<!-- 修改试题modal-->
								<div class="modal fade" id="change-property-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h6 class="modal-title" id="myModalLabel">修改分类</h6>
											</div>
											<div class="modal-body">
												<form id="question-edit-form">
													<span id="add-update-questionid" style="display:none;"></span>

													<div class="form-line exampaper-type" id="aq-course3">
														<span class="form-label"><span class="warning-label">*</span>专业：</span>
														<select class="df-input-narrow">
															<c:forEach items="${fieldList}" var="field">
																<option value="${field.fieldId}">${field.fieldName} </option>
															</c:forEach>
														</select><span class="form-message"></span>
													</div>
													<div class="form-line exampaper-type" id="aq-course4">
														<span class="form-label"><span class="warning-label">*</span>知识类：</span>
														<select class="df-input-narrow">
															<c:forEach items="${knowledgeList}" var="item">
																<option value="${item.pointId}">${item.pointName} </option>
															</c:forEach>
														</select><span class="form-message"></span>
													</div>
													<div class="form-line exampaper-type" id="aq-tag">
														<span class="form-label"><span class="warning-label">*</span>标签：</span>
														<select id="tag-from-select" class="df-input-narrow">
															<c:forEach items="${tagList }" var="item">
																<option value="${item.tagId }" data-privatee="${item.privatee }" data-creator="${item.creator}" data-memo="${item.memo }" data-createtime="${item.createTime }">${item.tagName } </option>
															</c:forEach>

														</select><a class="add-tag-btn">添加</a><span class="form-message"></span>

														<div class="q-label-list">
														</div>
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
												<button id="update-exampaper-btn" type="button" class="btn btn-primary">确定修改</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="page-link-content">
								<ul class="pagination pagination-sm">${pageStr}</ul>
							</div>

							<!-- 添加试题modal-->
							<div class="modal fade question-add" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h6 class="modal-title">添加试题</h6>
										</div>
										<div class="modal-body">
<%--											<div class="col-xs-9">--%>
												<div class="page-content row">
													<form id="question-add-form" style="margin-right:40px;">
														<div class="form-line question-type" id="question-type">
															<span class="form-label"><span class="warning-label">*</span>试题类型：</span>
															<select id="question-type-select" class="df-input-narrow">
																<option value="1">单选题</option>
																<option value="2">多选题</option>
																<option value="3">判断题</option>
																<option value="4">填空题</option>
																<option value="5">简答题</option>
																<option value="6">论述题</option>
																<option value="7">分析题</option>
															</select>
															<span class="form-message"></span>
														</div>
														<div class="form-line question-knowledge">
															<span class="form-label"><span class="warning-label">*</span>知识点：</span>
															<div>
																<div class="clearfix">
																	<div id="aq-course1" style="padding:0px;float:left; width:48%;">
																		<select id="field-select" class="df-input-narrow" size="4" style="width:100%;">
																			<c:forEach items="${fieldList }" var="item">
																				<option value="${item.fieldId }">${item.fieldName }</option>
																			</c:forEach>
																		</select>
																	</div>
																	<div id="aq-course2" style="padding:0px; float:right;width:48%;">
																		<select id="point-from-select" class="df-input-narrow" size="4"  style="width:100%;">
																		</select>
																	</div>
																</div>

																<div style="text-align:center;margin:10px 0;">
																	<button id="add-point-btn" class="btn btn-primary btn-xs">选择知识点</button>
																	<button id="del-point-btn" class="btn btn-danger btn-xs">删除知识点</button>
																	<button id="remove-all-point-btn" class="btn btn-warning btn-xs">清除列表</button>
																</div>
																<div  id="kn-selected" style="padding-left:0px;text-align:center;margin-bottom:20px;">
																	<select id="point-to-select" class="df-input-narrow" size="4"  style="width:80%;">
																	</select>
																	<p style="font-size:12px;color:#AAA;">您可以从上面选择4个知识点</p>
																</div>
															</div>
															<span class="form-message"></span>
														</div>
														<div class="form-line question-content">
															<span class="form-label"><span class="warning-label">*</span>试题内容：</span>
															<textarea class="add-question-ta"></textarea>
															<span class="add-img add-content-img" style="width:100px;">添加图片</span>
															<span class="form-message"></span>
														</div>
														<div class="form-line form-question-opt" style="display: block;">
															<span class="form-label"><span class="warning-label">*</span>选项：</span>
															<div class="add-opt-items">
																<span class="add-opt-item"><label class="que-opt-no">A</label>
																	<input type="text" class="df-input-narrow form-question-opt-item">
																	<span class="add-img add-opt-img">添加图片</span>
																</span>
																						<span class="add-opt-item"><label class="que-opt-no">B</label>
																	<input type="text" class="df-input-narrow form-question-opt-item">
																	<span class="add-img add-opt-img">添加图片</span>
																</span>
																						<span class="add-opt-item"><label class="que-opt-no">C</label>
																	<input type="text" class="df-input-narrow form-question-opt-item">
																	<span class="add-img add-opt-img">添加图片</span> <span><i class="small-icon ques-remove-opt fa fa-minus-square" title="删除此选项"></i></span>
																</span>
																						<span class="add-opt-item"><label class="que-opt-no">D</label>
																	<input type="text" class="df-input-narrow form-question-opt-item">
																	<span class="add-img add-opt-img">添加图片</span> <span><i class="small-icon ques-remove-opt fa fa-minus-square" title="删除此选项"></i></span>
																</span>
															</div>
															<!--	<div class="small-icon" id="ques-add-opt" title="娣诲姞閫夐」"></div>-->
															<span id="ques-add-opt"><i class="small-icon fa fa-plus-square" title="添加选项"></i></span>
															<br>
															<span class="form-message"></span>
														</div>
														<div class="form-line form-question-answer1 correct-answer" style="display: block;">
															<span class="form-label"><span class="warning-label">*</span>正确答案：</span>
															<select class="df-input-narrow">
																<option value="A">A</option><option value="B">B</option><option value="C">C</option><option value="D">D</option>
															</select><span class="form-message"></span>
														</div>
														<div class="form-line form-question-answer-muti correct-answer" style="display: none;">
															<span class="form-label"><span class="warning-label">*</span>正确答案：</span>

															<span class="muti-opt-item">
																<input type="checkbox" value="A">
																<label class="que-opt-no">A</label>
																<br>
															</span>
															<span class="muti-opt-item">
																<input type="checkbox" value="B">
																<label class="que-opt-no">B</label>
																<br>
															</span>
															<span class="muti-opt-item">
																<input type="checkbox" value="C">
																<label class="que-opt-no">C</label>
																<br>
															</span>
															<span class="muti-opt-item">
																<input type="checkbox" value="D">
																<label class="que-opt-no">D</label>
																<br>
															</span>
															<span class="form-message"></span>
														</div>
														<div class="form-line form-question-answer-boolean correct-answer" style="display: none;">
															<span class="form-label"><span class="warning-label">*</span>正确答案：</span>
															<select class="df-input-narrow">
																<option value="T">正确</option>
																<option value="F">错误</option>
															</select><span class="form-message"></span>
														</div>
														<div class="form-line correct-answer form-question-answer-text" style="display: none;">
															<span class="form-label form-question-answer-more"><span class="warning-label">*</span>参考答案：</span>
															<textarea class="add-question-ta"></textarea>
															<span class="form-message"></span>
															<br>
														</div>
														<div class="form-line form-question-reference" style="display: block;">
															<span class="form-label"><span class="warning-label"></span>来源：</span>
															<input type="text" class="df-input-narrow"><span class="form-message"></span>
															<br>
														</div>
														<div class="form-line form-question-examingpoint" style="display: block;">
															<span class="form-label"><span class="warning-label"></span>考点：</span>
															<input type="text" class="df-input-narrow"><span class="form-message"></span>
															<br>
														</div>
														<div class="form-line form-question-keyword" style="display: block;">
															<span class="form-label"><span class="warning-label"></span>关键字：</span>
															<input type="text" class="df-input-narrow"><span class="form-message"></span>
															<br>
														</div>
														<div class="form-line form-question-analysis" style="display: block;">
															<span class="form-label"><span class="warning-label"></span>题目解析：</span>
															<textarea class="add-question-ta"></textarea><span class="form-message"></span>
															<br>
														</div>
														<div class="form-line">
															<input id="btn-save" value="保存" type="submit" class="df-submit">
														</div>
													</form>
												</div>
<%--											</div>--%>
										</div>
									</div>
								</div>
							</div>

							<!-- 导入试题modal-->
							<div class="modal fade question-import"  tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h6 class="modal-title">导入试题</h6>
										</div>
										<div class="modal-body">
											<div class="page-content row">
												<form id="question-import-form">
													<div class="form-line upload-question-group">
														<span class="form-label">选择题库：</span>
														<select class="df-input-narrow">
															<option value="0">-- 请选择 --</option>
															<c:forEach items="${fieldList }" var="item">
																<option value="${item.fieldId }">${item.fieldName }</option>
															</c:forEach>
														</select>
														<span class="form-message"></span>
													</div>
													<div class="form-line template-download">
														<span class="form-label">下载模板：</span>
														<a href="resources/template/question.xlsx" style="color:rgb(22,22,22);text-decoration: underline;">点击下载</a>
													</div>
													<div class="form-line control-group">
														<span class="form-label"><span class="warning-label">*</span>上传文件：</span>
														<div class="controls file-form-line">
															<div>
																<div id="div-file-list">
																<input type="file" id="uploadify-excel" name="uploadify">
																</div>
															</div>
															<span class="help-inline form-message"></span>
														</div>
													</div>
													<div class="form-line">
														<input value="提交" type="submit" class="df-submit">
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- 图片上传modal-->
							<div class="modal fade" id="question-upload-img">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title">图片上传工具</h4>
										</div>
										<div class="modal-body">
											<div id="add-question-img-dialog" title="图片上传工具">
<%--												<form>--%>
													<div class="form-line img-destination">
														<span class="form-label">添加至：</span>
														<label></label>
														<input type="hidden" value=""/>
													</div>
													<div class="form-line add-update-quetstionfile">
														<span class="form-label">上传图片：</span>
														<input type="file" name="file" id="upload-img">
														<div>
															<img id="img_preview" src="" style="width: 100px;">
														</div>
														<span class="form-message">请上传png、jpg图片文件，且不能大于100KB。为了使得图片显示正常，请上传的图片长宽比例为2:1</span>
													</div>
<%--												</form>--%>
											</div>
										</div>
										<div class="modal-footer">
											<button id="btn_upload" type="button" class="btn btn-primary">上传</button>
										</div>
									</div><!-- /.modal-content -->
								</div><!-- /.modal-dialog -->
							</div>
						</div>
					</div>
<%--				</div>--%>
<%--			</div>--%>
		</div>
<%--		<footer>--%>
<%--			<div class="container">--%>
<%--				<div class="row">--%>
<%--					<div class="col-md-12">--%>
<%--						<div class="copy">--%>
<%--							<p>--%>
<%--								Exam++ Copyright © <a href="http://www.examxx.net/" target="_blank">Exam++</a> - <a href="." target="_blank">主页</a> | <a href="http://www.examxx.net/" target="_blank">关于我们</a> | <a href="http://www.examxx.net/" target="_blank">FAQ</a> | <a href="http://www.examxx.net/" target="_blank">联系我们</a>--%>
<%--							</p>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</footer>--%>

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		<script type="text/javascript" src="resources/js/field-2-point.js"></script>
		<script type="text/javascript" src="resources/js/question-list.js"></script>
		<script type="text/javascript" src="resources/js/question-add.js"></script>
		<script type="text/javascript" src="resources/js/question-import.js"></script>
		<script type="text/javascript" src="resources/js/question-upload-img.js"></script>
		<!-- qiniu -->
		<script type="text/javascript" src="resources/js/qiniu/qiniu.min.js"></script>

		<script type="text/javascript">
			$(function(){
				$(".change-property").click(function(){
					$("#change-property-modal").modal({backdrop:true,keyboard:true});
					var paper_id =  $(this).parent().parent().find(":checkbox").val();
					$("#add-update-questionid").text(paper_id);
					$.ajax({
							   headers : {
								   'Accept' : 'application/json',
								   'Content-Type' : 'application/json'
							   },
							   type : "GET",
							   url : "teacher/question-tag/" + paper_id,
							   success : function(message, tst, jqXHR) {
								   if (!util.checkSessionOut(jqXHR))
									   return false;
								   if (message.result == "success") {
									   //将message.object里面的内容写到 div（class=q-label-list）里面
									   var innerHtml = "";
									   $.each(message.object,function(index,element){
										   innerHtml += "<span class=\"label label-info q-label-item\" data-privatee="
														+ element.privatee + " data-creator=" + element.creator
														+" data-memo="+ element.memo
														+" data-id="+ element.tagId
														+ ">" + element.tagName + "  <i class=\"fa fa-times\"></i>	</span>";
									   });
									   $(".q-label-list").html(innerHtml);
								   } else {
									   util.error("操作失败请稍后尝试:" + message.result);
								   }

							   },
							   error : function(jqXHR, textStatus) {
								   util.error("操作失败请稍后尝试");
							   }
						   });
				});

				$(".add-tag-btn").click(function(){
					var label_ids = $(".q-label-item");
					var flag = 0;
					label_ids.each(function(){
						if($(this).data("id") == $("#tag-from-select").val())
							flag = 1;
					});
					if(flag == 0){
						var selected = $("#tag-from-select").find("option:selected");

						$(".q-label-list").append("<span class=\"label label-info q-label-item\" data-privatee="
												  + selected.data("privatee")  + " data-creator=" + selected.data("creator")
												  +" data-memo="+ selected.data("memo")
												  +" data-id="+ $("#tag-from-select").val()
												  +" data-createTime="+ selected.data("createTime") +">"
												  + $("#tag-from-select :selected").text() + "  <i class=\"fa fa-times\"></i>	</span>");
					}
					else{
						util.error("不能重复添加");
					}
				});

				$(".q-label-list").on("click",".fa",function(){
					$(this).parent().remove();
				});

				$("#update-exampaper-btn").click(function(){
					var questionId = $("#add-update-questionid").text();
					var pointId = $("#point-from-select option:selected").val();

					if(pointId == null || pointId == ""){
						util.error("请选择知识类");
					}

					var data = new Array();
					$(".q-label-item").each(function(){
						var tag = new Object();
						tag.tagId = $(this).data("id");
						tag.questionId = questionId;
						data.push(tag);
					});
					$.ajax({
							   headers : {
								   'Accept' : 'application/json',
								   'Content-Type' : 'application/json'
							   },
							   type : "POST",
							   url : "admin/question-update/" + questionId + "/" + pointId,
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

					return false;
				});

				$(".delete-question").click(function(){
					var result = confirm("确定删除吗？删除后将不可恢复");
					var question_id =  $(this).parent().parent().find(":checkbox").val();
					if(result == true){
						jQuery.ajax({
							headers : {
								'Accept' : 'application/json',
								'Content-Type' : 'application/json'
							},
							type : "GET",
							url : 'admin/delete-question/' + question_id,
							success : function(message,tst,jqXHR) {
								if(!util.checkSessionOut(jqXHR))return false;
								if (message.result == "success") {
									util.success("删除成功！", function(){
										window.location.reload();
									});
								} else {
									util.error("操作失败请稍后尝试");
								}
							},
							error : function(jqXHR, textStatus) {
								util.error("操作失败请稍后尝试");
							}
						});
					}
				});

				$("#upload-img").change(function (e) {
					// 获取目标文件
					var file = e.target.files || e.dataTransfer.files;
					if (file) {
						var reader = new FileReader();
						// 文件装载后将其显示在图片预览里
						reader.onload = function () {
							$("#img_preview").attr("src", this.result);
						};
						// 装载文件
						reader.readAsDataURL(file[0]);
					}
				});
			});
		</script>
	</body>
</html>
