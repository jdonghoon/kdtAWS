<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%@ page import="java.util.*" %>
<%
	int mino = Integer.parseInt(request.getParameter("mino"));
	
	if(request.getMethod().equals("GET")) {
%>
	<script>
		alert("잘못된 접근입니다.");
		location.href = "view.jsp?mino=<%= mino %>";
	</script>
<%		
	}
	
	if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
		location.href = "<%= request.getContextPath() %>"/user/login.jsp";
	</script>
<%		
	} else {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = "UPDATE myitem SET state = 'D' WHERE mino = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, mino);
			
			int result = psmt.executeUpdate();
			if(result > 0) {
%>
		<script>
			alert("삭제 되었습니다.");
			location.href = "list.jsp";
		</script>
<%				
			}
		} catch(Exception e) {
			e.printStackTrace();
			out.print(e.getMessage());
		} finally {
			DBConn.close(psmt, conn);
		}	
	}
%>
		<script>
			alert("해당 글이 삭제되지 않았습니다.");
			location.href = "view.jsp?mino=<%= mino %>";
		</script>