<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.NodeList"%>

<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.Element"%>
<%
	String userId = (String) session.getAttribute("userid");
%>

<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.auth.AuthScope"%>
<%@page import="org.apache.http.auth.UsernamePasswordCredentials"%>
<%@page import="java.net.URLEncoder"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Portal</title>
</head>
<body>
<%
	if (userId == null) {
%>
<a href="signin.jsp">Sign In</a>
<%
	}
%>
<h1>Hello, <%=userId == null ? "Guest" : userId%>, Welcome To My
Portal!</h1>
<h2>Here Are Some Catalogs</h2>
<ul>
	<%
		Document catalog = DocumentBuilderFactory
				.newInstance()
				.newDocumentBuilder()
				.parse(
						"http://utest2.netdimensions.com/utest/api/catalog?id=*ROOT*");
		NodeList children = catalog.getElementsByTagName("child");
		for (int i = 0; i < children.getLength(); i++) {
			Element child = (Element) children.item(i);
	%>
	<li><%=child.getElementsByTagName("title").item(0)
								.getTextContent()%></li>
	<%
		}
	%>
</ul>
<%
if (userId != null) {
%>
<h2>Here Are Your Enrollments</h2>
<ul>
	<%
		DefaultHttpClient client = new DefaultHttpClient();
		client.getCredentialsProvider().setCredentials(
				AuthScope.ANY,
				new UsernamePasswordCredentials(adminUserName,
						adminPassword));
		Document history = DocumentBuilderFactory.newInstance()
				.newDocumentBuilder().parse(
						client.execute(
								new HttpGet(
										"http://utest2.netdimensions.com/utest/api/enrollments?userId="
												+ URLEncoder.encode(userId,
														"UTF-8")))
								.getEntity().getContent());
		NodeList records = history.getElementsByTagName("trainingRecord");
		for (int i = 0; i < records.getLength(); i++) {
			Element record = (Element) records.item(i);
			Element module = (Element) record.getElementsByTagName("learningModule").item(0);
		%>
		<li><%= module.getElementsByTagName("title").item(0).getTextContent() %></li>
		<%
		}
	%>
</ul>
<%
}
%>
</body>
</html>