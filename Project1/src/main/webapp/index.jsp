<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="project.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	/* 각 메뉴별 조회수가 높은 글 순서대로 보여주기 위한
	   DB 연결 및 SQL 실행문 작성, 실행 */
	Connection conn = null;
	PreparedStatement iPsmt = null;
	ResultSet iRs = null;
	
	PreparedStatement mPsmt = null;
	ResultSet mRs = null;
	
	PreparedStatement fPsmt = null;
	ResultSet fRs = null;
	
	PreparedStatement nPsmt = null;
	ResultSet nRs = null;
	
	String iTitle = "";
	int mino = 0;
	
	String mTitle = "";
	int mno = 0;
	
	String fTitle = "";
	int fno = 0;
	
	String nTitle = "";
	int nno = 0;
	
	// 제목, 글번호를 조회수 내림차순으로 조회 (1 ~ 5순위)
	try {
		conn = DBConn.conn();
		
		String iSql = "SELECT title"
					+ " , mino"
					+ " FROM myitem"
					+ " WHERE state = 'E'"
					+ " ORDER BY hit desc"
					+ " LIMIT 0, 5";
		
		iPsmt = conn.prepareStatement(iSql);
		iRs = iPsmt.executeQuery();
		
		String mSql = "SELECT title"
					+ " , mno"
					+ " FROM market"
					+ " WHERE state = 'E'"
					+ " ORDER BY hit desc"
					+ " LIMIT 0, 5";
		
		mPsmt = conn.prepareStatement(mSql);
		mRs = mPsmt.executeQuery();
		
		String fSql = "SELECT title"
					+ ", fno"
					+ " FROM free_board"
					+ " WHERE state = 'E'"
					+ " ORDER BY hit desc"
					+ " LIMIT 0, 5";
		
		fPsmt = conn.prepareStatement(fSql);
		fRs = fPsmt.executeQuery();
		
		String nSql = "SELECT title"
					+ " , nno"
					+ " FROM notice_board"
					+ " WHERE state = 'E'"
					+ " ORDER BY hit desc"
					+ " LIMIT 0, 5";
		
		nPsmt = conn.prepareStatement(nSql);
		nRs = nPsmt.executeQuery();

		%>
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="UTF-8">
				<title>StyleGuide</title>
			<link href = "index.css" type = "text/css" rel = "stylesheet">
			</head>
			<body>
				<script>
		        	function logout() {
		        		alert("로그아웃 되었습니다.");
		        	}
		        	
		        	function login() {
		        		alert("로그인이 필요합니다.");
		        	}
		        </script>
			     <header>
			        <div class="lijnmplo">
			        <%
			        	// 로그인 여부에 따라 a태그 내용 변경 (id로 체크) 
			        	if(session.getAttribute("id") != null) {
			        		String id = (String)session.getAttribute("id");
			        %>
			        	<strong style="margin-right: 15px; color: grey;"><%= id %></strong>
			        	<a href="<%=request.getContextPath()%>/user/mypage_info.jsp" id="loginmypage">mypage</a>
			            <a href="<%=request.getContextPath()%>/user/logout.jsp" id="joinlogout" onclick="logout();">logout</a>
			        <%
			        	} else {
			        %>
			        	<a href="<%=request.getContextPath()%>/user/login.jsp" id="loginmypage">login</a>
			            <a href="<%=request.getContextPath()%>/user/join.jsp" id="joinlogout">join</a>
			        <%		
			        	}
			        %>
			        </div>
			        <div class="logo">
			            <a href="index.jsp"><img src="<%=request.getContextPath()%>/logo/logo.PNG" width="150px"></a>
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
						<div class="container_first">
							<article>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box_title"> MyItem </div>
				                </div>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box">인기글</div>
				                </div>
				                <ul class="MyItem_list">
				            	<%
				            	/* 반복문이 돌 때마다 count를 1씩 증가시킴
				            	   로그인 여부에 따라 이동되는 페이지 변경
				            	   ** 보완 : 로그인 시 이전 페이지로 이동하게 되는 기능 추가 필요*/
				            	int iCount = 0;
				             	while(iRs.next()) {
				             		iCount++;
				             		
				             		iTitle = iRs.getString("title");
				             		mino = iRs.getInt("mino");
				           	 	%>
				             		<li class="MyItem_rank">
				             			<span style="color: orange; font-weight: bold">[<%= iCount %>]</span>
				             			<%
				             				if(session.getAttribute("no") != null) {
				             			%>
				             					<a href="<%=request.getContextPath()%>/MyItem/view.jsp?mino=<%=mino%>"><%= iTitle %></a>
				             			<%
				             				} else {
				             			%>
				             					<a href="<%=request.getContextPath()%>/user/login.jsp" onclick="login();"><%= iTitle %></a>
				             			<%		
				             				}
				             			%>
				             		</li>
								<%	        		
						        	}
						        %>
				                </ul>
			           		</article>
			           		<article>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box_title"> Market </div>
				                </div>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box">인기글</div>
				                </div>
				                <ul class="MyItem_list">
				            	<%
				            	int mCount = 0;
				             	while(mRs.next()) {
				             		mCount++;
				             		
				             		mTitle = mRs.getString("title");
				             		mno = mRs.getInt("mno");
				           	 	%>
				             		<li class="MyItem_rank">
				             			<span style="color: orange; font-weight: bold">[<%= mCount %>]</span>
				             			<%
				             				if(session.getAttribute("no") != null) {
				             			%>
				             					<a href="<%=request.getContextPath()%>/Market/view.jsp?mno=<%=mno%>"><%= mTitle %></a>
				             			<%
				             				} else {
				             			%>
				             					<a href="<%=request.getContextPath()%>/user/login.jsp" onclick="login();"><%= mTitle %></a>
				             			<%		
				             				}
				             			%>
				             		</li>
								<%	        		
						        	}
						        %>
				                </ul>
			           		</article>
		           		</div>
		           		<div class="container_first">
			           		<article>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box_title"> FreeBoard </div>
				                </div>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box">인기글</div>
				                </div>
				                <ul class="MyItem_list">
				            	<%
			             		int fCount = 0;
				             	while(fRs.next()) {
				             		fCount++;
				             		
				             		fTitle = fRs.getString("title");
				             		fno = fRs.getInt("fno");
				           	 	%>
				             		<li class="MyItem_rank">
				             			<span style="color: orange; font-weight: bold">[<%= fCount %>]</span>
				             			<%
				             				if(session.getAttribute("no") != null) {
				             			%>
				             					<a href="<%=request.getContextPath()%>/FreeBoard/view.jsp?fno=<%=fno%>"><%= fTitle %></a>
		             					<%
				             				} else {
				             			%>
				             					<a href="<%=request.getContextPath()%>/user/login.jsp" onclick="login();"><%= fTitle %></a>
				             			<%		
				             				}
				             			%>
				             		</li>
								<%	        		
						        	}
						        %>
				                </ul>
			           		</article>
			           		<article>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box_title"> Notice </div>
				                </div>
				                <div class="MyItem_box_line">
				                    <div class="MyItem_box">인기글</div>
				                </div>
				                <ul class="MyItem_list">
				            	<%
				            	int nCount = 0;
				             	while(nRs.next()) {
				             		nCount++;
				             		
				             		nTitle = nRs.getString("title");
				             		nno = nRs.getInt("nno");
				           	 	%>
				             		<li class="MyItem_rank">
				             			<span style="color: orange; font-weight: bold">[<%= nCount %>]</span>
				             			<%
				             				if(session.getAttribute("no") != null) {
				             			%>
				             					<a href="<%=request.getContextPath()%>/Notice/view.jsp?nno=<%=nno%>"><%= nTitle %></a>
				             			<%
				             				} else {
				             			%>
				             					<a href="<%=request.getContextPath()%>/user/login.jsp" onclick="login();"><%= nTitle %></a>
				             			<%		
				             				}
				             			%>
				             		</li>
								<%	        		
						        	}
						        %>
				                </ul>
			           		</article>
				        </div>
			    </section>
			    <footer>
			        <div class="footer_first">
			            <a href="" class="footer_list">이용약관</a>
			            <a href="" class="footer_list">사업자정보확인</a>
			            <a href="" class="footer_list">고객센터</a>
			        </div>
			        <div class="footer_second">
			            <div>Styleguide | 대표이사 : 전동훈</div>
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
		DBConn.close(iRs, iPsmt, conn);
	}
	%>
	