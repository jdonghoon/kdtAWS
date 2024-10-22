<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	if(request.getMethod().equals("GET")) {
%>
	<script>
	alert("잘못된 접근입니다.");
	location.href = "join.jsp";
	</script>
<%
	} else {
		
		request.setCharacterEncoding("UTF-8");
		// 입력받은 값들을 파라미터로 불러옴
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String name = request.getParameter("name");
		
		int age = 0;
		String strAge = request.getParameter("age");
		if (strAge != null && !strAge.equals(""))
		{
			age = Integer.parseInt(strAge);
		}
		
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		
		// 받아오는 모든 값들 중 하나라도 null이거나 빈칸이면 join으로 이동 
		if(id == null || id.equals("")	|| pw == null || pw.equals("") ||
		   name == null || name.equals("") || email == null || email.equals("") ||
		   gender == null || gender.equals("") || phone == null || phone.equals("") ) {
		   response.sendRedirect("join.jsp");
			return;
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
			String sql ="INSERT INTO user ("
					   + " uid,"
					   + " password,"
					   + " name,"
					   + " age,"
					   + " email,"
					   + " gender,"
					   + " phone"
					   + " ) VALUES ("
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?"
					   + ")";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pw);
			psmt.setString(3, name);
			psmt.setInt(4, age);
			psmt.setString(5, email);
			psmt.setString(6, gender);
			psmt.setString(7, phone);
			
			psmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
		}
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href = "joinOk.css" type = "text/css" rel = "stylesheet">
	</head>
	<body>
		<header>
            <div class="logo">
                <a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/logo/logo.PNG" width="150px"></a>
            </div>
        </header>
        <section>
            <article>
                <div class="mypage_title">환영합니다.<br> 가입이 완료되었습니다.</div>
                    <button class="changepw_button" onclick="location.href='login.jsp'">로그인 하기</button>
            </article>
        </section>
        <footer>
            <div class="footer_first">
                <a href="" class="footer_list">이용약관</a>
                <a href="" class="footer_list">사업자정보확인</a>
                <a href="" class="footer_list">고객센터</a>
            </div>
            <div class="footer_second">
                <div>StyleGuide | 대표이사 : 전동훈</div>
                <div>사업자등록번호 : 111-11-11111</div>
                <div>주소 : 군산시 궁포2로 20</div>
                <div>이메일 : wjsehdgns93@gmail.com</div>
            </div>
        </footer>
	</body>
</html>