<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그아웃 시 세션을 완전히 삭제
	session.invalidate();
	response.sendRedirect(request.getContextPath());
%>