<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO " %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter " %>
<%@ page import="java.net.URLEncoder" %>
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
	String lectureDivide="기타";
	String searchType="최신순";
	String search="";
	int pageNumber=0;
	String userID=null;
	
	
	if(request.getParameter("lectureDivide")!=null)
	{
		lectureDivide=request.getParameter("lectureDivide");
		
		System.out.println("lectureDividerequset"+lectureDivide);
	}
	if(request.getParameter("searchType")!=null)
	{
		searchType=request.getParameter("searchType");
		
		System.out.println("searchTyperequset"+searchType);
	}
	if(request.getParameter("search")!=null)
	{
		search=request.getParameter("search");
		System.out.println("searcherequset"+search);
	}
	if(request.getParameter("pageNumber")!=null)
	{
		pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	
	
	if(session.getAttribute("userID")!=null)
	{	
		System.out.print("로그인됨");
		userID=(String)session.getAttribute("userID");
	}
	
	if(userID==null)
	{	
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
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
	
	
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체 </option>
				<option value="전공"<% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공 </option>
				<option value="교양"<% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양 </option>
				<option value="기타"<% if(lectureDivide.equals("기타")) out.println("selected"); %>>기타 </option>
			</select>
			
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순 </option>
				<option value="추천순"<% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
				
			</select>
			
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 담아주세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			
			<a class="btn  btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn  btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
		</form>
<% 
	ArrayList<EvaluationDTO> result =new ArrayList<EvaluationDTO>();
	
	result = new EvaluationDAO().getlist(lectureDivide, search, searchType, pageNumber);
	
	
	
	if(result!=null)
	{
		
		for(int i=0;i<result.size();i++)
		{
			if(i==5) break; // 5개 만출력 
			EvaluationDTO value= result.get(i);
		System.out.println("value.getlecture"+value.getLectureName());
			
%>

	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
			<div class="col-8 text-left">강의이름<%=value.getLectureName() %><small><%=value.getProfessorName() %></small></div>
		
			</div>
		</div>
		<div class="card-body">
			<h5 class="card-title"><%=value.getEvaluationTitle() %><small><%=value.getLectureYear()%></small> </h5> <!-- &nbsp 띄어쓰기 --> <!-- small 태크 글씨체 조그맣게 -->
			<p class="card-text"><%=value.getEvaluationContent() %></p>
			
			<div class="row">
				<div class="col-9 text-left">
																 <!-- div와 span의 차이는 span은 옆에 공간을 잡아준다 div는 들여쓴다음 잡아준다 -->
				강의추천:<span style="color:green;"><%=value.getLikeCount() %></span>
				</div>
				<div class="col-3 text-right">
					<a onclick="return confirm('추천합니까')" href="./likeAction.jsp?evaluationID=<%=value.getEvaluationID() %>">추천</a>
					<a onclick="return confirm('삭제합니까')" href="./deleteAction.jsp?evaluationID=<%=value.getEvaluationID()%>
					&userID=<%=value.getUserID()%>">삭제</a>
				</div>
			
			</div>
			
		</div>
	
	</div>
<%

		}
	}
%>
	
	</section>
	
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
		<% 
		if(pageNumber <=0){
		%>
		
		<a class="page-link disabled">이전</a>
		
		
		<%
		} else 
		{
		
		%>
			<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"UTF-8") %>
			&searchType=<%=URLEncoder.encode(searchType,"UTF-8") %>&search=<%=URLEncoder.encode(search,"UTF-8") %>
			&pageNumber=<%= pageNumber-1 %>">이전 </a>
		<%
		}
		%>	
		
		</li>
		
		
		<li class="page-item">
		<% 
		if(result.size()< 6){
		%>
		
		<a class="page-link disabled">다음</a>
		
		
		<%
		} else 
		{
		
		%>
			<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"UTF-8") %>
			&searchType=<%=URLEncoder.encode(searchType,"UTF-8") %>&search=<%=URLEncoder.encode(search,"UTF-8") %>
			&pageNumber=<%= pageNumber+1 %>">다음 </a>
		<%
		}
		%>	
		
		</li>
		
	</ul>
	
	
	
	
	
	
	
	
	<!-- 등록하기 가 눌러지면 href id 에 해당하는 화면 이 보여짐  -->
	
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		
		<div class="modal-content">
			
			<div class="modal-header">
				<h5 class="modal-title" id="modal">평가 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-baby">
				<form action="./evaluationRegisterAction.jsp" method="post">
					
					<div class="form-row">
						<div class="form-group col-sm-6">
							<label>강의명</label>
							<input type="text"name="lectureName" class="form-control" maxlength="20">
							
						</div>
						<div class="form-group col-sm-6">
						<label>교수명</label>
							<input type="text"name="professorName" class="form-control" maxlength="20">
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group col-sm-4">
						<label>수강 연도</label>
						<select name="lectureYear" class="form-control">
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018" >2018</option> <!-- 처음 선택  -->
							<option value="2018" selected>2019</option> <!-- 처음 선택  -->
		
						</select>
							
						</div>
					
						<div class="form-group col-sm-4">
						<label>수강학기</label>
						<select name="semesterDivide" class="form-control">
							<option value="1학기">1학기</option>
							<option value="2학기">2학기</option>
							<option value="여름학기" selected>여름학기</option> <!-- 처음 선택  -->
							<option value="겨울학기">겨울학기</option>
						</select>
							
						</div>
					
						<div class="form-group col-sm-4">
						<label>강의구분</label>
						<select name="lectureDivide" class="form-control">
							<option value="전공">전공</option>
							<option value="교양">교양</option>
							<option value="기타" selected>기타</option> <!-- 처음 선택  -->
						
						</select>
							
						</div>
					</div>
					<!-- 평가 내용  -->
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea  name="evaluationContent" class="form-control" maxlength="2048"
						style="height:180px;"></textarea>
					</div>
				<!-- 전송 버튼 -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">등록하기</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						
					</div>
				
				</form>
			</div>
		</div>
		
	</div>
	</div>
	
	<!-- 신고하기 화면  -->
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		
		<div class="modal-content">
			
			<div class="modal-header">
				<h5 class="modal-title" id="modal">신고하기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-baby">
				<form action="./reportAction.jsp" method="post">
					
					<!-- 평가 내용  -->
					<div class="form-group">
						<label>신고 제목</label>
						<input type="text" name="reportTitle" class="form-control" maxlength="30">
					</div>
					<div class="form-group">
						<label>신고 내용</label>
						<textarea  name="reportContent" class="form-control" maxlength="2048"
						style="height:180px;"></textarea>
					</div>
				<!-- 전송 버튼 -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">신고하기</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						
					</div>
				
				</form>
			</div>
		</div>
		
	</div>
	</div>
	
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #ffffff;">@copyright 김민준</footer>
	
	
	

<!-- 제이쿼리 추가  -->
<script src="./js/jquery.min.js"> </script>
<script src="./js/pooper.js"> </script>
<script src="./js/bootstrap.min.js"> </script>


</body>
</html>