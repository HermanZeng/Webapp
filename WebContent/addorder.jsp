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
String user_id = request.getParameter("user_id");
String n = request.getParameter("numbers");
int numbers = 0;
if(n != null && n != "")
{
	numbers = Integer.valueOf(n).intValue();
}
out.println(item_id);
out.println(user_id);
out.println(numbers);
if(item_id != null && item_id != "" && user_id != null && user_id != "" && n != null && n != "")
{
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Order where item_id = :item_id and user_id = :user_id");
		query.setParameter("item_id", item_id);
		query.setParameter("user_id", user_id);
		Order order = (Order)query.uniqueResult();
		if (order == null)
		{
			order = new Order();
			order.setItem_id(item_id);
			order.setUser_id(user_id);
			order.setNumbers(numbers);
			sess.save(order);
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
            <span class="input-group-addon">User_id</span>
            <input type="text" class = "form-control" name="user_id" placeholder="user_id" >
        </div>
        <br>
        <div class="input-group input-group-lg">
            <span class="input-group-addon">Item_id</span>
            <input type="text" class = "form-control" name="item_id" placeholder="item_id" >
        </div>
        <br>
        <div class="input-group input-group-lg">
            <span class="input-group-addon">Numbers</span>
            <input type="text" class = "form-control" name="numbers" placeholder="price" >
        </div>
        <br><br>
        <input type="submit" class="btn btn-primary " name="submit" value="submit">
    </form>
</div>
</body>
</html>