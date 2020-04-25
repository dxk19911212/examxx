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
		<title>试题管理-试题预览</title>
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/exam.css" rel="stylesheet" type="text/css">
		<link href="resources/css/style.css" rel="stylesheet">
		
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
							<a class="btn btn-primary" href="user-register">用户注册</a>
							<a class="btn btn-success" href="user-login-page">登录</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
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
				<div class="page-header">
					<h1> 预览试题 </h1>
				</div>
				<div class="page-content row">
					<div class="def-bk" id="bk-exampaper">
						<div class="expand-bk-content" id="bk-conent-exampaper">
							<ul id="exampaper-body" style="padding:0px;">
								${strHtml }
								<div class="answer-desc-detail">
									<label class="label label-primary"><i class="fa fa-check-square-o"></i><span> 添加人</span></label>
									<div class="answer-desc-content">
										${question.creator }
									</div>
								</div>
							</ul>
							<div id="exampaper-footer" style="height: 187px;text-align:center;margin-top:40px;">
								<button class="btn btn-info" onclick="javascript:window.close();"><i class="fa fa-times"></i> 关闭页面</button>
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
		<script type="text/javascript" src="resources/js/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="resources/js/question-upload-img.js"></script>
		<script type="text/javascript" src="resources/js/field-2-point.js"></script>
		<script type="text/javascript" src="resources/js/question-add.js"></script>
		
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
	</body>
</html>