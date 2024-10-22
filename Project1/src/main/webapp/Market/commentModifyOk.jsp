<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	int cno = 0; 
	if(request.getParameter("cno") != null) {
		cno = Integer.parseInt(request.getParameter("cno"));
	}
	
	int mno = 0; 
	if(request.getParameter("mno") != null) {
		mno = Integer.parseInt(request.getParameter("mno"));
	}

	String content = request.getParameter("content");

	if(request.getMethod().equals("GET")) {
%>
	<script>
	alert("잘못된 접근입니다.");
	location.href = "<%= request.getContextPath()%>/Market/view.jsp";
	</script>
<%		
	} else {
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = "UPDATE m_comment"
					   + " SET content = ?"
					   + " WHERE cno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, content);
			psmt.setInt(2, cno);
			
			psmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
		}
		
		response.sendRedirect("view.jsp?mno=" + mno);
	}
%>
