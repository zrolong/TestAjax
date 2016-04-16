<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Insert title here</title>
	<!--导入jquery库文件-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/JQuery/jquery-1.12.2.js"></script>
	<script type="text/javascript">
		/*
		1、导入jquery库
		2、为username添加响应函数
		4、获取val值，删除前后空格
		5、发送ajax请求，检查username的否可用
		6、
		
		1、获取a节点
		2、天加click函数
		3、准备发送ajax
		4、返回json数据
		
		*/
		$(function(){
			
			var isHasCart = "${sessionScope.sc == null}";
			if(isHasCart == "true"){
				$("#cartstatus").hide();
			}else{
				$("#cartstatus").show();
				
				$("#bookName").text("${sessionScope.sc.bookName}");
				$("#totalBookNumber").text("${sessionScope.sc.totalBookNumber}");
				$("#totalMoney").text("${sessionScope.sc.totalMoney}");
			}
			
			$(":input[name='username']").change(function(){
				
				var val = $(this).val();
				val = $.trim(val);
				
				if(val != ""){
					
					var url = "${pageContext.request.contextPath}/valiateUserName";  
					var args = {"userName":val,"time":new Date()};
					
					$.post(url,args,function(data){
						$("#message").html(data);
					});
				}
				
			});
			
			$("a").click(function (){
				
				$("#cartstatus").show();
				
				var url = this.href;
				var args = {"time":new Date()};
				
				$.getJSON(url,args,function(data){
					/*
						如果從服務器返回的數據必須為雙引號
					*/
					$("#bookName").text(data.bookName);
					$("#totalBookNumber").text(data.totalBookNameber);
					$("#totalMoney").text(data.totalMoney);
				});
				
				return false;
			});
		});
		

	</script>
</head>
<body>
	<center>
		<br><br><br>
		<form action="#" method="post">
			UserName :&nbsp;<input style="width:200px;height:22px" type="text" name="username">
			<br><br>
			<span id="message" style="width:200px; height:22px"></span>
			<br><br>
			<hr><br>
			<input style="width:200px; height:32px" type="submit" value="提交">
			<br><br>
			
			<br>
		</form>
		
		<br><br><br><br>
		<div id="cartstatus">
			您已将<span id="bookName"></span>加入到购物车，
			总共有<span id="totalBookNumber"></span>本书，
			总共有<span id="totalMoney"></span>钱
		</div>
		
		<br><br>
		Java &nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/addToCart?id=java&price=12">加入购物车</a>
		<br><br>
		Oracle&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/addToCart?id=oracle&price=24">加入购物车</a>
		<br><br>
		Script&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/addToCart?id=script&price=17">加入购物车</a>
		<br><br>
	</center>
</body>
</html>