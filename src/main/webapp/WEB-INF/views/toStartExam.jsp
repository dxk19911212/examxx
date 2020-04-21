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
		<meta charset="utf-8" />
		<base href="<%=basePath%>">

		<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Exam++</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/exam.css" rel="stylesheet" type="text/css">
		<link href="resources/css/style.css" rel="stylesheet">
		
		<style type="text/css">
			.question-body {
				padding: 30px 30px 20px 30px;
				background: #FFF;
			}
			
			ul#exampaper-body{
				margin-bottom: 0px;
			}
			
			ul#exampaper-body li{
				padding-bottom:0px;
			}
			.question-body{
				min-height:300px;
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

								<a href="user-detail/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}" id="system-info-account">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
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

		<div class="content" style="margin-bottom: 100px;">

			<div class="container">
				<div class="row">
					<div class="col-xs-12" style="padding-right: 0px;padding-bottom:15px;">
						<div class="modal practice-exampaper-modal" tabindex="-1" role="dialog"
							 style="display: block; position: relative; outline:0 none;" aria-labelledby="myLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
<%--										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
										<h6 class="modal-title" id="myModalLabel">选择试卷，参加考试</h6>
									</div>
									<div class="modal-body">
										<ul>
											<c:forEach items="${practicepaper}" var="item">
												<li>
													<a href="student/examing/${item.id}">${item.name}</a>
												</li>
											</c:forEach>
										</ul>
									</div>
<%--									<div class="modal-footer">--%>
<%--										<button type="button" class="btn btn-default" data-dismiss="modal">取消考试</button>--%>
<%--									</div>--%>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

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
		<script type="text/javascript" src="resources/js/all.js?v=0712"></script>
<%--		<script type="text/javascript" src="resources/js/comment.js"></script>--%>

	</body>
</html>
