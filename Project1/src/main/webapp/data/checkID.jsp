<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try {
		conn = DBConn.conn();
		
		// 입력된 아이디가 존재하는지 여부 확인
		String sql = " SELECT count(*) as cnt"
				   + " FROM user"
				   + " WHERE uid = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		
		rs = psmt.executeQuery();
		if(rs.next()) {
			// result가 1이면 존재하는 아이디
			int result = rs.getInt("cnt");
			if(result > 0) {
				out.print("isId");
			} else {
				out.print("isNotId");
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		DBConn.close(rs, psmt, conn);
	}

%>