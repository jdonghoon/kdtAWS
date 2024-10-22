<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.")
		location.href = "<%= request.getContextPath()%>/user/login.jsp";
	</script>
<%		
	} else {
		
		request.setCharacterEncoding("UTF-8");
		
		String searchType = request.getParameter("searchType");
		if(searchType == null || searchType.equals("")) {
			searchType = "";
		}
		
		String searchValue = request.getParameter("notice_text");
		if(searchValue == null || searchValue.equals("")) {
			searchValue = "";
		}
		
		int uno = 0;
		int nno = Integer.parseInt(request.getParameter("nno"));
		String title = "";
		String uid = "";
		String rdate = "";
		int hit = 0;
		String content = "";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PreparedStatement psmtHit = null;
		
		PreparedStatement psmtComment = null;
		ResultSet rsComment = null;
		
		int nowPage = 1;
		if(request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
			if( nowPage < 1 )
			{
				nowPage = 1;
			}
		}
		
		List<Comment> commentList = new ArrayList<Comment>();
		
		try {
			conn = DBConn.conn();
			
			String sqlHit = " UPDATE notice_board"
				     	  + " SET hit = hit + 1"
				     	  + " WHERE nno = ?";
			
			psmtHit = conn.prepareStatement(sqlHit);
			psmtHit.setInt(1, nno);
			
			psmtHit.executeUpdate();
			
			String sql = "SELECT u.uno"
					   + " , nno"
					   + " , title"
					   + " , uid"
				 	   + " , date_format(n.rdate, '%Y-%m-%d') as rdate"
					   + " , hit"
					   + " , content"
					   + " FROM notice_board n"
					   + " INNER JOIN user u"
					   + " ON n.uno = u.uno"
					   + " WHERE nno = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, nno);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				uno = rs.getInt("uno");
				title = rs.getString("title");
				uid = rs.getString("uid");
				rdate = rs.getString("rdate");
				hit = rs.getInt("hit");
				content = rs.getString("content");
			}
%>
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
			        <link href = "./view.css" type = "text/css" rel = "stylesheet">
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
			                <a href="<%=request.getContextPath()%>/user/mypage_info.jsp" id="loginmypage">mypage</a>
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
			                        <li><a href="<%=request.getContextPath()%>/FreeBoard/list.jsp" class="navmenu" >FreeBoard</a></li>
			                        <li><a href="list.jsp" class="navmenu" style="font-weight: bold;">Notice</a></li>
			                    </ul>
			                </div>
			            </nav>
			        </header>
			        <section>
			            <article> 
			                <div class="modifydelete_button">
			                	<form action="list.jsp" method="post">
			                        <button>목록으로</button>
			                    </form>
<%
								if(session.getAttribute("authorization").equals("E")) {
									if(session.getAttribute("no") != null && session.getAttribute("no").equals(uno)) {
%>
										<form action="modify.jsp?nno=<%= nno %>" method="post">
				                        	<button>수정</button>
				                    	</form>
<%									
									}

									if(session.getAttribute("no") != null && (session.getAttribute("no").equals(uno) || session.getAttribute("authorization").equals("E"))) {
%>
										<form action="deleteOk.jsp" method="post">
										<input type="hidden" name="nno" value="<%= nno %>">
						                	<button>삭제</button>
						                </form>
<%									
									}
								}
%>			                    
			                </div>
			                    <table>
			                        <tr>
			                            <th>제목</th>
			                            <td colspan="5"><%= title %></td>
			                        </tr>
			                        <tr class="second_line">
			                            <th>작성자</th>
			                            <td><div><%= uid %></div></td>
			                            <th>작성일</th>
			                            <td><div><%= rdate %></div></td>
			                            <th>조회수</th>
			                            <td style="text-align: center; padding: 0px;"><div><%= hit %></div></td>
			                        </tr>
			                        <tr>
			                            <th class="content">내용</th>
			                            <td colspan="5">
			                            	<%=content.replace("\n","<br>") %>
			                            </td>
			                        </tr>
			                    </table>
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
	<%			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(psmtHit, null);
			DBConn.close(rs, psmt, conn);
			DBConn.close(rsComment, psmtComment, null);
		}
	}
	%>
