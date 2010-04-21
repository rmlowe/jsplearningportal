
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ include file="config.jsp" %>
<%
  String userId = request.getParameter("userId");
  String sigBaseStr = userId + authKey + session.getAttribute("nonce");
  
  if (request.getParameter("sig").equals(DigestUtils.md5Hex(sigBaseStr))) {
	  session.setAttribute("userid", userId);
	  response.sendRedirect("index.jsp");
  } else {
%>
	<h1>Begone, hacker!</h1>
<%
  }
%>
