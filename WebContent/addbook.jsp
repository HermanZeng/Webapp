<%@ page import = "org.hibernate.SessionFactory" %>
<%@ page import = "org.hibernate.Query" %>
<%@ page import = "org.hibernate.Session" %>
<%@ page import = "org.hibernate.Transaction" %>
<%@ page import = "org.hibernate.cfg.Configuration" %>
<%@ page import = "Entity.User" %>
<%@ page import = "Entity.Book" %>
<%@ page import = "Entity.Order" %>
<%@ page import = "Entity.Admin" %>
<%@ page import = "java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>bookstore</title>
<script src="/jquery-2.2.2.min.js"></script>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<%
String item_id = request.getParameter("item_id");
String bookname = request.getParameter("bookname");
String pr = request.getParameter("price");
int price = 0;
if(pr != null && pr != "")
{
	price = Integer.valueOf(pr).intValue();
}
out.println(item_id);
out.println(bookname);
out.println(price);
if(item_id != null && item_id != "" && bookname != null && bookname != "" && pr != null && pr != "")
{
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Book where item_id = :item_id");
		query.setParameter("item_id", item_id);
		Book book = (Book)query.uniqueResult();
		if (book == null)
		{
			book = new Book();
			book.setItem_id(item_id);
			book.setBookname(bookname);
			book.setPrice(price);
			sess.save(book);
		}
		tx.commit();
		sess.close();
	}
}
%>

<body>
	<div style="padding: 0px 600px 10px;" align="center">
    <h1>Add book</h1>
    <form class="bs-example bs-example-form" role = "form" method="post" >
        <br>
        <div class="input-group input-group-lg">
            <span class="input-group-addon">Item_id</span>
            <input type="text" class = "form-control" name="item_id" placeholder="item_id" >
        </div>
        <br>
        <div class="input-group input-group-lg">
            <span class="input-group-addon">Bookname</span>
            <input type="text" class = "form-control" name="bookname" placeholder="bookname" >
        </div>
        <br>
        <div class="input-group input-group-lg">
            <span class="input-group-addon">Price</span>
            <input type="text" class = "form-control" name="price" placeholder="price" >
        </div>
        <br><br>
        <input type="submit" class="btn btn-primary " name="submit" value="submit">
    </form>
</div>
</body>
</html>