<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    
<%@page import="user.UserDTO" %>
<%@page import="user.UserDAO" %>
<%@page import="utill.SHA256" %>
<%@page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail =null;
	if(request.getParameter("userID")!= null){
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword")!= null){
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userEmail")!= null){
		userEmail = request.getParameter("userEmail");
	}
	if(userID=="" || userPassword==""|| userEmail==""){
		System.out.printf("dfsdf");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안됐습니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		
	}
	
	
	UserDAO userDAO = new UserDAO();
	
	
	int result = userDAO.join(new UserDTO(userID,userPassword,userEmail,
			SHA256.getSHA256(userEmail), false));
	
	if(result==-1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디 입니다'); ");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	else
	{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = emailSendAction.jsp");
		script.println("</script>");
		script.close();
	}
	

		
%>