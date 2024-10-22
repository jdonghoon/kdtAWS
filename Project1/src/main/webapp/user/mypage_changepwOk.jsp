<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
		location.href = "login.jsp";
	</script>
<%		
	} else {
		request.setCharacterEncoding("UTF-8");
		
		int uno = (int)session.getAttribute("no");
		String pw = request.getParameter("password");
		String changePw = request.getParameter("changePw");
		String changePwCheck = request.getParameter("changePwCheck");
		
		if(pw == null || pw.equals("") || changePw == null || changePw.equals("")
					  || changePwCheck == null || changePwCheck.equals("")) {
			response.sendRedirect("mypage_changepw.jsp");
			return;
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = " UPDATE user"
					   + " SET password = ?"
					   + " WHERE uno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, changePw);
			psmt.setInt(2, uno);
			
			int result = psmt.executeUpdate();
			if(result > 0) {
%>
			<script>
				alert("비밀번호 변경이 완료되었습니다.");
				location.href = "<%=request.getContextPath()%>/user/mypage_info.jsp";
			</script>
<%				
		 	}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
		}
	}
%>