<%@ page import = "org.hibernate.SessionFactory" %>
<%@ page import = "org.hibernate.Query" %>
<%@ page import = "org.hibernate.Session" %>
<%@ page import = "org.hibernate.Transaction" %>
<%@ page import = "org.hibernate.cfg.Configuration" %>
<%@ page import = "Entity.User" %>
<%@ page import = "Entity.Book" %>
<%@ page import = "Entity.Cart" %>
<%@ page import = "Entity.Order" %>
<%@ page import = "Entity.Admin" %>
<%@ page import = "java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bookstore</title>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
	$('button').click(function(){
	    $.post("ajaxAction",
	    {
	      order_id:1,
	      user_id:2,
	      item_id:3,
	      numbers:4,
	      date:5
	    },
	    function(data,status){
	    	//$.getJSON("detail.action", function(res){alert(res);})
	        var book = eval(data);
	    	$("#bookname").text(book.bookname);
	        alert(book.bookname);
	        alert(book.price);
	        alert(book.category);
	        alert(book.detail);
	        //alert(book.bookname);
	    	alert("hello");
	    	alert("Data: " + data + "\nStatus: " + status);
	      });
	  });
	});
</script>
</head>
<body>
<button class="btn btn-primary ">save</button>
<h1 id="bookname"></h1>
</body>
</html>