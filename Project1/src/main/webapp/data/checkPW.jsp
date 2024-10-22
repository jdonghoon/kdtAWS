<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pw = request.getParameter("password");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try {
		conn = DBConn.conn();
		
		String sql = " SELECT count(*) as cnt"
				   + " FROM user"
				   + " WHERE password = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, pw);
		
		rs = psmt.executeQuery();
		if(rs.next()) {
			int result = rs.getInt("cnt");
			if(result > 0) {
				out.print("isPw");
			} else {
				out.print("isNotPw");
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		DBConn.close(rs, psmt, conn);
	}

%>