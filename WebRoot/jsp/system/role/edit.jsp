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
<script src="${wmsUrl}/js/mytree.js"></script>

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
</head>

<body>
	<section class="content">
        <div class="main-content">
			<form class="form-horizontal" role="form" id="roleForm">
				<div class="row">
					<div class="col-xs-12 form-horizontal">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">角色编号</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" disabled class="form-control" name="roleId" value="${role.roleId}">
		                  			<input type="hidden" class="form-control" name="roleId" value="${role.roleId}">
		                  			
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">角色名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="roleName" id="roleName" value="${role.roleName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">启用状态</label>
							<div class="col-sm-8">
								<div class="col-sm-2">
								<c:if test="${role.roleState==1}">
									<label>
					                  	启用<input type="radio" name="roleState" value="1" class="flat-red" checked>
					                </label>
					                <label>
					                  	停用<input type="radio" name="roleState" value="0" class="flat-red">
					                </label>
								</c:if>
								<c:if test="${role.roleState==0}">
									<label>
					                  	启用<input type="radio" name="roleState" value="1" class="flat-red" >
					                </label>
					                <label>
					                  	停用<input type="radio" name="roleState" value="0" class="flat-red" checked>
					                </label>
								</c:if>
							</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-offset-3 col-xs-8">
					<div class="tree well">
						<ul>
							<c:forEach var="item" items="${menuList}">
							<li>
								<input type="checkbox" class="flat-red pcheck" name='funcId' value="${item.funcId}" <c:if test="${item.selected=='true'}">checked</c:if> > <span><i class="fa fa-folder-open"></i>${item.name}</span>
								<ul>
									<c:forEach var="node" items="${item.children}">
										<li>
											<label><input type="checkbox" class="flat-red" name='funcId' value="${node.funcId}" <c:if test="${node.selected}">checked</c:if>></label>
						                	<span class="tree-font">
						                		${node.name}
						                	</span>
										</li>
									</c:forEach>
								</ul>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-offset-3 col-md-3">
			<div class="form-group">
                   <button type="button" class="btn btn-primary"  name="signup" onclick="btnSubmit()">保存</button>
                   <button type="button" class="btn btn-info" id="closeBtn">关闭</button>
            </div>
        </div>
	</section>
	<script type="text/javascript">
	
	 function btnSubmit(){
		 
		 var roleName = $('#roleName').val();
		 
		 if(roleName == null||roleName==''){
			 layer.alert("角色名称不能为空！");
			 return;
		 }
		 
		 $.ajax({
			 url:"${wmsUrl}/admin/system/roleMng/editRole.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($("#roleForm"))),
		     contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("插入成功");
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					  layer.alert(data.errInfo);
				 }
			 },
			 error:function(){
				 layer.alert("系统出现问题啦，快叫技术人员处理");
			 }
		 });
	 }
	
	 $('#closeBtn').click(function() {
		 parent.layer.closeAll();
	   });
	
	 $('#resetBtn').click(function() {
	        $('#roleForm').data('bootstrapValidator').resetForm(true);
	    });
	</script>
</body>
</html>
