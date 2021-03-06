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

<link rel="stylesheet"
	href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
</head>

<body>
	<section class="content-wrapper" style="height: 900px">
		<section class="content">
				<form class="form-horizontal" role="form" id="adForm">
					<div class="col-md-12">
						<div class="box box-info">
							<div class="box-header with-border">
								<div class="box-header with-border">
									<h5 class="box-title">内容设置</h5>
									<div class="box-tools pull-right">
										<button type="button" class="btn btn-box-tool"
											data-widget="collapse">
											<i class="fa fa-minus"></i>
										</button>
									</div>
								</div>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">编号</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" readonly name="id" value="${data.id}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">跳转链接</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="href" value="${data.href}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">标题</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="title" value="${data.title}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">价格</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="price" value="${data.price}"> 
										</div>
									</div>
								</div>
									<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">国家</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="origin" value="${data.origin}"> 
										</div>
									</div>
								</div>
									<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">商品编号</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="goodsId" value="${data.goodsId}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">描述</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="description"  value="${data.description}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">大图(309*148px)</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="picPath" id="picPath" value="${data.picPath}"> 
											<input type="file" name="pic" id="pic" />
											<button type="button" class="btn btn-info" onclick="uploadFile()">上传</button>
										</div>
									</div>
								</div>
								<div class="col-md-offset-1 col-md-9">
									<div class="form-group">
											<button type="button" class="btn btn-info" onclick="save()">保存</button>
					                 </div>
					            </div>
							</div>
						</div>
					</div>
				</form>
		</section>
	</section>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	function save(){
		$('#adForm').data("bootstrapValidator").validate();
		 if($('#adForm').data("bootstrapValidator").isValid()){
			 $.ajax({
					url : '${wmsUrl}/admin/mall/indexMng/update.shtml',
					type : 'post',
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(sy.serializeObject($('#adForm'))),
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.location.reload();
							layer.alert("修改成功");
						} else {
							layer.alert(data.msg);
						}
					},
					error : function() {
						layer.alert("提交失败，请联系客服处理");
					}
				});
		 }else{
			 layer.alert("提交失败，请联系客服处理");
		 }
	}

	function uploadFile(id) {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFile.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#picPath").val(data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
	}
	
	$('#adForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  picPath: {
              message: '大图地址不能空',
              validators: {
                  notEmpty: {
                      message: '大图地址不能空！'
                  }
              }
      	  },
      	  description: {
              message: '描述不能空',
              validators: {
                  notEmpty: {
                      message: '描述不能空！'
                  }
              }
      	  },
      	  price: {
              message: '价格不能空',
              validators: {
                  notEmpty: {
                      message: '价格不能空！'
                  }
              }
      	  },
      	  goodsId: {
              message: '商品编号不能空',
              validators: {
                  notEmpty: {
                      message: '商品编号不能空！'
                  }
              }
      	  },
      	  origin: {
              message: '国家不能空',
              validators: {
                  notEmpty: {
                      message: '国家不能空！'
                  }
              }
      	  },
      	  title: {
              message: '标题不能空',
              validators: {
                  notEmpty: {
                      message: '标题不能空！'
                  }
              }
      	  }
      }
  });
	

	</script>
</body>
</html>
