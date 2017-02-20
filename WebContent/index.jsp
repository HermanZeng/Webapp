<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ page import = "org.springframework.context.ApplicationContext" %>
<%@ page import = "org.springframework.context.support.ClassPathXmlApplicationContext" %>
<%@ page import = "testModel.entity" %> --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
response.sendRedirect("Logged.jsp");
%>
<body>
	<!-- <s:url action="hello" var="helloLink">
		<s:param name="userName">Bruce Phillips</s:param>
	</s:url> -->
	<p>
		<a href="<s:url action='hello'/>">Hello Bruce Phillips</a>
	</p>
	<s:form action="hello">

		<s:submit />

	</s:form>
	this is index.jsp
	
</body>
</html>