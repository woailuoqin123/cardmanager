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
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>

</head>

<body >
<section class="content-wrapper" style="height:900px">
	<section class="content">
		<form class="form-horizontal" role="form" id="itemForm" >
			<div class="col-md-12">
	        	<div class="box box-info">
		            <div class="box-body">
		            	<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">商品编码</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly name="goodsId" value="${goodsId}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">商家编码(itemCode)</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="itemCode">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">货号(sku)</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="sku">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">重量</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="weight">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">成本价格</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="proxyPrice">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">分销价</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="fxPrice">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">消费税</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="exciseFax">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">最小限购数量</label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
	                  				<input type="text" class="form-control" name="min">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right">最大限购数量</label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
	                  				<input type="text" class="form-control" name="max">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>规格选择</h4></label>
						</div>
						<c:forEach var="spec" items="${template.specs}">
						<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">${spec.name}：</label>
								<div class="input-group">
										<c:forEach var="value" items="${spec.values}">
											<input type="radio"  name="${spec.id}:${spec.name}" value="${value.id}:${value.value}">${value.value}
										</c:forEach>
				                </div>
						</div>
						</c:forEach>
	            	</div>
          		</div>
			</div>
			<div class="col-md-offset-1 col-md-9">
				<div class="form-group">
                     <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
                 </div>
            </div>
		</form>
	</section>
</section>
	<script type="text/javascript">
	 
	 function refresh(){
			parent.location.reload();
	 }
	 
	 $("#submitBtn").click(function(){
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			 
			 var url = "${wmsUrl}/admin/goods/itemMng/save.shtml";
			 
			 var formData = sy.serializeObject($('#itemForm'));
			 
			 var newFormData;
			 var key = "";
			 var value = "";
			 
			 newFormData={};
			 for(var json in formData){
				 if(json.indexOf(":")!=-1){
					 key +=json+";"
					 value += formData[json]+";"
				 }else{
					 newFormData[json] = formData[json];
				 }
			}
			 
			 if(key == ""||value == ""){
				 layer.alert("没选择规格信息！");
				 return;
			 }
			 
			 newFormData["keys"] = key;
			 newFormData["values"] = value;
		
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(newFormData),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
						 refresh();
						 layer.alert("插入成功");
						 
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
		
		$('#itemForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
			  itemCode: {
		           message: '商家编码不正确',
		           validators: {
		               notEmpty: {
		                   message: '商家编码不能为空！'
		               }
		           }
		   	  },
		   	 weight: {
			        message: '重量不正确',
			        validators: {
			            notEmpty: {
			                message: '重量不能为空！'
			            },
					   regexp: {
		                   regexp: /^\d+(\.\d+)?$/,
		                   message: '消费税格式有误'
		               }
			        }
		   		},
			   proxyPrice:{
				   message:"成本价格有误",
				   validators: {
					   notEmpty: {
                           message: '成本价格不能为空'
                       },
					   regexp: {
		                   regexp: /^\d+(\.\d+)?$/,
		                   message: '成本价格格式有误'
		               }
			   		}
			   },
			   fxPrice:{
				   message:"分销价格有误",
				   validators: {
					   regexp: {
		                   regexp: /^\d+(\.\d+)?$/,
		                   message: '成本价格格式有误'
		               }
				   }
			   },
			   exciseFax:{
				   message: '消费税有无',
				   validators: {
					   notEmpty: {
	                       message: '消费税不能为空'
	                   },
					   regexp: {
		                   regexp: /^\d+(\.\d+)?$/,
		                   message: '消费税格式有误'
		               }
				   }
			   },
			   min:{
				   message: '最小限购数量有误',
				   validators: {
					   regexp: {
		                   regexp: /^\d+(\.\d+)?$/,
		                   message: '最小限购数量格式有误'
		               }
				   }
			   },
			   max:{
				   message: '最大限购数量有误',
				   validators: {
					   regexp: {
		                   regexp: /^\d+(\.\d+)?$/,
		                   message: '最大限购数量格式有误'
		               }
				   }
			   }
		}});
		
		
		function toList(){
				$("#list",window.parent.document).trigger("click");
		}
	</script>
</body>
</html>