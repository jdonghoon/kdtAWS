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
		
		String searchValue = request.getParameter("myitem_text");
		if(searchValue == null || searchValue.equals("")) {
			searchValue = "";
		}
		
		int uno = 0;
		int mino = Integer.parseInt(request.getParameter("mino"));
		String title = "";
		String brand = "";
		String uid = "";
		String rdate = "";
		int hit = 0;
		String content = "";
		String newFile = "";
		String orgFile = "";
		int cCnt = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// 조회수를 업데이트 하기 위한 sql 작성
		PreparedStatement psmtHit = null;
		
		// 댓글을 적기 위한 sql 작성
		PreparedStatement psmtComment = null;
		ResultSet rsComment = null;
		
		// 댓글 페이징을 설정하기 위한 sql 작성
		PreparedStatement psmtCommentPaging = null;
		ResultSet rsCommentPaging = null;
		
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
			
			String sqlHit = " UPDATE myitem"
				     	  + " SET hit = hit + 1"
				     	  + " WHERE mino = ?";
			
			psmtHit = conn.prepareStatement(sqlHit);
			psmtHit.setInt(1, mino);
			
			psmtHit.executeUpdate();
			
			String sql = "SELECT u.uno"
					   + " , mino"
					   + " , title"
					   + " , brand"
					   + " , uid"
				 	   + " , date_format(i.rdate, '%Y-%m-%d') as rdate"
					   + " , hit"
					   + " , content"
					   + " , newfile"
					   + " , orgfile"
					   + " , (select count(*) from i_comment c where c.state = 'E' AND mino = ?) as cnt"
					   + " FROM myitem i"
					   + " INNER JOIN user u"
					   + " ON i.uno = u.uno"
					   + " WHERE mino = ?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, mino);
			psmt.setInt(2, mino);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				uno = rs.getInt("uno");
				title = rs.getString("title");
				brand = rs.getString("brand");
				uid = rs.getString("uid");
				rdate = rs.getString("rdate");
				hit = rs.getInt("hit");
				content = rs.getString("content");
				newFile = rs.getString("newfile");
				orgFile = rs.getString("orgfile");
				cCnt = rs.getInt("cnt");
			}
			
			String sqlCommentPaging = "SELECT count(*) AS total"
					 				+ " FROM i_comment c"
					 				+ " INNER JOIN myitem i"
				 					+ " ON c.mino = i.mino"
					 				+ " WHERE c.state = 'E'"
					 				+ " AND c.mino = ?";
			
			psmtCommentPaging = conn.prepareStatement(sqlCommentPaging);
			psmtCommentPaging.setInt(1, mino);
			
			rsCommentPaging = psmtCommentPaging.executeQuery();
			
			int total = 0; // 전체 게시글 개수
			if(rsCommentPaging.next()) {		
				total = rsCommentPaging.getInt("total");	
			}
			
			PagingUtil paging = new PagingUtil(nowPage, total, 5);
			
			String sqlComment = " SELECT uid"
							  + " , i.*"
							  + " FROM i_comment i"
							  + " INNER JOIN user u"
							  + " ON i.uno = u.uno"
							  + " WHERE mino = ?"
							  + " AND i.state = 'E'"
							  + " ORDER BY i.rdate desc"
							  + " LIMIT ?, ?" ;
			
			psmtComment = conn.prepareStatement(sqlComment);
			psmtComment.setInt(1, mino);
			psmtComment.setInt(2, paging.getStart());
			psmtComment.setInt(3, paging.getPerPage());
			
			rsComment = psmtComment.executeQuery();
			while(rsComment.next()){
				Comment comment = new Comment(rsComment.getInt("cno")
											 ,rsComment.getInt("mino")
											 ,rsComment.getInt("uno")
											 ,rsComment.getString("uid")
											 ,rsComment.getString("rdate")
											 ,rsComment.getString("content")
											 ,rsComment.getString("state")
											 );
				commentList.add(comment);
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
		                        <li><a href="list.jsp" class="navmenu" style="font-weight: bold;">MyItem</a></li>
		                        <li><a href="<%=request.getContextPath()%>/Market/list.jsp" class="navmenu">Market</a></li>
		                        <li><a href="<%=request.getContextPath()%>/FreeBoard/list.jsp" class="navmenu">FreeBoard</a></li>
		                        <li><a href="<%=request.getContextPath()%>/Notice/list.jsp" class="navmenu">Notice</a></li>
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
								if(session.getAttribute("no") != null && session.getAttribute("no").equals(uno)) {
%>
									<form action="modify.jsp?mino=<%= mino %>" method="post">
			                        	<button>수정</button>
			                    	</form>
<%									
								}

								if(session.getAttribute("no") != null && (session.getAttribute("no").equals(uno) || session.getAttribute("authorization").equals("E"))) {
%>
									<form action="deleteOk.jsp" method="post">
									<input type="hidden" name="mino" value="<%= mino %>">
					                	<button>삭제</button>
					                </form>
<%									
								}
%>			                    
			                </div>
			                    <table>
			                        <tr>
			                            <th>제목</th>
			                            <td colspan="5"><%= title %></td>
			                        </tr>
			                        <tr>
			                            <th>브랜드</th>
			                            <td colspan="5"><%= brand %></td>
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
			                            	<div><img src="<%=request.getContextPath()%>/upload/<%= newFile %>" width=500px;></div>
			                            	<%=content.replace("\n","<br>") %>
			                            </td>
			                        </tr>
			                        <tr>
			                            <th>첨부파일</th>
			                            <td colspan="5"><a href="<%=request.getContextPath()%>/upload/<%= newFile %>" download="<%= orgFile %>"><%= orgFile %></a></td>
			                        </tr>
			                    </table>
			                    <form name="commentForm" method="post">
			                        <div class="comment_write">
			                            <div>댓글 (<%= cCnt %>)</div>
			                            <input type="hidden" name="mino" value="<%= mino %>">
										<input type="hidden" name="cno">
			                            <input type="text" name="content" placeholder="댓글을 입력해 주세요.">
			                            <button type="button" onclick="submitComment();">등록</button>
			                        </div>
			                    </form>
			                    <script>
					            	let submitType = "insert";
					            	
					            	function submitComment() {
					            		let loginUno = '<%=session.getAttribute("no")%>';
					        			
					        			if(loginUno != 'null'){
					        				if(submitType == 'insert'){
					        					document.commentForm.action = "commentRegisterOk.jsp";
					        				}else if(submitType == 'update'){
					        					//수정
					        					document.commentForm.action 
					        					= "commentModifyOk.jsp"
					        				}
					        				
					        				document.commentForm.submit();
					        			}else{
					        				alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
					        			}
					            	}
					            </script>
<%
									for(Comment comment : commentList) {
%>
									<div class="comment_list">
			                            <div class="comment_list_first">
			                                <div class="comment_list_uid"><strong><%= comment.getUid() %></strong></div>
			                                <div class="comment_list_date"><%= comment.getRdate() %></div>
			                            </div>
			                            <div class="comment_list_content"><%= comment.getContent() %></div>
<%
										if(session.getAttribute("no")!= null && session.getAttribute("no").equals(comment.getUno())){
%>
										<div>
			                                <button class="comment_list_button" name="modifyComment"  onclick="modifyComment('<%=comment.getContent()%>', <%=comment.getCno()%>);">수정</button>			                                
		                                	<button class="comment_list_button" name="deleteComment" onclick="deleteComment(<%=comment.getCno()%>);">삭제</button>
			                            </div>
<%											
										}
%>			                            
			                        </div>
									<script>
									function modifyComment(content, cno) {
										submitType = "update";
										document.commentForm.content.value = content;
										document.commentForm.cno.value = cno;
					        			}
									
									function deleteComment(cno){
										document.commentDeleteForm.cno.value = cno;
										document.commentDeleteForm.submit();
									}
									</script>
<%										
									}
%>			                        	
		                        <div class="comment_paging">
			                        <div>
<%
										if(total == 0) {
%>						
											<strong>1</strong>
<%						
										} else {
											
											if(paging.getStartPage() > 1) {
%>		                
							                    <a href="<%=request.getContentType()%>/MyItem/view.jsp?mino=<%=mino%>&nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">이전</a>
<%							
											}
					
											for(int i = paging.getStartPage(); i <= paging.getEndPage(); i++) {
												if(i == nowPage) {
%>
													<strong><%= i %></strong>
<%								
												} else {
%>
													<a href="<%=request.getContextPath()%>/MyItem/view.jsp?mino=<%=mino%>&nowPage=<%= i %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= i %></a>
<%								
												}
											}
											
											if(paging.getEndPage() < paging.getLastPage()){
%>
												<a href="<%=request.getContextPath()%>/MyItem/view.jsp?mino=<%=mino%>&nowPage=<%=paging.getStartPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">다음</a>
<%														
									}
								}
%>
				                	</div>
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
            <form name="commentDeleteForm" action="commentDeleteOk.jsp" method="post">
				<input type="hidden" name="mino" value="<%= mino %>">
				<input type="hidden" name="cno" >	
			</form>
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
