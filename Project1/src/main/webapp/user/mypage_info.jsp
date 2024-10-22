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
	} else {
		request.setCharacterEncoding("UTF-8");
		
		int uno = (int)session.getAttribute("no");
		String id = "";
		String name = "";
		String email = "";
		int age = 0;
		String gender = "";
		String phone = "";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConn.conn();
			
			String sql = " SELECT uid"
					   + " , name"
					   + " , email"
					   + " , age"
					   + " , gender"
					   + " , phone"
					   + " FROM user"
					   + " WHERE uno = ?";
			
			psmt = conn.prepareStatement(sql);
			// session에 저장된 uno 값을 넣어 해당 uno의 데이터들을 불러옴
			psmt.setInt(1, uno);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("uid");
				name = rs.getString("name");
				email = rs.getString("email");
				age = rs.getInt("age");
				gender = rs.getString("gender");
				phone = rs.getString("phone");
%>
			<!DOCTYPE html>
			<html>
				<head>
					<meta charset="UTF-8">
					<title>StyleGuide</title>
					<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>
			        <link href = "mypage_info.css" type = "text/css" rel = "stylesheet">
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
			                <div class="mypage_title">MyPage</div>
			                <div class="mypage_tab">
			                        <button class="mypage_tab_area" onclick="location.href='mypage_info.jsp'">내 정보</button>
			                        <button class="mypage_tab_area" onclick="location.href='mypage_changepw.jsp'">비밀번호 변경</button>
			                </div>
			                <form action="login.jsp" method="post">
			                    <div class="mypage_text">아이디</div>
			                    <div>
			                        <input type="text" class="input_box" name="id" value="<%= id %>" disabled>
			                    </div>
			                    <div class="mypage_text">이름</div>
			                    <div>
			                        <input type="text" class="input_box" name="name" value="<%= name %>" disabled>
			                    </div>
			                    <div class="mypage_text">나이</div>
			                    <div>
			                        <input type="text" class="input_box" name="age" value="<%= age %>" disabled>
			                    </div>
			                    <div class="mypage_text">이메일</div>
			                    <div>
			                        <input type="email" class="input_box" name="email" value="<%= email %>" disabled>
			                    </div>
			                    <div class="mypage_text">성별</div>
			                    <div>
			                        <input type="text" class="input_box" name="gender" value="<%= gender %>" disabled>
			                    </div>
			                    <div class="mypage_text">휴대폰 번호</div>
			                    <div>
			                        <input type="text" class="input_box" name="phone" value="<%= phone %>" disabled>
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
			        </footer><title>StyleGuide</title>
				</head>
				<body>
				
				</body>
			</html>
<%				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
		}
	}
%>
