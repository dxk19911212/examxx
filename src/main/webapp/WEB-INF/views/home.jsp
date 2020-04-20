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
					<div id="login-info" class="col-xs-11">
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
						<li class="active">
							<a href="home">教学资料</a>
						</li>
						<li>
							<a href="to-practice-exam">模拟考试</a>
						</li>
						<li>
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
				<form class="navbar-form" role="search">
					<div class="form-group">
						检索内容：
						<input type="text" class="form-control" placeholder="">
						<button type="submit" class="btn btn-default">查询</button>
					</div>
				</form>

				<div class="divider">
					<div class="text">
						<p style="font-size: 20px">视频资料</p>
						<p>更多</p>
					</div>

					<hr class="simple" style="color: #6f5499" />
					<div class="pic" style="justify-content: space-around; margin-left:20px">
						<img alt="" src="resources/images/bitmap.png">
						<img alt="" src="resources/images/bitmap.png">
						<img alt="" src="resources/images/bitmap.png">
						<img alt="" src="resources/images/bitmap.png">
						<img alt="" src="resources/images/bitmap.png">
					</div>
				</div>

				<div class="divider" style="margin-top:100px">
					<div class="text">
						<p style="font-size: 20px">文档资料</p>
						<p>更多</p>
					</div>
					<hr class="simple" style="color: #6f5499" />
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
		<script type="text/javascript"
		src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript"
		src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script>
		$(function(){
			bindQuestionKnowledage();
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
		
		function bindQuestionKnowledage(){
			$(".knowledge-title").click(function(){
				var ul = $(this).parent().find(".question-list-knowledge");
				
				if(ul.is(":visible")){
					$(this).find(".fa-chevron-down").hide();
					$(this).find(".fa-chevron-up").show();
					
					$(".question-list-knowledge").slideUp();
					
				}else{
					$(".fa-chevron-down").hide();
					$(".fa-chevron-up").show();
					
					$(this).find(".fa-chevron-up").hide();
					$(this).find(".fa-chevron-down").show();
					
					$(".question-list-knowledge").slideUp();
					ul.slideDown();
					
				}
				
				
			});
		}
		</script>
<%--		<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1252987997'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/z_stat.php%3Fid%3D1252987997' type='text/javascript'%3E%3C/script%3E"));</script>--%>
	</body>
</html>
