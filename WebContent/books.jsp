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
<%@ page import = "java.lang.Integer" %>
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
	$('button').filter('.btn-primary').click(function(){
		var tr = $(this).parent().parent().parent();
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
	      item_id:content[0],
	      bookname:content[1],
	      price:content[2]
	    });
	    window.location.reload();
	  });
	});
</script>
</head>
<%
String item_id = request.getParameter("item_id");
String bookname = request.getParameter("bookname");
String price_temp = request.getParameter("price");
int price = 0;
if(price_temp != null && price_temp != "")
	price = Integer.valueOf(price_temp).intValue();

System.out.println(item_id);
System.out.println(bookname);
System.out.println(price);

if(item_id != null && item_id != "" && bookname != null && bookname != "" && price_temp != null && price_temp != "" )
{
	System.out.println("into");
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
		if (book != null)
		{
			System.out.println("not null");
			book.setBookname(bookname);
			book.setPrice(price);
		}
		sess.update(book);
		tx.commit();
		sess.close();
	}
}
%>

<%
String delete_book = request.getParameter("delete_book");
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
%>
<body>
<center>

    <table class="table table-striped" contenteditable="true">
        <caption>orders</caption>
        <thead>
            <tr>
                <th>item_id</th>
                <th>bookname</th>
                <th>price</th>
                <th>save</th>
            </tr>
        </thead>
            <tbody>
	<%
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		//Transaction tx2 = sess.beginTransaction();
		Query query = sess.createQuery("from Book");
		List<Book> booklist= query.list();
		tx.commit(); 
		for(Book temp : booklist )
		{
			out.println("<tr>");
			out.println("<td>"+temp.getItem_id()+"</td>");
			out.println("<td>"+temp.getBookname()+"</td>");
			out.println("<td>"+temp.getPrice()+"</td>");
			out.println("<td>");
			//out.println("<form method=\"post\">");
			out.println("<div class=\"btn-group\">");
			out.println("<button class=\"btn btn-primary \" name=\"item_add\" value="+temp.getItem_id()+">save</button>");
			//out.println("<button class=\"btn btn-primary \" name=\"item_delete\" value="+temp.getId()+">delete</button>");
			out.println("</div>");
			//out.println("</form>");
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
                <span class="input-group-addon">Delete book</span>
                <input type="text" class = "form-control" name="delete_book" placeholder="book's item_id" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="add">
                        Delete
                    </button>
                </span>
            </div>
            </form>
    </div>
    </center>
</body>
</html>