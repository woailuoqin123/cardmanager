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
<%@include file="../../resource.jsp"%>

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/js/pagination.js"></script>

</head>

<body>
	<section class="content-wrapper">
        <div class="content">
        	<div class="box box-info">
			<div class="box-header with-border">
				<div class="box-header with-border">
	            	<h5 class="box-title">商品信息</h5>
	            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
			</div>
		    <div class="box-body">
		    
					<form class="form-horizontal" role="form" id="goodsForm" >
				<div class="row form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">商品id</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" name="id" readonly  value="${goods.id}">
			                </div>
						</div>
						<label class="col-sm-1 control-label no-padding-right">商品编号</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" name="goodsId" readonly  value="${goods.goodsId}">
			                </div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">供应商</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" name="supplierName" readonly  value="${goods.supplierName}">
			                </div>
						</div>
						<label class="col-sm-1 control-label no-padding-right">国家</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" name="origin" readonly  value="${goods.origin}">
			                </div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">基础商品编码</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
			                  <input type="text" class="form-control"  name="baseId" readonly value="${goods.baseId}">
			                </div>
						</div>
						<label class="col-sm-1 control-label no-padding-right">商品名称</label>
						<div class="col-sm-4">
							<div class="input-group">
		                    	<div class="input-group-addon">
			                    	<i class="fa fa-pencil"></i>
			                	</div>
			                  	<input type="text" class="form-control" name="goodsName" name="area" value="${goods.goodsName}">
			                </div>
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-2 control-label no-padding-right">商品标签</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<div class="input-group"> -->
<!-- 			                  <select class="form-control" name="tagId" id="tagId" style="width: 170px;"> -->
<!-- 			                   	  <option selected="selected" value="">未选择</option> -->
<%-- 			                   	  <c:forEach var="tag" items="${tags}"> --%>
<%-- 			                   	  	<c:choose> --%>
<%-- 			                   	  		<c:when test="${goods.goodsTagBind.tagId==tag.id}"> --%>
<%-- 			                   	  			<option value="${tag.id}" selected="selected">${tag.tagName}</option> --%>
<%-- 							            </c:when> --%>
<%-- 							            <c:otherwise> --%>
<%-- 			                   	  			<option value="${tag.id}">${tag.tagName}</option> --%>
<%-- 							            </c:otherwise> --%>
<%-- 			                   	  	</c:choose> --%>
<%-- 			                   	  </c:forEach> --%>
<!-- 				                </select> -->
<!-- 			                </div> -->
<!-- 						</div> -->
<!-- 						<a class="col-sm-2 control-label no-padding-right" href="#" onclick="toTag()">+新增标签</a> -->
<!-- 						<div class="col-sm-2"> -->
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="col-md-12">
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="${goods.files[0].path}" id="img1" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath1" id="picPath1" value="${goods.files[0].path}"> 
								<input type="file" name="pic" id="pic1" />
								<button type="button" class="btn btn-info" onclick="uploadFile(1)">上传</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="${goods.files[1].path}" id="img2" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath2" id="picPath2" value="${goods.files[1].path}"> 
								<input type="file" name="pic" id="pic2" />
								<button type="button" class="btn btn-info" onclick="uploadFile(2)">上传</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="${goods.files[2].path}" id="img3" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath3" id="picPath3" value="${goods.files[2].path}"> 
								<input type="file" name="pic" id="pic3" />
								<button type="button" class="btn btn-info" onclick="uploadFile(3)">上传</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="${goods.files[3].path}" id="img4" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath4" id="picPath4" value="${goods.files[3].path}"> 
								<input type="file" name="pic" id="pic4" />
								<button type="button" class="btn btn-info" onclick="uploadFile(4)">上传</button>
							</div>
						</div>
					</div>
				</div>
			</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right"></label>
						<div class="col-sm-4">
						</div>
						<label class="col-sm-1 control-label no-padding-right"></label>
						<div class="col-sm-4">
							<div class="input-group">
			                  	<button type="button" class="btn btn-primary"  id="updateBtn">更新</button>
			                  	<button type="button" class="btn btn-danger" id="deleteBtn">删除</button>
			                </div>
						</div>
					</div>
				</div>
					</form>
			</div>
		</div>
			<div class="box box-warning">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">明细信息</h5>
		            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						</div>
		            </div>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<c:if test="${goods.templateId > 0}">
								<button type="button" class="btn btn-primary" onclick="addItem()">新增明细</button>
							</c:if>
						</div>
						<div class="col-md-12">
							<div class="panel panel-default">
								<table id="itemTable" class="table table-hover">
									<thead>
										<tr>
											<th>明细编号</th>
											<th>itemCode</th>
											<th>sku</th>
											<th>重量</th>
											<th>消费税</th>
											<th>状态</th>
											<th>规格</th>
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
		</div>
	</section>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">

	 function uploadFile(id) {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFile.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic"+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#picPath"+id).val(data.msg);
					$("#img"+id).attr("src",data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
	}
	 
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/goods/itemMng/dataListForGoods.shtml?goodsId="+"${goods.goodsId}",
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
	
	function addItem(){
		var index = layer.open({
			  title:"新增商品明细",		
			  type: 2,
			  content: '${wmsUrl}/admin/goods/itemMng/toAdd.shtml?templateId=${goods.templateId}&goodsId=${goods.goodsId}',
			  maxmin: true
			});
			layer.full(index);
	}
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#itemTable tbody").html("");

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
			str += "</td><td>" + list[i].itemId;
			str += "</td><td>" + list[i].itemCode;
			str += "</td><td>" + list[i].sku;
			str += "</td><td>" + list[i].weight;
			str += "</td><td>" + list[i].exciseTax;
			
			var status = list[i].status;
			
			switch(status){
				case '0':str += "</td><td>初始化";break;
				case '1':str += "</td><td>可用";break;
				case '2':str += "</td><td>可分销";break;
				default:str += "</td><td>状态错误："+status;
			}
			
			str += "</td><td>" + list[i].simpleInfo;
			str += "</td></tr>";
		}

		$("#itemTable tbody").html(str);
	}
	
	$("#updateBtn").click(function(){
		$.ajax({
			 url:"${wmsUrl}/admin/goods/goodsMng/edit.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#goodsForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("更新成功");
					 parent.layer.closeAll();
					 parent.location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("更新失败，请联系客服处理");
			 }
		 });
	 });
	
	$("#deleteBtn").click(function(){
		
		 if( confirm("确定要删除该商品记录吗？")) {
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/goodsMng/remove.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#goodsForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("删除成功");
						 parent.layer.closeAll();
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			 });
		 }
		
	 });

	
	function toTag(){
		var index = layer.open({
			  title:"新增标签",	
			  area: ['70%', '40%'],	
			  type: 2,
			  content: '${wmsUrl}/admin/goods/goodsMng/toTag.shtml',
			  maxmin: true
			});
	}
	</script>
</body>
</html>