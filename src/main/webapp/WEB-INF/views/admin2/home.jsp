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
		<title>在线考试系统-管理员</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
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
<%--			<div class="container">--%>
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<ul class="nav navbar-nav">
						<li class="active">
							<a href="home">教学资料</a>
						</li>
						<li>
							<a href="admin/question">综合管理</a>
						</li>
					</ul>
				</nav>
<%--			</div>--%>
		</div>
		<!-- Navigation bar ends -->

		<div class="content" style="margin-bottom: 100px;">
			<div class="container">
				<div class="col-md-12">
				<form class="navbar-form" role="search">
					<div class="form-group">
						检索内容：
						<input id="search-input" type="text" class="form-control" placeholder="" value="${mediaFilter.title}">
						<button id="search-btn" type="submit" class="btn btn-default" style="margin-left: 20px">查询</button>
					</div>
				</form>

				<div class="divider">
					<div class="text">
						<p style="font-size: 20px">视频资料</p>
						<p style="cursor:pointer;">更多</p>
					</div>
					<hr class="simple" style="color: #6f5499" />
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${mediaList }" var="item">
								<c:choose>
									<c:when test="${item.type == 1 }">
										<div class="swiper-slide" style="background-color: #24292D">
											<img style="width: 220px;height: 220px;" alt="" src="${item.url }" onclick="javascript:location.href='${item.url }'">
										</div>
									</c:when>
									<c:when test="${item.type == 3 }">
										<div class="swiper-slide" style="background-color: #24292D">
											<video style="width: 220px;height: 220px;" src="${item.url }" alt=""  onclick="javascript:location.href='${item.url }'"/>
										</div>
									</c:when>
								</c:choose>
							</c:forEach>
						</div>
<%--						<div class="swiper-pagination"></div>--%>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
					</div>
				</div>

				<div class="divider" style="margin-top:100px">
					<div class="text">
						<p style="font-size: 20px">文档资料</p>
						<p style="cursor:pointer;">更多</p>
					</div>
					<hr class="simple" style="color: #6f5499" />
					<div class="container">
						<ul>
						<c:forEach items="${mediaList2 }" var="item">
							<c:choose>
								<c:when test="${item.type == 2 }">
									<li>
									<a target="_blank" href="${item.url }">${item.title }</a>
									</li>
								</c:when>
							</c:choose>
						</c:forEach>
						</ul>
					</div>
				</div>
				</div>
			</div>
		</div>

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>

		<link rel="stylesheet" type="text/css" href="resources/js/swiper/swiper.min.css">
		<script type="text/javascript" src="resources/js/swiper/swiper.min.js"></script>

		<script>
			$(function(){
				var result = checkBrowser();
				if (!result){
					alert("请至少更新浏览器版本至IE8或以上版本");
				}
			});

			function checkBrowser() {
				var browser = navigator.appName;
				var b_version = navigator.appVersion;
				var version = b_version.split(";");
				var trim_Version = version[1].replace(/[ ]/g, "");
				if (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE7.0") {
					return false;
				} else if (browser == "Microsoft Internet Explorer"
						&& trim_Version == "MSIE6.0") {
					return false;
				} else
					return true;
			}

			var swiper = new Swiper('.swiper-container', {
				slidesPerView: 4,
				spaceBetween: 30,
				centeredSlides: true,
				loop: true,
				pagination: {
					el: '.swiper-pagination',
					clickable: true,
				},
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				autoplay: {
					delay: 2000,
					disableOnInteraction: false,
				}
			});

			$("#search-btn").click(function () {
				var title = $("#search-input").text();
				document.location.href =
						document.getElementsByTagName('base')[0].href + 'admin/homemedia-2.html';
			});
		</script>
	</body>
</html>
