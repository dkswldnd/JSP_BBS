<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!-- 자바 스크립트를 사용하게 해주는 io -->
<%@ page import="java.io.PrintWriter" %>
<!-- 건너오는 모든 자료를 이형식으로 변환하겠다 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현재 페이지 안에서만 빈즈를 사용될수 있도록 한다 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'"); //다시 뒤 페이지로 보내준다
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result  = userDAO.login(user.getUserID(), user.getUserPassword()); //user클래스에서 작성한것을 각져와서 login함수를 실행시킨다
		if (result == 1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()"); //다시 뒤 페이지로 보내준다
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()"); //다시 뒤 페이지로 보내준다
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()"); //다시 뒤 페이지로 보내준다
			script.println("</script>");
		}
	%>
</body>
</html>