<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Enumeration"%>
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
		// 첨부 파일의 크기를 설정하고 업로드될 경로를 정함.
		int size = 10*1024*1024;
		String uploadPath = request.getServletContext().getRealPath("/upload");
		
		MultipartRequest multi = null;
		Connection conn = null;
		PreparedStatement psmt = null;
				
		try {
			/* MultipartRequest의 파라미터
			(request의 내장객체 설정, 저장 경로, 파일의 최대 크기, 인코딩 유형, 파일명 변경 정책) */
			multi = new MultipartRequest(
					request,
					uploadPath,
					size,
					"UTF-8",
					new DefaultFileRenamePolicy()
					);
			
			int uno = (int)session.getAttribute("no");
			String title = multi.getParameter("title");
			String brand = multi.getParameter("brand");
			String content = multi.getParameter("content");
			String file = multi.getParameter("file");
			
			// Enumeration : 데이터를 출력하기 위한 인터페이스
			Enumeration<?> files = multi.getFileNames();
			String orgFile = "";
			String newFile = "";
			
			if(files != null){
				// 해당하는 요소를 꺼내고 다음 요소를 가르킴
				String fileId = (String)files.nextElement();
				// 업로드된 파일명을 fileName에 저장
				String fileName = (String)multi.getFilesystemName("file");

				if(fileName != null){
					// 새로운 파일명을 랜덤으로 지정 
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
			
			String sql = " INSERT INTO myitem ("
					   + " uno,"
					   + " title,"
					   + " brand,"
					   + " content,"
					   + " orgfile,"
					   + " newfile"
					   + " ) VALUES ("
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?,"
					   + " ?"
					   + " )";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, uno);
			psmt.setString(2, title);
			psmt.setString(3, brand);
			psmt.setString(4, content);
			psmt.setString(5, orgFile);
			psmt.setString(6, newFile);
			
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
