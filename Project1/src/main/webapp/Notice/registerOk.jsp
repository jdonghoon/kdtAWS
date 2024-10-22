<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	if(request.getMethod().equals("GET")) {
%>
	<script>
		alert("잘못된 접근입니다.");
		location.href = "list.jsp";
	</script>
<%		
	} else if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
		<script>
			alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
			location.href = "<%= request.getContextPath()%>/user/login.jsp";
		</script>
<%		
	} else {
		
		request.setCharacterEncoding("UTF-8");
		
		Connection conn = null;
		PreparedStatement psmt = null;
				
		try {
			int uno = (int)session.getAttribute("no");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			conn = DBConn.conn();
			
			String sql = " INSERT INTO notice_board ("
					   + " uno,"
					   + " title,"
					   + " content"
					   + " ) VALUES ("
					   + " ?,"
					   + " ?,"
					   + " ?"
					   + " )";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, uno);
			psmt.setString(2, title);
			psmt.setString(3, content);
			
			int result = psmt.executeUpdate();
			if(result > 0) {
%>
			<script>
				alert("글이 저장되었습니다.");
				location.href = "list.jsp";
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
			<script>
				alert("글이 저장되지 않았습니다.");
				location.href = "list.jsp";
			</script>