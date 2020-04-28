<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- <%@taglib uri="spring.tld" prefix="spring"%> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>会员管理</title>
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
		<link href="resources/css/exam.css" rel="stylesheet">
		<style type="text/css">
			.disable-btn, .enable-btn{
				text-decoration: underline;
			}
			.disable-btn, .enable-btn, .btn-update-user{
				cursor:pointer;
			}
		</style>
	</head>

	<body>
		<header>
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
						<div id="login-info-user">
							<a href="user-login-page"> 请登录</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

		<!-- Navigation bar starts -->
		<div class="navbar bs-docs-nav" role="banner">
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
		</div>
		<!-- Navigation bar ends -->

		<div style="margin-bottom: 100px;">
			<div class="col-xs-2" style="padding-left:0">
				<ul class="nav default-sidenav" style="border-right: 1px solid #666;">
					<li>
						<a href="admin/question"> <i class="fa fa-list-ul"></i> 试题管理 </a>
					</li>
					<li>
						<a href="admin/paper"> <i class="fa fa-list-ul"></i> 试卷管理 </a>
					</li>
					<li>
						<a href="admin/media"> <i class="fa fa-list-ul"></i> 资料上传 </a>
					</li>
					<li class="active">
						<a href="admin/user-list"> <i class="fa fa-list-ul"></i> 会员管理 </a>
					</li>
				</ul>
			</div>
			<div class="col-xs-10">
				<div class="page-content row">
					<div id="question-filter">
						<span style="margin-left: 50px;">
							<a class="btn btn-primary" id="btn-add-user">添加会员</a>
						</span>
					</div>
					<div id="question-list" style="margin-top: 20px">
						<table class="table-striped table">
							<thead>
								<tr>
									<td></td>
									<td>ID</td>
									<td>用户名</td>
									<td>邮箱</td>
									<td>部门</td>
									<td>警种</td>
									<td>警号</td>
									<td>创建时间</td>
									<td>状态</td>
									<td>操作</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${userList }" var="item">
									<tr>
										<td>
											<input type="checkbox" value="${item.id }">
										</td>
										<td>${item.id }</td>
										<td class="td-username">${item.username }</td>
										<td class="td-email">${item.email }</td>
										<td class="td-department">${item.department }</td>
										<td class="td-category">${item.category }</td>
										<td class="td-officer_number">${item.officer_number }</td>
										<td>
											<fmt:formatDate value="${item.create_date }" pattern="yyyy-MM-dd"/>
										</td>
										<td>
											<c:choose>
												<c:when test="${item.enabled == 1 }">
													<span class="label label-success">启用</span>
												</c:when>
												<c:when test="${item.enabled == 0 }">
													<span class="label label-danger">注销</span>
												</c:when>
												<c:otherwise>
													其他
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<a class="btn-update-user">修改信息</a>
											<c:choose>
												<c:when test="${item.enabled == 1 }">
													<span class="disable-btn" data-id="${item.id}">禁用</span>
												</c:when>
												<c:when test="${item.enabled == 0 }">
													<span class="enable-btn" data-id="${item.id}">启用</span>
												</c:when>
											</c:choose>
										</td>
									</tr>
								</c:forEach>

							</tbody><tfoot></tfoot>
						</table>
					</div>
					<div id="page-link-content">
						<ul class="pagination pagination-sm">${pageStr}</ul>
					</div>
				</div>
			</div>
			<!-- 添加会员modal -->
			<div class="modal fade" id="add-user-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h6 class="modal-title" id="myModalLabel">添加会员</h6>
						</div>
						<div class="modal-body">
							<form id="user-add-form">
								<div class="form-line form-username" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>用户名：</span>
									<input type="text" class="df-input-narrow" id="name">
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-password" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>密码：</span>
									<input type="password" class="df-input-narrow" id="password">
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-department" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>部门：</span>
									<select class="js-example-basic-multiple" id="department-selector"></select>
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-category" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>警种：</span>
									<select class="js-example-basic-multiple" id="category-selector"></select>
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-officer_number" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>警号：</span>
									<input type="text" class="df-input-narrow" id="officer_number">
									<span class="form-message"></span><br>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button id="btn-save" type="button" class="btn btn-primary">确定</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 修改会员modal -->
			<div class="modal fade" id="update-user-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h6 class="modal-title" id="myModalLabel">添加会员</h6>
						</div>
						<div class="modal-body">
							<form id="user-update-form">
								<span id="add-update-userid" style="display:none;"></span>
								<div class="form-line form-username" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>用户名：</span>
									<input type="text" class="df-input-narrow" id="update-name">
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-department" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>部门：</span>
									<select class="js-example-basic-multiple" id="update-department-selector"></select>
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-category" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>警种：</span>
									<select class="js-example-basic-multiple" id="update-category-selector"></select>
									<span class="form-message"></span><br>
								</div>
								<div class="form-line form-officer_number" style="display: block;">
									<span class="form-label"><span class="warning-label">*</span>警号：</span>
									<input type="text" class="df-input-narrow" id="update-officer_number">
									<span class="form-message"></span><br>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button id="btn-update" type="button" class="btn btn-primary">确定</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/add-user.js"></script>
		<script type="text/javascript" src="resources/js/select/select2.min.js"></script>
		<link href="resources/js/select/select2.min.css" rel="stylesheet">
		<script>
			$(function(){
				$('#department-selector').select2({
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

				$('#category-selector').select2({
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

				$(".disable-btn").click(function(){
					var message = "确定要禁用该用户吗？";
					var answer = confirm(message);
					if(!answer){
						return false;
					}
					
					jQuery.ajax({
						headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						},
						type : "GET",
						url : 'admin/disable-user/' + $(this).data("id"),
						success : function(message,tst,jqXHR) {
							if(!util.checkSessionOut(jqXHR))return false;
							if (message.result == "success") {
								util.success("操作成功！", function(){
									 window.location.reload();
								});
							} else {
								util.error(message.result);
							}
						},
						error : function(jqXHR, textStatus) {
							util.error("操作失败请稍后尝试");
						}
					});
					
				});
				
				$(".enable-btn").click(function(){
					var message = "确定要启用该用户吗？";
					var answer = confirm(message);
					if(!answer){
						return false;
					}
					jQuery.ajax({
						headers : {
							'Accept' : 'application/json',
							'Content-Type' : 'application/json'
						},
						type : "GET",
						url : 'admin/enable-user/' + $(this).data("id"),
						success : function(message,tst,jqXHR) {
							if(!util.checkSessionOut(jqXHR))return false;
							if (message.result == "success") {
								util.success("操作成功！", function(){
									 window.location.reload();
								});
							} else {
								util.error(message.result);
							}
						},
						error : function(jqXHR, textStatus) {
							util.error("操作失败请稍后尝试");
						}
					});
					
				});
			});
		
		</script>
	</body>
</html>