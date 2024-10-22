<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="project.*" %>
<%
	int mino = 0;

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
			location.href = "<%= request.getContextPath()%>/user/login.jsp";
		</script>
<%	
	} else {
		int size = 10*1024*1024;
		String uploadPath = request.getServletContext().getRealPath("/upload");
		
		MultipartRequest multi = null;
		Connection conn = null;
		PreparedStatement psmt = null;
				
		try {
			multi = new MultipartRequest(
					request,
					uploadPath,
					size,
					"UTF-8",
					new DefaultFileRenamePolicy()
					);
			if(multi.getParameter("mino") != null) {
				mino = Integer.parseInt(multi.getParameter("mino"));
			}
			String title = multi.getParameter("title");
			String brand = multi.getParameter("brand");
			String content = multi.getParameter("content");
			String file = multi.getParameter("file");
			
			Enumeration<?> files = multi.getFileNames();
			String orgFile = "";
			String newFile = "";
			
			if(files != null){
				String fileId = (String)files.nextElement();
				String fileName = (String)multi.getFilesystemName("file");
				
				if(fileName != null){
					String newFileName = UUID.randomUUID().toString();
					
					String orgName = uploadPath + "\\" + fileName;
					String newName = uploadPath + "\\" + newFileName;
					
					File srcFile = new File(orgName);
					File targetFile = new File(newName);
					
					srcFile.renameTo(targetFile);
					
					orgFile = fileName;
					newFile = newFileName;
				}
			}
			
			conn = DBConn.conn();
			
			String sql = "";
			
			if(!orgFile.equals("")) {
				sql = " UPDATE myitem"
					+ " SET title = ?"
					+ " , brand = ?"
					+ " , content = ?"
					+ " , orgfile = ?"
					+ " , newfile = ?"
					+ " WHERE mino = ?";
				 
				psmt = conn.prepareStatement(sql);
				 
				psmt.setString(1, title);
		  		psmt.setString(2, brand);
		  		psmt.setString(3, content);
			   	psmt.setString(4, orgFile);
				psmt.setString(5, newFile);
				psmt.setInt(6, mino);
			} else {
				sql = " UPDATE myitem"
				    + " SET title = ?"
				    + " , brand = ?"
				    + " , content = ?"
					+ " WHERE mino = ?";
				
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, title);
				psmt.setString(2, brand);
				psmt.setString(3, content);
				psmt.setInt(4, mino);
			}
			
			int result = psmt.executeUpdate();
			if(result > 0) {
%>
			<script>
				alert("글이 수정되었습니다.");
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
				alert("글이 수정되지 않았습니다.");
				location.href = "view.jsp?mino=<%= mino %>";
			</script>