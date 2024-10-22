<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%

	if(request.getMethod().equals("GET")) {
%>
	<script>
		alert("잘못된 접근입니다.");
		location.href = "index.jsp";
	</script>
<%		
	} else {
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = " SELECT *"
					   + "   FROM user"
					   + "  WHERE uid = ?"
					   + "  AND password = ?";
			
			psmt = conn.prepareStatement(sql);
			// 받아온 파라미터 값으로 sql 조건문을 채움
			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				int uno = rs.getInt("uno");
				String uid = rs.getString("uid");
				String upw = rs.getString("password");
				String uname = rs.getString("name");
				int uage = rs.getInt("age");
				String uemail = rs.getString("email");
				String uphone = rs.getString("phone");
				String ugender = rs.getString("gender");
				String udate = rs.getString("udate");
				String uauthorization = rs.getString("uauthorization");
				
				/* 불러온 값들을 세션에 저장
				   예) "no"라는 이름에 uno를 저장*/
				session.setAttribute("no", uno);
				session.setAttribute("id", uid);
				session.setAttribute("password", upw);
				session.setAttribute("name", uname);
				session.setAttribute("age", uage);
				session.setAttribute("email", uemail);
				session.setAttribute("phone", uphone);
				session.setAttribute("gender", ugender);
				session.setAttribute("date", udate);
				session.setAttribute("authorization", uauthorization);
%>
		<script>
			alert("로그인 되었습니다.");
			location.href = "<%=request.getContextPath()%>/index.jsp";
		</script>
<%				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
		}
	}
%>
		<script>
			alert("로그인에 실패하였습니다. 아이디, 비밀번호를 확인해주세요.");
			location.href = "login.jsp";
		</script>