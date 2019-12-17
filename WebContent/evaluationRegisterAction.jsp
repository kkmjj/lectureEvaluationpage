<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    
<%@page import="evaluation.EvaluationDTO" %>
<%@page import="evaluation.EvaluationDAO" %>
<%@page import="utill.SHA256" %>
<%@page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;

	if(session.getAttribute("userID")!= null)
		{
			userID = (String)session.getAttribute("userID");
	
		}
	
	if(userID==null){
		System.out.printf("dfsdf");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		
	}
	

	 String lectureName =null;
	 String professorName =null;
	 int lectureYear=0;
	 String semesterDivide=null;
	 String lectureDivide=null;
 	 String evaluationTitle=null;
	 String evaluationContent=null;
	 String totalScore=null;
	 String creditScore=null;
 	 String comfortableScore=null;
	 String lectureScore=null;
	
	
	// spring을 사용하지 않기 때문에  이렇게 일일이 넣어 주어야 하는 번거로움이 있음 (spring의 필요성 )
	if(request.getParameter("lectureName")!=null)lectureName=request.getParameter("lectureName");
	if(request.getParameter("professorName")!=null)professorName=request.getParameter("professorName");
	if(request.getParameter("lectureYear")!=null)
	{	try{
		lectureYear=Integer.parseInt((request.getParameter("lectureYear")));
		}
		catch(Exception e)
		{
			System.out.print("연동 오류");
		}
	}
	if(request.getParameter("semesterDivide")!=null)semesterDivide=request.getParameter("semesterDivide");
	if(request.getParameter("lectureDivide")!=null)lectureDivide=request.getParameter("lectureDivide");
	if(request.getParameter("evaluationTitle")!=null)evaluationTitle=request.getParameter("evaluationTitle");
	if(request.getParameter("evaluationContent")!=null)evaluationContent=request.getParameter("evaluationContent");
	
	//if(request.getParameter("totalScore")!=null)totalScore=request.getParameter("totalScore");
	//if(request.getParameter("creditScore")!=null)creditScore=request.getParameter("creditScore");
	//if(request.getParameter("comfortableScore")!=null)comfortableScore=request.getParameter("comfortableScore");
	//if(request.getParameter("lectureScore")!=null)lectureScore=request.getParameter("lectureScore");
	
	
	// 하나라도 작성이 안되어있으면 
	if(lectureName==null || professorName==null ||lectureYear==0 ||semesterDivide==null ||lectureDivide==null ||
			evaluationTitle==null ||evaluationContent==null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('빈 공간이 있습니다'); ");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	EvaluationDAO evaluationDAO =new  EvaluationDAO();
	int result =evaluationDAO.Write(new EvaluationDTO(0,userID,lectureName,professorName,lectureYear,
			semesterDivide,lectureDivide, evaluationTitle,evaluationContent,totalScore,creditScore,comfortableScore,lectureScore,0));
	
	
	
	if(result==1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('작성 완료 '); ");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록실패 '); ");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
	}
	
	
	
	
	
	

		
%>