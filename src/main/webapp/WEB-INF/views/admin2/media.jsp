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
		<link href="resources/css/exam.css" rel="stylesheet">
		<style>
			#question-list img {
				width: 100px;
				height: 100px;
			}

			#question-list video {
				width: 100px;
				height: 100px;
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
					<li class="active">
						<a href="admin/media"> <i class="fa fa-list-ul"></i> 资料上传 </a>
					</li>
					<li>
						<a href="admin/user-list"> <i class="fa fa-list-ul"></i> 会员管理 </a>
					</li>
				</ul>
			</div>
			<div class="col-xs-10">
				<div class="page-content row">
					<div id="question-filter">
						<dl id="question-filter-type">
							<dt>
								资料类型：
							</dt>
							<dd>
								<span data-id="0"
										<c:if test="${mediaFilter.type == '0' }">
											class="label label-info"
										</c:if>>全部</span>
								<span data-id="1"
										<c:if test="${mediaFilter.type == '1' }">
											class="label label-info"
										</c:if>>图片</span>
								<span data-id="2"
										<c:if test="${mediaFilter.type == '2' }">
											class="label label-info"
										</c:if>>文档</span>
								<span data-id="3"
										<c:if test="${mediaFilter.type == '3' }">
											class="label label-info"
										</c:if>>视频</span>
							</dd>
						</dl>
						<dl id="question-filter-title" style="margin-left: 10px;">
							<span>资料标题：</span>
							<span>
								<input id="question-filter-title-input" type="text" value="${mediaFilter.title}"
									   class="form-control" style="background-color: #ffffff">
							</span>
						</dl>
						<span style="margin-left: 50px;">
							<a class="btn btn-primary" id="question-filter-search">查询</a>
							<a class="btn btn-primary" data-toggle="modal" data-target=".media-upload-modal" style="margin-left: 10px;">上传资料</a>
						</span>
					</div>
					<div class="page-link-content">
						<ul class="pagination pagination-sm">${pageStr}</ul>
					</div>
					<div id="question-list">
						<table class="table-striped table">
							<thead>
							<tr>
								<td></td>
								<td>ID</td>
								<td>缩略图</td>
								<td>资料标题</td>
								<td>资料类型</td>
								<td>描述</td>
								<td>上传人</td>
								<td>上传时间</td>
								<td>操作</td>
							</tr>
							</thead>
							<tbody>
								<c:forEach items="${mediaList }" var="item">
								<tr>
									<td>
										<input type="checkbox" value="${item.id }">
									</td>
									<td>${item.id }</td>
									<td style="width:200px;word-break:break-all">
										<c:choose>
											<c:when test="${item.type == 1 }">
												<img src="${item.url }" alt=""/>
											</c:when>
											<c:when test="${item.type == 2 }">
												<a target="_blank" href="${item.url }">${item.url }</a>
											</c:when>
											<c:when test="${item.type == 3 }">
												<video src="${item.url }" alt=""/>
											</c:when>
										</c:choose>
									</td>
									<td><span class="td-paper-title">${item.title}</span></td>
									<td>
										<c:choose>
											<c:when test="${item.type == 1 }">
												图片
											</c:when>
											<c:when test="${item.type == 2 }">
												文件
											</c:when>
											<c:when test="${item.type == 3 }">
												视频
											</c:when>
										</c:choose>
									</td>
									<td><span class="td-paper-title">${item.desc}</span></td>
									<td>${item.creator }</td>
									<td>
										<span class="td-paper-starttime">
											<fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd"/>
										</span>
									</td>
									<td>
<%--										<a class="change-property">修改</a>--%>
										<a class="delete-media">删除</a>
									</td>
								</tr>
							</c:forEach>
							</tbody>
							<tfoot></tfoot>
						</table>
					</div>
					<div class="page-link-content">
						<ul class="pagination pagination-sm">${pageStr}</ul>
					</div>
					<!-- 上传资料modal -->
					<div class="modal fade media-upload-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h6 class="modal-title" id="myModalLabel">上传资料</h6>
								</div>
								<div class="modal-body">
									<form id="media-add-form">
										<span id="add-update-exampaperid" style="display:none;"></span>
										<div class="form-line add-update-mediatitle">
											<span class="form-label"><span class="warning-label">*</span>资料标题：</span>
											<input type="text" class="df-input-narrow">
											<span class="form-message"></span>
										</div>
										<div class="form-line add-update-mediaurl">
											<span class="form-label"><span class="warning-label">*</span>请选择文件：</span>
											<input type="file" name="file" id="upload-img">
											<div>
												<img id="img_preview" src="" style="width: 100px;">
											</div>
											<span class="form-message"></span>
										</div>
										<div class="form-line add-update-mediadesc">
											<span class="form-label">描述：</span>
											<label>
												<textarea class="df-input-narrow" style="width: 350px; height: 150px"></textarea>
											</label>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button id="btn_upload" type="button" class="btn btn-primary">上传</button>
								</div>
							</div>
						</div>
					</div>
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
		<!-- qiniu -->
		<script type="text/javascript" src="resources/js/qiniu/qiniu.min.js"></script>
		<script type="text/javascript" src="resources/js/media.js"></script>
	<script>
		$(function(){
			$("#upload-img").change(function (e) {
				// 获取目标文件
				var file = e.target.files || e.dataTransfer.files;
				if (file) {
					var reader = new FileReader();
					// 文件装载后将其显示在图片预览里
					reader.onload = function () {
						$("#img_preview").attr("src", this.result);
					};
					// 装载文件
					reader.readAsDataURL(file[0]);
				}
			});
		})
	</script>
	</body>
</html>
