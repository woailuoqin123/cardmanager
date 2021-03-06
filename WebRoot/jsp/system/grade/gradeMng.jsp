<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>分级管理</title>
<%@include file="../../resource.jsp"%>
</head>
<body>
	<section class="content-wrapper">
		<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>分级管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li class="active">分级管理</li>
	      </ol>
	    </section>
		<section class="content">
	        <div class="box box-primary">
				<div class="box-header">
				<ul id="navTab" class="nav nav-tabs">
					<li class="active"><a href="${wmsUrl}/admin/system/gradeMng/list.shtml">分级列表</a></li>
					<li><a href="${wmsUrl}/admin/system/gradeMng/add.shtml">新增分级</a></li>
				</ul>
				</div>
				<div class="box-body">
					<div id="page-wrapper">
					</div>
				</div>
			</div>
		</section>
	</section>
	<script type="text/javascript" src="${wmsUrl}/js/navPage.js"></script>
	<script type="text/javascript">
		$(function(){
			var width = "100%";
			var height = window.innerHeight-139;
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/system/gradeMng/list.shtml";
			newIframeObject.scrolling = "yes";
			newIframeObject.frameBorder = 0;
			newIframeObject.width = width;
			newIframeObject.height = height;
			$("#page-wrapper").append(newIframeObject);
		})
	</script>
</body>
</html>
