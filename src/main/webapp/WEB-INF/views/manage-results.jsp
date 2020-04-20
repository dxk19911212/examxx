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
		<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Exam++</title>
		<meta name="viewport"
		content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css"
		rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css"
		rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">

		<style>
			.question-number{
				color: #5cb85c;
				font-weight: bolder;
				display: inline-block;
				width: 30px;
				text-align: center;
			}

			.question-number-2{
				color: #5bc0de;
				font-weight: bolder;
				display: inline-block;
				width: 30px;
				text-align: center;
			}
			.question-number-3{
				color: #d9534f;
				font-weight: bolder;
				display: inline-block;
				width: 30px;
				text-align: center;
			}

			a.join-practice-btn{
				margin:0;
				margin-left:20px;
			}

			.content ul.question-list-knowledge{
				padding:8px 20px;
			}

			.knowledge-title{
				background-color:#EEE;
				padding:2px 10px;
				margin-bottom:20px;
				cursor:pointer;
				border:1px solid #FFF;
				border-radius:4px;
			}

			.knowledge-title-name{
				margin-left:8px;
			}

			.point-name{
				width:200px;
				display:inline-block;
			}
		</style>

	</head>

	<body>
		<header>
<%--			<div class="container">--%>
				<div class="row" style="background-image: url(resources/images/bpic.png)">
					<div class="col-xs-1">
						<div class="logo">
							<h1><a href="#"><img alt="" src="resources/images/blogo.png"></a></h1>
						</div>
					</div>
					<div class="col-xs-11" id="login-info">
						<c:choose>
							<c:when test="${not empty sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
								<div id="login-info-user">

									<a href="user-detail/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}" id="system-info-account" target="_blank">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
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
						<li>
							<a href="to-start-exam">正式考试</a>
						</li>
						<li class="active">
							<a href="to-manage">综合管理</a>
						</li>
					</ul>
				</nav>
<%--			</div>--%>
		</div>
		<!-- Navigation bar ends -->

		<div style="margin-bottom: 100px;">
<%--			<div class="container">--%>
			<div class="row">
				<div class="col-xs-2">
					<ul class="nav default-sidenav">
						<li class="active">
							<a href="to-manage-results"> <i class="fa fa-list-ul"></i> 成绩查询 </a>
						</li>
						<li>
							<a href="to-manage"> <i class="fa fa-list-ul"></i> 试题管理 </a>
						</li>
						<li>
							<a href="to-manage-papers"> <i class="fa fa-list-ul"></i> 试卷管理 </a>
						</li>
					</ul>

				</div>
				<div class="col-xs-10">
<%--					<div class="page-header">--%>
<%--						<h1><i class="fa fa-list-ul"></i> 试卷管理 </h1>--%>
<%--					</div>--%>
					<div class="page-content row">
						<div id="question-list">
							<table class="table-striped table">
								<thead>
								<tr>
									<td>试卷名称</td><td>参加时间</td><td>得分</td><td>操作</td>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${hisList }" var="item">
									<tr>

										<td>
											<c:if test="${item.examPaperId == -1 }">
											<a href="student/exam-report" target="_blank" title="预览">${item.paperName }</a></td>
										</c:if>
										<c:if test="${item.examPaperId != -1 }">
											<a href="student/exam-report/${item.examPaperId }" target="_blank" title="预览">${item.paperName }</a></td>
										</c:if>
										<td>
											<fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd"/>
										</td>
										<td>
												${item.pointGet }
										</td>
										<td>

											<c:if test="${item.examPaperId == -1 }">
											<a href="student/finish-exam" target="_blank" title="预览">查看报告</a></td>
										</c:if>
										<c:if test="${item.examPaperId != -1 }">
											<a href="student/finish-exam/${item.examPaperId }" target="_blank" title="预览">查看报告</a></td>
										</c:if>
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
			</div>
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
		<script type="text/javascript" src="resources/js/all.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/exampaper-list.js"></script>
	</body>
</html>
