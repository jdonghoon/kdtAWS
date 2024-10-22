<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.")
		location.href = "<%= request.getContextPath()%>/user/login.jsp";
	</script>
<%		
	}
	int mno = 0;
	if(request.getParameter("mno") != null) {
		mno = Integer.parseInt(request.getParameter("mno"));
	}
	
	String title = "";
	String brand = "";
	String content = "";
	String newFile = "";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try {
		conn = DBConn.conn();
		
		String sql = " SELECT mno"
				   + " , title"
				   + " , brand"
				   + " , content"
				   + " , newfile"
				   + " FROM market m"
				   + " INNER JOIN user u"
				   + " ON m.uno = u.uno"
				   + " WHERE mno = ?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, mno);
		
		rs = psmt.executeQuery();
		
		if(rs.next()) {
			title = rs.getString("title");
			brand = rs.getString("brand");
			content = rs.getString("content");
			newFile = rs.getString("newfile");
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		DBConn.close(rs, psmt, conn);
	}
%>

<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <title>StyleGuide</title>
        <script src="js/jquery-3.7.1.js"></script>
        <link href = "./modify.css" type = "text/css" rel = "stylesheet">
    </head>
    <body>
        <header>
            <div class="lijnmplo">
            <%
	            if(session.getAttribute("id") != null) {
	            	String id = (String)session.getAttribute("id");
	        %>
	            	 <strong style="margin-right: 15px; color: grey;"><%= id %></strong>
	        <%
	            }
            %>
                <a href="<%= request.getContextPath() %>/user/mypage_info.jsp" id="loginmypage">mypage</a>
                <a href="<%= request.getContextPath() %>/user/logout.jsp" id="joinlogout">logout</a>
            </div>
            <div class="logo">
                <a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/logo/logo.PNG" width="150px"></a>
            </div>
            <nav>
                <div class="navbar">
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/MyItem/list.jsp" class="navmenu">MyItem</a></li>
                        <li><a href="list.jsp" class="navmenu" style="font-weight: bold;">Market</a></li>
                        <li><a href="<%=request.getContextPath()%>/FreeBoard/list.jsp" class="navmenu">FreeBoard</a></li>
                        <li><a href="<%=request.getContextPath()%>/Notice/list.jsp" class="navmenu">Notice</a></li>
                    </ul>
                </div>
            </nav>
        </header>
        <section>
            <article>
                <form action="modifyOk.jsp" enctype="multipart/form-data" method="post">
                <input type="hidden" name="mno" value="<%= mno %>"> 
	                <div class="write_container">
	                    <div class="write_content_title">글수정</div>
	                    <div class="write_content">
	                        <div class="content_area">
	                            <div>제목</div>
	                            <input type="text" name="title" value="<%= title %>"> 
	                        </div>
	                        <div class="content_area">
	                            <div>브랜드</div>
	                            <input type="text" name="brand" value="<%= brand %>">
	                        </div>
	                        <div class="content_area">
	                            <div>내용</div>
	                            <textarea name="content"><%= content %></textarea>
	                        </div>
	                        <div class="content_area">
	                            <div>첨부파일</div>
	                            <input type="file" name="file" style="border:none;">
	                        </div>
	                    </div>
	                </div>
                    <div class="button_area">
                        <button>수정하기</button>
                    </div>
                </form>
            </article>
        </section>
        <footer>
            <div class="footer_first">
                <a href="" class="footer_list">이용약관</a>
                <a href="" class="footer_list">사업자정보확인</a>
                <a href="" class="footer_list">고객센터</a>
            </div>
            <div class="footer_second">
                <div>StyleGuide | 대표이사 : 전동훈</div>
                <div>사업자등록번호 : 111-11-11111</div>
                <div>주소 : 군산시 궁포2로 20</div>
                <div>이메일 : wjsehdgns93@gmail.com</div>
            </div>
        </footer>
    </body>
</html>