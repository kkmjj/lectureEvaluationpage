<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO " %>
<%@ page import="java.io.PrintWriter " %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="with=device-width, initial-scale=1, shrink-to-fit=no"> 
	<title>강의 평가 웹 사이트 </title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
		<link rel="stylesheet" href="./css/custom.css">
	
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null;
	if(session.getAttribute("userID")!="")
	{
		userID=(String)session.getAttribute("userID");
	}
	else
	{
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("location.href='userLogin.jsp';");
		script.println("<script>");
		script.close();
		return;
	}
	
%>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.jsp">강의평가 </a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
	<span class="navbar-toggler-icon"></span>
	</button>
	<div id="navbar" class="collapse navbar-collapse">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="index.jsp">메인</a>
			
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
				회원관리
				</a>
				<div class="dropdown-menu" aria-labelledby="dropdown">
				
				<% 
				if(userID==null)
				{
					
				
				%>
					<a class="dropdown-item" href="userLogin.jsp">로그인</a>
					<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
					<%
				}
				else
				{
					%>
					
					<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
				<%
				}
				%>
				
				</div>
			
			</li>
			
		</ul>
		<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0"> <!-- method ="get" URL의 끝에 데이터를 첨부해서 전송하는 방식(까라 방식) -->
		<input type="text" name="search" class="form-control mr-sm-2" 
		placeholder="내용을 입력하세요" aria-label="Search">
		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		
		</form>
		
		
		
		
	</div>
	</nav>
	
	
	<section class="container mt-4" style="max-width: 600px; "><!-- mt-3 위쪽 여백 3 -->
	<form method="post" action="./userLoginAction.jsp"><!-- 로그인을 요청했을때 정보가 해당 jsp 로 넘어감 -->
	<div class="form-group">
		<label>아이디</label>
		<input type="text" name="userID" class="form-contorl">
		<label>비밀번호</label>
		<input type="password" name="userPassword" class="form-contorl">
		<button type="submit" class="btn btn-primary">로그인</button>
	</div>
	</form > 
	
	
	</section>
	

	
	
	
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #ffffff;">@copyright 김민준</footer>
	
	
	

<!-- 제이쿼리 추가  -->
<script src="./js/jquery.min.js"> </script>
<script src="./js/pooper.js"> </script>
<script src="./js/bootstrap.min.js"> </script>


</body>
</html>