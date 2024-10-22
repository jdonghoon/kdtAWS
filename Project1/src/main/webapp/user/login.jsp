<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>StyleGuide</title>
		<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>
		<link href = "login.css" type = "text/css" rel = "stylesheet">
	</head>
	<body>
		<header>
            <div class="lijnmplo">
                <a href="login.jsp" id="loginmypage">login</a>
                <a href="join.jsp" id="joinlogout">join</a>
            </div>
            <div class="logo">
                <a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/logo/logo.PNG" width="150px"></a>
            </div>
            <nav>
                <div class="navbar">
                    <ul>
                        <li><a href="<%=request.getContextPath()%>/MyItem/list.jsp" class="navmenu">MyItem</a></li>
                        <li><a href="<%=request.getContextPath()%>/Market/list.jsp" class="navmenu">Market</a></li>
                        <li><a href="<%=request.getContextPath()%>/FreeBoard/list.jsp" class="navmenu">FreeBoard</a></li>
                        <li><a href="<%=request.getContextPath()%>/Notice/list.jsp" class="navmenu">Notice</a></li>
                    </ul>
                </div>
            </nav>
        </header>
        <section>
            <article>
                <div class="login_title">Login</div>
                <form action="loginOk.jsp" method="post">
                    <div class="login_text">아이디</div>
                    <div>
                        <input type="text" class="input_box" name="id">
                    </div>
                    <div class="login_text">비밀번호</div>
                    <div>
                        <input type="password" class="input_box" name="password">
                    </div>
                    <button class="login_button">로그인</button>
                </form>
                <div>
                    <a href="" class="login_help">아이디 찾기</a>
                    <a href="" class="login_help">비밀번호 찾기</a>
                    <a href="" class="login_help">회원가입</a>
                </div>
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