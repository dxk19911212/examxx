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
		<title>试卷管理</title>
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
				<ul class="nav default-sidenav" style="border-right: 1px solid #666;">
					<li>
						<a href="admin/question"> <i class="fa fa-list-ul"></i> 试题管理 </a>
					</li>
					<li class="active">
						<a href="admin/paper"> <i class="fa fa-list-ul"></i> 试卷管理 </a>
					</li>
					<li>
						<a href="admin/upload-data"> <i class="fa fa-list-ul"></i> 资料上传 </a>
					</li>
				</ul>
			</div>
			<div class="col-xs-10">
<%--					<div class="page-header">--%>
<%--						<h1><i class="fa fa-list-ul"></i> 试卷管理 </h1>--%>
<%--					</div>--%>
					<div class="page-content row">

						<div id="question-filter">
<%--							<dl id="question-filter-pagetype">--%>
<%--								<dt>--%>
<%--									分类：--%>
<%--								</dt>--%>
<%--								<dd>--%>
<%--												<span data-id="0" <c:if test="${papertype == '0' }">--%>
<%--													class="label label-info"--%>
<%--												</c:if>>全部</span>--%>
<%--									<span data-id="1"--%>
<%--											<c:if test="${papertype == '1' }">--%>
<%--												class="label label-info"--%>
<%--											</c:if>--%>
<%--									>随机组卷</span>--%>
<%--									<span data-id="2" <c:if test="${papertype == '2' }">--%>
<%--										class="label label-info"--%>
<%--									</c:if>>模拟考试</span>--%>
<%--									<span data-id="3" <c:if test="${papertype == '3' }">--%>
<%--										class="label label-info"--%>
<%--									</c:if>>专家试卷</span>--%>
<%--								</dd>--%>
<%--							</dl>--%>
							<dl id="question-filter-status">
								<dt>
									试卷状态：
								</dt>
								<dd>
										<span data-id="0"
												<c:if test="${paperFilter.status == '0' }">
													class="label label-info"
												</c:if>>全部</span>
									<span data-id="1"
											<c:if test="${paperFilter.status == '1' }">
												class="label label-info"
											</c:if>>未上线</span>
									<span data-id="2"
											<c:if test="${paperFilter.status == '2' }">
												class="label label-info"
											</c:if>>已上线</span>
									<span data-id="3"
											<c:if test="${paperFilter.status == '3' }">
												class="label label-info"
											</c:if>>已下线</span>
								</dd>
							</dl>
							<dl id="question-filter-starttime">
								<dt>
									开放时间：
								</dt>
								<span>
									<span>
										<input id="question-filter-starttime-input" type="text" class="form-control" value="${paperFilter.starttime}">
										<input type="hidden" id="laydate2-hidden" value="">
									</span>
								</span>
							</dl>
							<dl id="question-filter-title" style="margin-left: 10px;">
								<span>试卷名称：</span>
								<span>
									<input id="question-filter-title-input" type="text" value="${paperFilter.name}"
										   class="form-control" style="background-color: #ffffff">
								</span>
							</dl>
							<span id="question-filter-department" style="margin-left: 10px;">
								<span>开放部门：</span>
								<span>
									<select></select>
									<input type="hidden" id="question-filter-department-input" value="${paperFilter.departments}">
								</span>
							</span>
							<span id="question-filter-category" style="margin-left: 50px;">
								<span>警种：</span>
								<span>
									<select></select>
									<input type="hidden" id="question-filter-category-input" value="${paperFilter.categories}">
								</span>
							</span>
							<span style="margin-left: 50px;">
								<a class="btn btn-primary" id="question-filter-search">查询</a>
								<a class="btn btn-primary" href="admin/exampaper-add" style="margin-left: 10px;">添加试卷</a>
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
									<td>试卷名称</td>
									<td>时长</td>
									<td>开放时间</td>
									<td>开放部门</td>
									<td>警种</td>
									<td>创建人</td>
									<td>状态</td>
									<td>操作</td>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${paperList }" var="item">
									<tr>
										<td>
											<input type="checkbox" value="${item.id }">
										</td>
										<td>${item.id }</td>
										<td><a href="admin/exampaper-preview/${item.id }" target="_blank" title="预览" class="td-paper-name">${item.name }</a></td>
										<td><span class="td-paper-duration">${item.duration}</span>分钟</td>
<%--										<td>--%>
<%--											<c:if test="${item.paper_type == '1' }">--%>
<%--																<span class="td-paper-type" data-id="${item.paper_type}">--%>
<%--																	随机组卷--%>
<%--																</span>--%>
<%--											</c:if>--%>
<%--											<c:if test="${item.paper_type == '2' }">--%>
<%--																<span class="td-paper-type" data-id="${item.paper_type}">--%>
<%--																模拟考试--%>
<%--																</span>--%>
<%--											</c:if>--%>
<%--											<c:if test="${item.paper_type == '3' }">--%>
<%--																<span class="td-paper-type" data-id="${item.paper_type}">--%>
<%--																专家试卷--%>
<%--																</span>--%>
<%--											</c:if>--%>
<%--										</td>--%>
										<td>
											<span class="td-paper-starttime">
												<fmt:formatDate value="${item.start_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
											</span>
										</td>
										<td><span class="td-paper-departments">${item.departments }</span></td>
										<td><span class="td-paper-categories">${item.categories }</span></td>
										<td>${item.creator }</td>
										<td>
											<c:choose>
												<c:when test="${item.status == 1 }">
													未上线
												</c:when>
												<c:when test="${item.status == 2 }">
													已上线
												</c:when>
												<c:when test="${item.status == 3 }">
													已下线
												</c:when>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${item.status == 1 }">
													<a href="admin/exampaper-edit/${item.id}">修改内容</a>
													<a class="change-property">修改属性</a>
													<a class="publish-paper">上线</a>
													<a class="delete-paper">删除</a>
												</c:when>
												<c:when test="${item.status == 2 }">
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
<%--												<div class="form-line exampaper-type" id="exampaper-type">--%>
<%--													<span class="form-label"><span class="warning-label">*</span>分类：</span>--%>
<%--													<select id="exampaper-type-select" class="df-input-narrow">--%>

<%--														<option value="1">随机组卷</option>--%>
<%--														<option value="2">模拟考试</option>--%>
<%--														<option value="3">专家试卷</option>--%>
<%--													</select><span class="form-message"></span>--%>
<%--												</div>--%>
												<div class="form-line add-update-starttime">
													<span class="form-label"><span class="warning-label">*</span>开放时间：</span>
													<input type="text" id="laydate1">
													<input type="hidden" id="laydate1-hidden" value="">
													<span class="form-message"></span>
												</div>
												<div class="form-line add-update-department">
													<span class="form-label"><span class="warning-label">*</span>开放部门：</span>
													<select class="js-example-basic-multiple" multiple="multiple">
<%--														<option value="1" selected>刑事部门</option>--%>
<%--														<option value="2">治安部门</option>--%>
<%--														<option value="3">交通管理部门</option>--%>
<%--														<option value="4">消防部门</option>--%>
<%--														<option value="5">出入境部门</option>--%>
<%--														<option value="6">人口管理部门</option>--%>
<%--														<option value="7">内安全保卫部门</option>--%>
													</select>
													<span class="form-message"></span>
												</div>
												<div class="form-line add-update-category">
													<span class="form-label"><span class="warning-label">*</span>警种：</span>
													<select class="js-example-basic-multiple" multiple="multiple">
<%--														<option value="1" selected>治安警察</option>--%>
<%--														<option value="2" selected>交通警察</option>--%>
<%--														<option value="3">外事警察</option>--%>
<%--														<option value="4">禁毒警察</option>--%>
<%--														<option value="5">监所警察</option>--%>
<%--														<option value="6">公安法医</option>--%>
													</select>
													<span class="form-message"></span>
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

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/js/exampaper-list.js"></script>
		<script type="text/javascript" src="resources/js/datetime/laydate.js"></script>
		<script type="text/javascript" src="resources/js/select/select2.min.js"></script>
		<link href="resources/js/select/select2.min.css" rel="stylesheet">
		<script>
			$(document).ready(function() {
				$('#question-filter-department select').select2({
				   placeholder: "请选择",
				   multiple: true,
					width:'200px',
				   data: [
					   {id: 1, text: '刑事部门'},
					   {id: 2, text: '治安部门'},
					   {id: 3, text: '交通管理部门'},
					   {id: 4, text: '消防部门'},
					   {id: 5, text: '出入境部门'},
					   {id: 6, text: '人口管理部门'},
					   {id: 7, text: '内安全保卫部门'}]
			   });

				$('#question-filter-category select').select2({
					 placeholder: "请选择",
					 multiple: true,
					width:'200px',
					 data: [
						 {id: 1, text: '治安警察'},
						 {id: 2, text: '交通警察'},
						 {id: 3, text: '外事警察'},
						 {id: 4, text: '禁毒警察'},
						 {id: 5, text: '监所警察'},
						 {id: 6, text: '公安法医'}]
				 });

				// 刷新保留多选框赋值
				var paper_departments = $('#question-filter-department-input').val();
				var paper_categories = $('#question-filter-category-input').val();
				$("#question-filter-department select").val(paper_departments.split(',')).trigger('change');
				$("#question-filter-category select").val(paper_categories.split(',')).trigger('change');
			});

			laydate.render({
				elem: '#laydate1',
				type: 'datetime',
			    done: function(value){
				   $('#laydate1-hidden').val(value);
			    }
		    });

			laydate.render({
			   elem: '#question-filter-starttime-input',
			   type: 'datetime',
			   done: function(value){
			   	console.log(value.replace(/-/g,'/'))
				   $('#laydate2-hidden').val(value);
			   }
		    });
		</script>
	</body>
</html>
