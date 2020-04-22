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
		<title>综合管理-成绩查询</title>
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
<%--			<div class="container">--%>
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
<%--			</div>--%>
		</div>
		<!-- Navigation bar ends -->

		<div style="margin-bottom: 100px;">
			<div class="col-xs-2" style="padding-left:0">
					<ul class="nav default-sidenav" style="border-right: 1px solid #666;">
						<li class="active">
							<a href="student/result"> <i class="fa fa-list-ul"></i> 成绩查询 </a>
						</li>
						<li>
							<a href="student/info/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
								<i class="fa fa-list-ul"></i> 个人中心 </a>
						</li>
					</ul>

				</div>
			<div class="col-xs-10">
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

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/exampaper-list.js"></script>
	</body>
</html>
