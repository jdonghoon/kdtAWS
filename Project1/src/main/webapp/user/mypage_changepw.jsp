<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
		location.href = "login.jsp";
	</script>
<%
	}
%>
<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <title>StyleGuide</title>
        <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>
        <link href = "mypage_changepw.css" type = "text/css" rel = "stylesheet">
    </head>
    <body>
    <script>

		function logout() {
			alert("로그아웃 되었습니다.");
		}

	    function pwCheck() {
			let pw = $("input[name=password]").val().trim();
			
			if(pw == "") {
				$(".msg:eq(0)").html("<span style='color: red'>현재 사용 중인 비밀번호를 입력해주세요.</span>");
				return false;
			}
			
			$.ajax({
				// checkPW에서 값을 받아 패스워드 일치여부 체크
				url : "<%=request.getContextPath()%>/data/checkPW.jsp",
				type : "POST",
				data : "password=" + pw,
				success : function(data) {
					if(data.trim() == "isPw") {
						$(".msg:eq(0)").html("");
						return false;
					} else {
						$(".msg:eq(0)").html("<span style='color: red'>일치하지 않는 비밀번호입니다. 다시 입력해주세요.</span>");
						return false;
					}
				}
			});
		}
	    
	    function changePwCheck_1st() {
	    	let changePw = $("input[name=changePw]").val().trim();
			let msg = $(".msg:eq(1)");
			
			if(changePw == "") {
				msg.html("<span style='color: red'>변경할 비밀번호를 입력해주세요.</span>");
				return false;
			} else if(changePw.length < 5) {
				msg.html("<span style='color: red'>비밀번호는 5글자 이상 입력해주세요.</span>");
				return false;
			} else {
				msg.html("");
				return true;
			}
		}
	    
	    function changePwcCheck_2nd() {
			let changePw = $("input[name=changePw]").val().trim();
			let changePwc = $("input[name=changePwCheck]").val().trim();
			let msg = $(".msg:eq(2)");
			
			if(changePwc == "") {
				msg.html("<span style='color: red'>변경할 비밀번호를 다시 입력해주세요.</span>");
				return false;
			} else if(changePw != changePwc) {
				msg.html("<span style='color: red'>변경할 비밀번호가 일치하지 않습니다.</span>");
				return false;
			} else {
				msg.html("");
				return true;
			}
		}
	    
	    function doChange() {
			if(pwCheck() == false) {
		          return false;
		    }
			
		    if(changePwCheck() == false) {
		          return false;
		    }
		    
		    if(changePwcCheck_2nd() == false) {
		          return false;
		    }
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
                <a href="mypage_info.jsp" id="loginmypage">mypage</a>
                <a href="<%=request.getContextPath()%>/user/logout.jsp" id="joinlogout" onclick="logout();">logout</a>
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
                <div class="mypage_title">비밀번호 변경</div>
                <div class="mypage_tab">
                        <button class="mypage_tab_area" onclick="location.href='mypage_info.jsp'">내 정보</button>
                        <button class="mypage_tab_area" onclick="location.href='mypage_changepw.jsp'">비밀번호 변경</button>
                </div>
                <form action="mypage_changepwOk.jsp" method="post" onsubmit="doChange();">
                    <div class="mypage_text">현재 비밀번호</div>
                    <div>
                        <input type="password" class="input_box" name="password" onblur="pwCheck();">
                        <div class="msg"></div>
                    </div>
                    <div class="mypage_text">변경할 비밀번호</div>
                    <div>
                        <input type="password" class="input_box" name="changePw" onblur="changePwCheck_1st();">
                        <div class="msg"></div>
                    </div>
                    <div class="mypage_text">변경할 비밀번호 확인</div>
                    <div>
                        <input type="password" class="input_box" name="changePwCheck" onblur="changePwcCheck_2nd();">
                        <div class="msg"></div>
                    </div>
                    <button class="changepw_button">저장하기</button>
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