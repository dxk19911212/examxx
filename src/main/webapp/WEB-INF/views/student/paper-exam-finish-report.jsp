<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
		<title>Exam++</title>
		
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
		
		<link href="resources/css/exam.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
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

							<a href="user-detail/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}" id="system-info-account">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
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
						<li>
							<a href="to-practice-exam">模拟考试</a>
						</li>
						<li class="active">
							<a href="to-start-exam">正式考试</a>
						</li>
						<li>
							<a href="to-manage">综合管理</a>
						</li>
					</ul>
				</nav>
<%--			</div>--%>
		</div>

		<!-- Navigation bar ends -->

		<!-- Slider starts -->

		<div>
			<!-- Slider (Flex Slider) -->

<%--			<div class="container" style="min-height:500px;">--%>

<%--				<div class="row">--%>
					<div class="col-xs-2" style="padding-left:0">
						<ul class="nav default-sidenav">
							<li>
								<a href="student/finish-exam/${examPaperId }"> <i class="fa fa-bar-chart-o"></i> 成绩报告 </a>

							</li>
							<li class="active">
								<a href="student/exam-report/${examPaperId }"> <i class="fa fa-file-text"></i> 详细解答 </a>
							</li>
						</ul>

					</div>
					<div class="col-xs-10">
<%--						<div class="page-header">--%>
<%--							<h1 style="margin-left: -15px;"><i class="fa fa-file-text"></i> 详细解答 </h1>--%>
<%--						</div>--%>
						<div class="page-content row">
							<div class="def-bk" id="bk-exampaper">

								<div class="expand-bk-content" id="bk-conent-exampaper">
									<div id="exampaper-header">
										<div id="exampaper-title">
											<i class="fa fa-send"></i>
											<span id="exampaper-title-name"> 试卷解答 </span>

										</div>
										<div id="exampaper-desc" class="exampaper-filter">
											<!-- <input type="checkbox">
											<span>只显示错题</span> -->

										</div>
									</div>
									<ul id="exampaper-body" style="padding:0px;">
										<c:forEach items="${htmlStr }" var="str">
											${str }
										</c:forEach>										
									</ul>
									<div id="exampaper-footer" style="height: 187px;">

									</div>
								</div>

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
		<script>
			$(function(){
				var questions = $("li.question");

				questions.each(function(index) {
					$(this).find(".question-no").text(index + 1 + ".");
				});
			});
		</script>
	</body>
</html>
