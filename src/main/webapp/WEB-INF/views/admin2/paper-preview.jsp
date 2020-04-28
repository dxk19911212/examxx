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
		<title>试卷管理-试卷预览</title>
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
		
		<link href="resources/css/exam.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
		<style>
			#add-more-qt-to-paper i{
				color: #47a447;
				cursor: pointer;
				margin-right:5px;	
			}
			#qt-selector-iframe{
				border:none;
				height:600px;
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
					<li>
						<a href="admin/question"> <i class="fa fa-list-ul"></i> 试题管理 </a>
					</li>
					<li class="active">
						<a href="admin/paper"> <i class="fa fa-list-ul"></i> 试卷管理 </a>
					</li>
					<li>
						<a href="admin/media"> <i class="fa fa-list-ul"></i> 资料上传 </a>
					</li>
					<li>
						<a href="admin/user-list"> <i class="fa fa-list-ul"></i> 会员管理 </a>
					</li>
				</ul>
			</div>
			<div class="col-xs-10">
					<div>
						<h1> 预览试卷 </h1>
					</div>
					<div class="page-content row">
						<div class="def-bk" id="bk-exampaper">

							<div class="expand-bk-content" id="bk-conent-exampaper">
								<div id="exampaper-header">
									<div id="exampaper-title">
										<i class="fa fa-send"></i>
										<span id="exampaper-title-name">${exampapername} </span>
										<span style="display:none;" id="exampaper-id">${exampaperid}</span>

									</div>
									<div id="exampaper-desc-container">
										<div id="exampaper-desc" class="exampaper-filter">


										</div>
										<div style="margin-top: 5px;">
											<span>试卷总分：</span><span id="exampaper-total-point" style="margin-right:20px;"></span>
											<!-- <span id="add-more-qt-to-paper"><i class="small-icon fa fa-plus-square" title="添加选项"></i><span>增加更多题目</span></span> -->
										</div>
									</div>


								</div>
								<ul id="exampaper-body" style="padding:0px;">
									${htmlStr }
								</ul>
								<div id="exampaper-footer">
									<div id="question-navi">
									<div id="question-navi-controller">
										<i class="fa fa-arrow-circle-down"></i>
										<span>答题卡</span>
									</div>
									<div id="question-navi-content">
									</div>
									</div>
									<div style="padding-left:30px;">
										<!-- <button class="btn btn-danger"><i class="fa fa-save"></i>保存试卷</button> -->
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>
		</div>
		<div class="modal fade" id="question-selector-modal">
					  <div class="modal-dialog modal-lg">
						<div class="modal-content">
						  <div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title">选择试题添加到试卷中</h4>
						  </div>
						  <div class="modal-body">
							<iframe  id="qt-selector-iframe" src="admin/questionfilterdialog-0-0-0-0-1.html" width="100%"></iframe>
						  </div>
						  <div class="modal-footer">
								<button id="add-list-to-exampaper" type="button" class="btn btn-primary">添加选中</button>
							  </div>

						</div><!-- /.modal-content -->
					  </div><!-- /.modal-dialog -->
		</div>
		<div class="modal fade" id="question-point-modal">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						        <h4 class="modal-title">修改分数</h4>
						      </div>
						      <div class="modal-body">
						        	<form>
										<div class="form-line qt-point-destination">
											<span class="form-label">分数：</span>
											<label></label>
											<input type="text" value=""/>
										</div>
										<div class="form-line">
											<button class="btn btn-sm btn-success" id="update-point-btn"><i class="fa fa-check"></i>仅修改第<span id="qt-point-target-index"></span>题</button>
											<button class="btn btn-sm btn-warning" id="update-point-type-btn"><i class="fa fa-random"></i>批量更新该题型</button>
										</div>
									</form> 

						      </div>
						      
						    </div><!-- /.modal-content -->
						  </div><!-- /.modal-dialog -->
			</div>

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		<script type="text/javascript" src="resources/js/exampaper-preview.js"></script>
	</body>
</html>