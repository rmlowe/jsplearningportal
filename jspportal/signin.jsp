<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="config.jsp" %>
<%
	String nonce = Long.toString(SecureRandom.getInstance("SHA1PRNG").nextLong());
	String callback = "http://localhost:8080/jspportal/authcallback.jsp";
	session.setAttribute("nonce", nonce);
	response
			.sendRedirect("http://utest2.netdimensions.com/utest/servlet/ekp/authenticate?nonce="
					+ URLEncoder.encode(nonce, "UTF-8")
					+ "&callback="
					+ URLEncoder.encode(callback, "UTF-8"));
%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>