<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@page import="evaluation.EvaluationDTO" %>
<%@page import="evaluation.EvaluationDAO" %>
<%@page import="utill.SHA256" %>
<%@page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	EvaluationDAO evaluationdao =new EvaluationDAO();
	
	String evaluationID =null;
	

	System.out.println(request.getParameter("evaluationID"));
	
	if(request.getParameter("evaluationID")!=null)
	{
		System.out.println(request.getParameter("evaluationID"));
		evaluationID=request.getParameter("evaluationID");
	}
	
	
	int result = evaluationdao.likey(evaluationID);
	
	if(result==1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('추천되었습니다'); ");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
	}
	else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류 발생'); ");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	
%>