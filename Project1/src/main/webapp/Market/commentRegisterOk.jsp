<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	int mno = 0;
	if(request.getParameter("mno") != null) {
		mno = Integer.parseInt(request.getParameter("mno"));
	}

	if(request.getMethod().equals("GET")) {
%>
	<script>
		alret("잘못된 접근입니다.");
		location.href = "<%= request.getContextPath()%>/Market/view.jsp";
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
		
		int uno = (int)session.getAttribute("no");
		String content = request.getParameter("content");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = " INSERT INTO m_comment ("
					   + " uno,"
					   + " mno,"
					   + " content "
					   + " ) VALUES ("
					   + " ?,"
					   + " ?,"
					   + " ? "
					   + " )";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, uno);
			psmt.setInt(2, mno);
			psmt.setString(3, content);

			psmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmt, conn);
		}
		
		response.sendRedirect("view.jsp?mno=" + mno);
		
	}
%>