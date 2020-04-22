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

		<link href="resources/css/exam.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
		<style>
			.change-property, .publish-paper, .delete-paper, .offline-paper{
				cursor:pointer;
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
				<ul class="nav default-sidenav">
					<li>
						<a href="admin/question"> <i class="fa fa-list-ul"></i> 试题管理 </a>
					</li>
					<li class="active">
						<a href="admin/paper"> <i class="fa fa-list-ul"></i> 试卷管理 </a>
					</li>
					<li>
						<a href="#"> <i class="fa fa-list-ul"></i> 资料上传 </a>
					</li>
				</ul>
			</div>
			<div class="col-xs-10">
<%--					<div class="page-header">--%>
<%--						<h1><i class="fa fa-list-ul"></i> 试卷管理 </h1>--%>
<%--					</div>--%>
					<div class="page-content row">

						<div id="question-filter">
							<dl id="question-filter-pagetype">
								<dt>
									分类：
								</dt>
								<dd>
												<span data-id="0" <c:if test="${papertype == '0' }">
													class="label label-info"
												</c:if>>全部</span>
									<span data-id="1"
											<c:if test="${papertype == '1' }">
												class="label label-info"
											</c:if>
									>随机组卷</span>
									<span data-id="2" <c:if test="${papertype == '2' }">
										class="label label-info"
									</c:if>>模拟考试</span>
									<span data-id="3" <c:if test="${papertype == '3' }">
										class="label label-info"
									</c:if>>专家试卷</span>
								</dd>
							</dl>


<%--							<div class="page-link-content">--%>
<%--								<ul class="pagination pagination-sm">${pageStr}</ul>--%>
<%--							</div>--%>
						</div>
						<div class="col-md-10">
							<a class="btn btn-primary" href="admin/exampaper-add">添加试卷</a>
						</div>
						<div id="question-list">
							<table class="table-striped table">
								<thead>
								<tr>
									<td></td><td>ID</td><td>试卷名称</td><td>时长</td><td>类别</td><td>创建人</td><td>状态</td><td>操作</td>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${paper }" var="item">
									<tr>
										<td>
											<input type="checkbox" value="${item.id }">
										</td>
										<td>${item.id }</td>
										<td><a href="admin/exampaper-preview/${item.id }" target="_blank" title="预览" class="td-paper-name">${item.name }</a></td>
										<td><span class="td-paper-duration">${item.duration}</span>分钟</td>
										<td>
											<c:if test="${item.paper_type == '1' }">
																<span class="td-paper-type" data-id="${item.paper_type}">
																	随机组卷
																</span>
											</c:if>
											<c:if test="${item.paper_type == '2' }">
																<span class="td-paper-type" data-id="${item.paper_type}">
																模拟考试
																</span>
											</c:if>
											<c:if test="${item.paper_type == '3' }">
																<span class="td-paper-type" data-id="${item.paper_type}">
																专家试卷
																</span>
											</c:if>
										</td>
										<td>${item.creator }</td>
										<td>
											<c:choose>
												<c:when test="${item.status == 0 }">
													未上线
												</c:when>
												<c:when test="${item.status == 1 }">
													已上线
												</c:when>
												<c:when test="${item.status == 2 }">
													已下线
												</c:when>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${item.status == 0 }">
													<a href="admin/exampaper-edit/${item.id}">修改内容</a>
													<a class="change-property">修改属性</a>
													<a class="publish-paper">上线</a>
													<a class="delete-paper">删除</a>
												</c:when>
												<c:when test="${item.status == 1 }">
													<a class="offline-paper">下线</a>
												</c:when>
											</c:choose>

										</td>
									</tr>
								</c:forEach>

								</tbody><tfoot></tfoot>
							</table>
							<!-- 修改属性modal -->
							<div class="modal fade" id="change-property-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h6 class="modal-title" id="myModalLabel">修改试卷属性</h6>
										</div>
										<div class="modal-body">
											<form id="question-add-form">
												<span id="add-update-exampaperid" style="display:none;"></span>
												<div class="form-line add-update-exampapername">
													<span class="form-label"><span class="warning-label">*</span>试卷名称：</span>
													<input type="text" class="df-input-narrow">
													<span class="form-message"></span>
												</div>
												<div class="form-line add-update-duration">
													<span class="form-label"><span class="warning-label">*</span>时长(分钟)：</span>
													<input type="text" class="df-input-narrow">
													<span class="form-message"></span>
												</div>
												<div class="form-line exampaper-type" id="exampaper-type">
													<span class="form-label"><span class="warning-label">*</span>分类：</span>
													<select id="exampaper-type-select" class="df-input-narrow">

														<option value="1">随机组卷</option>
														<option value="2">模拟考试</option>
														<option value="3">专家试卷</option>
													</select><span class="form-message"></span>
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
		<script type="text/javascript" src="resources/js/all.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/exampaper-list.js"></script>
	</body>
</html>
