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
		<title>综合管理-个人中心</title>
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
	  <style>
		  .form-group p {
			  margin: 6px 0;
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
			<div id="login-info" class="col-xs-11">
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
		<%--			</div>--%>
	</header>

		<!-- Navigation bar starts -->
		<div class="navbar bs-docs-nav" role="banner">
			<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
				<ul class="nav navbar-nav">
					<li>
						<a href="home">教学资料</a>
					</li>
					<li>
						<a href="student/practice">模拟考试</a>
					</li>
					<li>
						<a href="student/exam">正式考试</a>
					</li>
					<li class="active">
						<a href="student/result">综合管理</a>
					</li>
				</ul>
			</nav>
		</div>
		<!-- Navigation bar ends -->

		<div style="margin-bottom: 100px;">
			<div class="col-xs-2" style="padding-left:0">
				<ul class="nav default-sidenav" style="border-right: 1px solid #666;">
					<li >
						<a href="student/result"> <i class="fa fa-list-ul"></i> 成绩查询 </a>
					</li>
					<li class="active">
						<a href="student/info"><i class="fa fa-list-ul"></i> 个人中心 </a>
					</li>
				</ul>

			</div>
			<div class="col-xs-9">
				<div class="page-header">
					<h1> 个人中心</h1>
				</div>
				<div class="page-content row">
					<form class="form-horizontal" id="form-change-info" style="margin-top:40px;">
						<div class="form-group form-username">
							<label class="control-label col-md-2">账号：</label>
							<div class="col-md-3">
								<input type="text" class="form-control" id="username" disabled="disabled" value="${user.username }">
							</div>
						</div>
						<div class="form-group form-username">
							<label class="control-label col-md-2">部门：</label>
							<div class="col-md-5">
								<p>${user.department }</p>
							</div>
						</div>
						<div class="form-group form-username">
							<label class="control-label col-md-2">警种：</label>
							<div class="col-md-5">
								<p>${user.category }</p>
							</div>
						</div>
						<div class="form-group form-username">
							<label class="control-label col-md-2">警号：</label>
							<div class="col-md-5">
								<p>${user.officer_number }</p>
							</div>
						</div>
						<div class="form-group form-username">
							<label class="control-label col-md-2" for="phone">手机：</label>
							<div class="col-md-3">
								<input type="text" class="form-control" id="phone" value="${user.phone }">
								<span class="form-message"></span>
							</div>
						</div>
						<div class="form-group form-email">
							<label class="control-label col-md-2" for="email">邮箱：</label>
							<div class="col-md-3">
								<input type="text" class="form-control" id="email" value="${user.email }">
								<span class="form-message"></span>
							</div>
						</div>
						<div class="form-group form-email">
							<label class="control-label col-md-2" for="email">最后登录时间：</label>
							<div class="col-md-3">
								<p><fmt:formatDate value="${user.lastLoginTime }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-5 col-md-offset-2">
								<button type="button" class="btn btn-primary" id="btn-update-info">
									确认修改
								</button>
								<button type="button" class="btn btn-warning" id="btn-change-pwd" style="margin-left: 20px">
									修改密码
								</button>
							</div>
						</div>
					</form>
					<!-- 修改密码modal -->
					<div class="modal fade" id="change-pwd-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h6 class="modal-title" id="myModalLabel">修改密码</h6>
								</div>
								<div class="modal-body">
									<form class="form-horizontal" id="form-change-password" style="margin-top:40px;">
										<div class="form-group form-password">
											<label class="control-label col-md-4" for="password">新密码：</label>
											<div class="col-md-5">
												<input type="password" class="form-control" id="password">
												<span class="form-message"></span>
											</div>
										</div>
										<div class="form-group form-password-confirm">
											<label class="control-label col-md-4" for="password">确认新密码：</label>
											<div class="col-md-5">
												<input type="password" class="form-control" id="password-confirm">
												<span class="form-message"></span>
											</div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="submit" class="btn btn-primary">确定修改</button>
								</div>
							</div>
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
		<script type="text/javascript" src="resources/js/modify-user.js"></script>
	</body>
</html>