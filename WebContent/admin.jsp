
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>bookstore</title>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
	$('button').filter('.btn-default').click(function(){
		var tr = $(this).parent().parent().parent().parent();
		var content = new Array();
		tds = tr.find("td");
        tds.each(function(){
            var td = $(this);
            //alert(td.text());
            content.push(td.text());
        });
        //alert(content);
	    $.post("#",
	    {
	      order_id:content[0],
	      user_id:content[1],
	      item_id:content[2],
	      numbers:content[3],
	      date:content[4]
	    });
	    window.location.reload();
	  });
	});
</script>
</head>

<%
String order_id_temp = request.getParameter("order_id");
String user_id = request.getParameter("user_id");
String item_id = request.getParameter("item_id");
String numbers_temp = request.getParameter("numbers");
String date = request.getParameter("date");
int order_id = 0, numbers = 0;
if(order_id_temp != null && order_id_temp != "")
	order_id = Integer.valueOf(order_id_temp).intValue();
if(numbers_temp != null && numbers_temp != "")
	numbers = Integer.valueOf(numbers_temp).intValue();
System.out.println(order_id);
System.out.println(user_id);
System.out.println(item_id);
System.out.println(numbers);
System.out.println(date);
if(order_id_temp != null && order_id_temp != "" && user_id != null && user_id != "" && item_id != null && item_id != ""  && numbers_temp != null && numbers_temp != ""  && date != null && date != "" )
{
	System.out.println("into");
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Order where id = :order_id");
		query.setParameter("order_id", order_id);
		Order order = (Order)query.uniqueResult();
		if (order != null)
		{
			System.out.println("not null");
			order.setUser_id(user_id);
			order.setItem_id(item_id);
			order.setNumbers(numbers);
			order.setDate(date);
		}
		sess.update(order);
		tx.commit();
		sess.close();
	}
}
%>

<%
String add_item_id, delete_item_id;
add_item_id = request.getParameter("item_add");
delete_item_id = request.getParameter("item_delete");
out.println(add_item_id);
if(add_item_id != null && add_item_id != "")
{
	
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Cart where user_id = :id and item_id = :item_id");
		query.setParameter("id", id);
		query.setParameter("item_id", add_item_id);
		Cart cart = (Cart)query.uniqueResult();
		if (cart == null)
		{
			cart = new Cart();
			cart.setUser_id(id);
			cart.setItem_id(add_item_id);
			cart.setNumbers(1);
			sess.save(cart);
		}
		else
		{
			int temp = cart.getNumbers() + 1;
			cart.setNumbers(temp);
			sess.update(cart);
		}
		tx.commit();
		sess.close();
	}
}
else 
{
	if(delete_item_id != null && delete_item_id != "")
	{
		HttpSession se = request.getSession();
		String id = (String)se.getAttribute("id");
		if(id != null)
		{
			SessionFactory sf = new Configuration().configure().buildSessionFactory();
			Session sess = sf.openSession();
			Transaction tx = sess.beginTransaction();
			Query qu = sess.createSQLQuery("delete from orders where id = '"+ delete_item_id+"'");
			qu.executeUpdate();
			tx.commit();
			sess.close();
			out.println(delete_item_id);
		}
	}	
}
%>

<%
String delete_user = request.getParameter("delete_user");
String delete_book = request.getParameter("delete_book");
String addorder = request.getParameter("addorder");
String addbook = request.getParameter("addbook");
String orders = request.getParameter("orders");
String users = request.getParameter("users");
String books = request.getParameter("books");
if(delete_user != null && delete_user != "")
{
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query qu = sess.createSQLQuery("delete from user where user_id = '"+ delete_user+"'");
		qu.executeUpdate();
		tx.commit();
		sess.close();
		out.println(delete_user);
	}
}	
if(delete_book != null && delete_book != "")
{
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		out.println("delete from book where item_id = '"+ delete_book+"'");
		Query qu = sess.createSQLQuery("delete from book where item_id = '"+ delete_book+"'");
		qu.executeUpdate();
		tx.commit();
		sess.close();
		out.println(delete_book);
	}
}	
if(addorder != null)
{
	HttpSession se = request.getSession();
	response.sendRedirect("addorder.jsp");
}
if(addbook != null)
{
	response.sendRedirect("addbook.jsp");
}
if(orders != null)
{
	response.sendRedirect("listorders.jsp");
}
if(users != null)
{
	response.sendRedirect("users.jsp");
}
if(books != null)
{
	response.sendRedirect("books.jsp");
}
%>
<body>
<center>

    <table class="table table-striped" contenteditable="true">
        <caption>orders</caption>
        <thead>
            <tr>
                <th>order_id</th>
                <th>user_id</th>
                <th>item_id</th>
                <th>numbers</th>
                <th>date</th>
                <th>delete</th>
            </tr>
        </thead>
            <tbody>
	<%
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Transaction tx2 = sess.beginTransaction();
		Query query = sess.createQuery("from Order");
		List<Order> orderlist= query.list();
		tx.commit(); 
		for(Order temp : orderlist )
		{
			out.println("<tr>");
			out.println("<td>"+temp.getId()+"</td>");
			out.println("<td>"+temp.getUser_id()+"</td>");
			out.println("<td>"+temp.getItem_id()+"</td>");
			out.println("<td>"+temp.getNumbers()+"</td>");
			out.println("<td>"+temp.getDate()+"</td>");
			out.println("<td>");
			out.println("<form method=\"post\">");
			out.println("<div class=\"btn-group\">");
			out.println("<button type=\"submit\" class=\"btn btn-default \" name=\"item_add\" value="+temp.getId()+">save</button>");
			out.println("<button type=\"submit\" class=\"btn btn-primary \" name=\"item_delete\" value="+temp.getId()+">delete</button>");
			out.println("</div>");
			out.println("</form>");
			out.println("</td>");
			out.println("<tr>");
			//out.println(temp.getItem_id() + " " + temp.getPrice());
		} 
		out.flush();
		sess.close();
	%>
	
	</tbody>
    </table>
    <div style="padding: 0px 600px 10px;" align="center">
        <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">Delete user</span>
                <input type="text" class = "form-control" name="delete_user" placeholder="book's item_id" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="add">
                        Delete
                    </button>
                </span>
            </div>
            </form>
            <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">Delete book</span>
                <input type="text" class = "form-control" name="delete_book" placeholder="book's item_id" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="delete">
                        Delete
                    </button>
                </span>
            </div>
        </form>
        <br>
        <form method="post">
            <div class="btn-group btn-group-lg">
            	<input type="submit" class="btn btn-primary " name="addorder" value="addorder">
                <input type="submit" class="btn btn-primary " name="addbook" value="addbook">
                <input type="submit" class="btn btn-primary " name="orders" value="orders">
                <input type="submit" class="btn btn-primary " name="users" value="users">
                <input type="submit" class="btn btn-primary " name="books" value="books">
            </div>
        </form>
    </div>
    </center>
</body>
</html>