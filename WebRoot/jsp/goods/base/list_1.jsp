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

</head>
<body>
<section class="content-wrapper">
	<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>基础信息管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li>商品管理</li>
	        <li class="active">基础信息管理</li>
	      </ol>
    </section>	
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5)">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="box box-info">
			<div class="box-header with-border">
				<div class="box-header with-border">
	            	<h5 class="box-title">搜索</h5>
	            	<div class="box-tools pull-right">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
			</div>
		    <div class="box-body">
			<div class="row form-horizontal query">
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">品牌</label>
						<div class="col-sm-8">
							<div class="input-group">
			                  <select class="form-control" name="brandId" id="brandId" style="width: 100%;">
		                   	  <option selected="selected" value="">未选择</option>
		                   	  <c:forEach var="brand" items="${brands}">
		                   	  	<option value="${brand.brandId}">${brand.brand}</option>
		                   	  </c:forEach>
			                </select>
			                </div>
						</div>
					</div>
				</div>
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">基础编码</label>
						<div class="col-sm-8">
							<div class="input-group">
	                  			<input type="text" class="form-control" name="id">
			                </div>
						</div>
					</div>
				</div>
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">名称</label>
						<div class="col-sm-8">
							<div class="input-group">
			                  <input type="text" class="form-control" name="goodsName">
			                </div>
						</div>
					</div>
				</div>
				<div class="col-md-offset-10 col-md-12">
					<div class="form-group">
                         <button type="button" class="btn btn-primary" id="querybtns" name="signup">提交</button>
                    </div>
                </div>
			</div>
		</div>
	</div>
	
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
								<button type="button" onclick="toAdd()" class="btn btn-primary">新增基础商品</button>
								</h3>
							</div>
							<table id="baseTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>品牌名称</th>
										<th>商品名称</th>
										<th>增值税</th>
										<th>关税</th>
										<!-- <th>单位</th>
										<th>hscode</th> -->
										<th>条码</th>
										<th>分类</th>
										<th>所属机构</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div class="pagination-nav">
								<ul id="pagination" class="pagination">
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</section>
</section>
	
	<%@include file="../../resource.jsp"%>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/baseMng/dataList.shtml",
			numPerPage:"20",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		//if ("${privilege>=2}") {
		if (true) {
			str += "<td align='left'>";
			str += "<a href='#' onclick='toEdit("+list[i].id+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
			str += "</td>";
		}
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].incrementTax;
		str += "</td><td>" + list[i].tariff;
		//str += "</td><td>" + list[i].unit;
		//str += "</td><td>" + (list[i].hscode == null ? "" : list[i].hscode);
		str += "</td><td>" + list[i].encode;
		str += "</td><td>" + list[i].firstCatalogId+"-"+list[i].secondCatalogId+"-"+list[i].thirdCatalogId;
		str += "</td><td>" + list[i].centerId;
		str += "</td><td>" + list[i].createTime;
		
		str += "</td></tr>";
	}
		

	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toEdit.shtml?baseId='+id,
		  maxmin: true
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增基础商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toAdd.shtml',
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
