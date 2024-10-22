<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%

	int cno = Integer.parseInt(request.getParameter("cno"));
	int mino = Integer.parseInt(request.getParameter("mino"));
	
	if(request.getMethod().equals("GET")){
%>
	<script>
	alert("잘못된 접근입니다.");
	location.href = "<%= request.getContextPath()%>MyItem/view.jsp";
	</script>
<%		
	}

	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBConn.conn();
		
		String sql = " UPDATE i_comment"
				   + "    SET state = 'D'"
				   + "  WHERE cno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,cno);
		
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBConn.close(psmt,conn);
	}
	
	response.sendRedirect("view.jsp?mino=" + mino);
%>