<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("no") == null || session.getAttribute("no").equals("")) {
%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
		location.href = "<%=request.getContextPath()%>/user/login.jsp";
	</script>
<%		
	} else {
		
		String searchType = request.getParameter("searchType");
		if(searchType == null || searchType.equals("")) {
			searchType = "";
		}
		
		String searchValue = request.getParameter("notice_text");
		if(searchValue == null || searchValue.equals("")) {
			searchValue = "";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PreparedStatement psmtPaging = null;
		ResultSet rsPaging = null;
		
		int nowPage = 1;
		if(request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
			if( nowPage < 1 )
			{
				nowPage = 1;
			}
		}
		
		int nno = 0;
		String title = null;
		String uid = null;
		String content = null;
		String rdate = null;
		int hit = 0;
		
		try {
			conn = DBConn.conn();
			
			String sqlPaging = "SELECT count(*) AS total"
					 + " FROM notice_board n"
					 + " INNER JOIN user u"
					 + " ON n.uno = u.uno"
					 + " WHERE n.state = 'E'";
	
			if(!searchType.equals("")) {
				if(searchType.equals("name")) {
					sqlPaging += " AND name like CONCAT('%', ?, '%')";
				} else if (searchType.equals("title")) {
					sqlPaging += " AND title like CONCAT('%', ?, '%')";
				} else if (searchType.equals("content")) {
					sqlPaging += " AND content like CONCAT('%', ?, '%')";
				}
			}
			
			psmtPaging = conn.prepareStatement(sqlPaging);
			
			if(!searchType.equals("")) {
					psmtPaging.setString(1, searchValue);
			}
			
			rsPaging = psmtPaging.executeQuery();
			
			int total = 0; // 전체 게시글 개수
			if(rsPaging.next()) {		
				total = rsPaging.getInt("total");	
			}
			
			PagingUtil paging = new PagingUtil(nowPage, total, 10);
			
			String sql = " SELECT nno"
			   + " , title"
			   + " , uid"
			   + " , content"
			   + " , date_format(n.rdate, '%Y-%m-%d') as rdate"
			   + " , hit"
			   + " FROM notice_board n"
			   + " INNER JOIN user u"
			   + " ON n.uno = u.uno"
			   + " WHERE n.state = 'E'";
	
			if(!searchType.equals("")) {
				if(searchType.equals("name")) {
					sql += " AND name like CONCAT('%', ?, '%')";
				} else if (searchType.equals("title")) {
					sql += " AND title like CONCAT('%', ?, '%')";
				} else if (searchType.equals("content")) {
					sql += " AND content like CONCAT('%', ?, '%')";
				}
			}
			
			sql += " ORDER BY rdate desc";
			sql += " LIMIT ?, ?";
			
			psmt = conn.prepareStatement(sql);

			if(!searchType.equals("")) {
				if(searchType.equals("name")) {
					psmt.setString(1, searchValue);
					psmt.setInt(2,paging.getStart());
					psmt.setInt(3,paging.getPerPage());
				} else if (searchType.equals("title")) {
					psmt.setString(1, searchValue);
					psmt.setInt(2,paging.getStart());
					psmt.setInt(3,paging.getPerPage());
				} else if (searchType.equals("content")) {
					psmt.setString(1, searchValue);
					psmt.setInt(2,paging.getStart());
					psmt.setInt(3,paging.getPerPage());
				}
			} else {
				psmt.setInt(1,paging.getStart());
				psmt.setInt(2,paging.getPerPage());
			}
			
			rs = psmt.executeQuery();
			
			%>
			<!DOCTYPE html>
				<script>
			       	function logout() {
			       		alert("로그아웃 되었습니다.");
			       	}
				</script>
				<head>
			        <meta charset="UTF-8">
			        <title>StyleGuide</title>
			        <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>
			        <link href = "./list.css" type = "text/css" rel = "stylesheet">
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
			                        <li><a href="<%=request.getContextPath()%>/MyItem/list.jsp" class="navmenu" >MyItem</a></li>
			                        <li><a href="<%=request.getContextPath()%>/Market/list.jsp" class="navmenu">Market</a></li>
			                        <li><a href="<%=request.getContextPath()%>/FreeBoard/list.jsp" class="navmenu">FreeBoard</a></li>
			                        <li><a href="list.jsp" class="navmenu" style="font-weight: bold;">Notice</a></li>
			                    </ul>
			                </div>
			            </nav>
			        </header>
			        <section>
			            <article>
			                <div class="list_title">
			                    Notice list
			                </div>
			                <div class="search_notice">
			                    <form action="<%=request.getContextPath()%>/Notice/list.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue %>" method="get">
			                        <select name="searchType">
			                            <option value="name" <%= searchType.equals("name") ? "selected" : "" %>>작성자</option>
			                            <option value="title" <%= searchType.equals("title") ? "selected" : "" %>>제목</option>
			                            <option value="content" <%= searchType.equals("content") ? "selected" : "" %>>내용</option>
		                        	</select>
			                        <input type="text" name="notice_text" value="<%=searchValue%>">
			                        <button>검 색</button>
			                    </form>
			                </div>
			                <%
			                	if(session.getAttribute("authorization").equals("E")) {
							%>			                		
				                <form action="<%=request.getContextPath()%>/Notice/register.jsp" method="post">
				                    <div class="notice_write">
				                        <button type="submit" >글쓰기</button>
				                    </div>
				                </form>
			                <%
			                	}
			                %>
			                <ul class="list_head">
			                    <li class="head_no"><div>번호</div></li>
			                    <li class="head_title"><div>제목</div></li>
			                    <li class="head_writer"><div>작성자</div></li>
			                    <li class="head_rdate"><div>작성일</div></li>
			                    <li class="head_hit"><div>조회수</div></li>
		                	</ul>
                		<%
	            			int count = 0;
							if(total == 0) {
						%>
							<div class="notice_none">게시글이 없습니다.</div>
						<%						
							} else {
			                	while(rs.next()) {
			                		count++;
			                		nno = rs.getInt("nno");
			                		title = rs.getString("title");
			                		uid = rs.getString("uid");
			                		content = rs.getString("content");
			                		rdate = rs.getString("rdate");
			                		hit = rs.getInt("hit");
			                %>
			                	<ul class="notice_list">
				                    <li class="no"><div style="width: 50px;"><%= (paging.getNowPage() > 1) ? ((paging.getNowPage()-1)*10) + count : count %></div></li>
				                    <li class="title">
				                    	<a href="<%=request.getContextPath()%>/Notice/view.jsp?nno=<%= nno %>">
				                    		<div><%= title %></div>
				                    	</a>
				                    </li>
				                    <li class="uid"><div style="width: 100px;"><%= uid %></div></li>
				                    <li class="rdate"><div><%= rdate %></div></li>
				                    <li class="hit"><div><%= hit %></div></li>
				                </ul>
			                <%		
			                	}
							}
			                %>
			                <div class="list_paging">
			                <%
								if(total == 0) {
							%>						
									<strong>1</strong>
							<%						
								} else {
									
									if(paging.getStartPage() > 1) {
							%>		                
					                    <a href="<%=request.getContentType()%>/Notice/list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">이전</a>
							<%							
									}
			
									for(int i = paging.getStartPage(); i <= paging.getEndPage(); i++) {
										if(i == nowPage) {
							%>
											<strong><%= i %></strong>
							<%								
										} else {
							%>
											<a href="<%=request.getContextPath()%>/Notice/list.jsp?nowPage=<%= i %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= i %></a>
							<%								
										}
									}
			
									if(paging.getEndPage() < paging.getLastPage()){
							%>
										<a href="<%=request.getContextPath()%>/Notice/list.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">다음</a>
							<%														
									}
								}
							%>
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
			<%			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close(rs, psmt, conn);
		}
	}
%>
