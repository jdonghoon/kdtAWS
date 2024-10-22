<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<script>
      	function logout() {
      		alert("로그아웃 되었습니다.");
      	}
	</script>
	<head>
        <meta charset="UTF-8">
        <title>StyleGuide</title>
        <script src="js/jquery-3.7.1.js"></script>
        <link href = "register.css" type = "text/css" rel = "stylesheet">
    </head>
    <body>
        <script>
        	function logout() {
        		alert("로그아웃 되었습니다.");
        	}
        </script>
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
                <a href="<%= request.getContextPath() %>/user/logout.jsp" id="joinlogout" onclick="logout();">logout</a>
            </div>
            <div class="logo">
                <a href="<%= request.getContextPath() %>/index.jsp"><img src="<%= request.getContextPath() %>/logo/logo.PNG" width="150px"></a>
            </div>
            <nav>
                <div class="navbar">
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/MyItem/list.jsp" class="navmenu">MyItem</a></li>
                        <li><a href="<%=request.getContextPath()%>/Market/list.jsp" class="navmenu">Market</a></li>
                        <li><a href="<%=request.getContextPath()%>/FreeBoard/list.jsp" class="navmenu">FreeBoard</a></li>
                        <li><a href="list.jsp" class="navmenu" style="font-weight: bold;">Notice</a></li>
                    </ul>
                </div>
            </nav>
        </header>
        <section>
           	<form action="<%= request.getContextPath() %>/Notice/registerOk.jsp" method="post">
	            <article>
	                <div class="write_container">
	                    <div class="write_content_title">글쓰기</div>
	                    <div class="write_content">
	                        <div class="content_area">
	                            <div>제목</div>
	                            <input type="text" name="title">
	                        </div>
	                        <div class="content_area">
	                            <div>내용</div>
	                            <textarea name="content"></textarea>
	                        </div>
	                    </div>
	                </div>
	                    <div class="button_area">
	                        <button>저장하기</button>
	                    </div>
            	</article>
           	</form>
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