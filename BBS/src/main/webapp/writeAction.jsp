<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<!-- 자바 스크립트를 사용하게 해주는 io -->
<%@ page import="java.io.PrintWriter" %>
<!-- 건너오는 모든 자료를 이형식으로 변환하겠다 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현재 페이지 안에서만 빈즈를 사용될수 있도록 한다 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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
		if (userID == null){ //로그인이 안되어 있다면 로그인 페이지로 보낸다
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 완료하세요.')");
			script.println("location.href = 'login.jsp'"); 
			script.println("</script>");
		} else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목 또는 내용을 입력하세요.')");
				script.println("history.back()"); //다시 뒤 페이지로 보내준다
				script.println("</script>");
			}else{
				BbsDAO bbsDAO = new BbsDAO();
				int result  = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')"); //여기서 데이터베이스오류는 글쓰기 실패 상태이다.
					script.println("history.back()"); //다시 뒤 페이지로 보내준다
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body>
</html>