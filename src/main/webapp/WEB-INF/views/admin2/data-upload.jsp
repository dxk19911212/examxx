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
		<title>资料上传</title>
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
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
					<li class="active">
						<a href="admin/upload-data"> <i class="fa fa-list-ul"></i> 资料上传 </a>
					</li>
				</ul>
			</div>
			<div class="col-xs-9">
<%--					<div class="page-header">--%>
<%--						<h1><i class="fa fa-list-ul"></i> 试卷管理 </h1>--%>
<%--					</div>--%>
					<div class="page-content row">
						<form id="dropzone" action="upload-img" class="dropzone">
							<div class="dz-default dz-message">
								<span>将文件拖至此处或点击选择</span>
							</div>
							<input type="hidden" name="file_id"/>
						</form>
					</div>
				</div>
		</div>

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="resources/js/upload/dropzone.min.css">
		<script type="text/javascript" src="resources/js/upload/dropzone.min.js"></script>
		<script type="text/javascript">
			Dropzone.options.dropzone = {
				maxFiles: 5,
				maxFilesize: 200,
				acceptedFiles: ".jpg,.gif,.png,.jpeg,.mp4",
				addRemoveLinks: true,
				dictRemoveFile: "删除",
				dictMaxFilesExceeded: "最多只能上传5个文件！",
				dictResponseError: '文件上传失败！',
				dictInvalidFileType: "你不能上传该类型文件,文件类型只能是jpg、gif、png、mp4格式",
				dictFallbackMessage:"浏览器不受支持！",
				dictFileTooBig:"文件过大，超过上传文件最大支持！",
				success: function(file) {
					// $("#dropzone").find("input").val(file.xhr.response);
					// $("#dropzone-img-id").attr("src", file.xhr.response);
					confirm("上传成功！")
				}
			}
		</script>
	</body>
</html>
