<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "org.hibernate.SessionFactory" %>
<%@ page import = "org.hibernate.Query" %>
<%@ page import = "org.hibernate.Session" %>
<%@ page import = "org.hibernate.Transaction" %>
<%@ page import = "org.hibernate.cfg.Configuration" %>
<%@ page import = "Entity.User" %>
<%@ page import = "Entity.Book" %>
<%@ page import = "Entity.Cart" %>
<%@ page import = "Entity.Admin" %>
<%@ page import = "java.util.List" %>
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
	$(document).ready(function() {
		$('td').click(function() {
			var txt = $(this).text();
			//alert(txt);
			$.post("ajaxAction", {
				item_id : txt
			}, function(data, status) {
				//$.getJSON("detail.action", function(res){alert(res);})
				var book = eval(data);
				$("#bookname").text(book.bookname);
				$("#price").text(book.price);
				$("#category").text(book.category);
				$("#detail").text(book.detail);
			});
		});
	});
</script>

</head>
<%
HttpSession s = request.getSession();
String admin = (String)s.getAttribute("id");
if(admin.equals("admin"))
	response.sendRedirect("admin.jsp");
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
// 		Cart cart = new Cart();
// 		cart.setId(id);
// 		cart.setItem_id(add_item_id);
// 		sess.save(cart);
		tx.commit();
		sess.close();
	}
	//tx.commit();
	/*SessionFactory sf = new Configuration().configure().buildSessionFactory();
	Session sess = sf.openSession();
	Transaction tx = sess.beginTransaction();
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	out.println(id +" " + add_item_id);
	Query qu = sess.createSQLQuery("insert into cart values("+id+", "+ add_item_id + ")");
	tx.commit();
	sess.close();*/
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
			Query qu = sess.createSQLQuery("delete from cart where user_id ='"+id+"' and item_id = '"+ delete_item_id+"'");
			qu.executeUpdate();
			tx.commit();
			sess.close();
			out.println(delete_item_id);
		}
	}	
}

/*else
{
	item_id = request.getParameter("item_delete");
	out.println(item_id);
	if(item_id != null)
	{
		HttpSession se = request.getSession();
		String id = (String)se.getAttribute("id");
		if(id != null)
		{
			Query qu = sess.createSQLQuery("delete from cart where id ="+id+" and item_id = "+ item_id);
			/*qu.setParameter("id", id);
			qu.setParameter("item_id", item_id);
		}
		out.println(item_id);
		tx.commit();
	}
}*/

%>

<%
String bkname = request.getParameter("bkname");
out.println(bkname+"he");
String tp1="", tp3="";
int tp2 = 0;
if(bkname != null && bkname != "")
{
	HttpSession hse = request.getSession();
	String id = (String)hse.getAttribute("id");
	out.println("hello");
	if(id != null)
	{
		out.println("loop");
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Book where bookname = :bookname");
		query.setParameter("bookname", bkname);
		Book bk = (Book)query.uniqueResult();
		if (bk != null)
		{
			out.println("loop again");
			tp1 = bk.getItem_id();
			tp2 = bk.getPrice();
			tp3=bk.getBookname();
		}
		tx.commit();
		sess.close();
	}
}
%>

<%
String logout = request.getParameter("logout");
String cart = request.getParameter("cart");
String order = request.getParameter("order");
if(logout != null)
{
	HttpSession se = request.getSession();
	se.invalidate();
	response.sendRedirect("index.html");
}
if(cart != null)
{
	response.sendRedirect("cart.jsp");
}
if(order != null)
{
	response.sendRedirect("order.jsp");
}
%>

<body>
<center>

    <table class="table table-striped" contenteditable="true">
        <caption>store</caption>
        <thead>
            <tr>
                <th>item_id</th>
                <th>bookname</th>
                <th>price</th>
                <th> to cart</th>
            </tr>
        </thead>
            <tbody>
	<%
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Transaction tx2 = sess.beginTransaction();
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
			out.println("<form method=\"post\">");
			out.println("<div class=\"btn-group\">");
			out.println("<button type=\"submit\" class=\"btn btn-primary \" name=\"item_add\" value="+temp.getItem_id()+">add</button>");
			out.println("<button type=\"submit\" class=\"btn btn-primary \" name=\"item_delete\" value="+temp.getItem_id()+">delete</button>");
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
                <span class="input-group-addon">Add to cart</span>
                <input type="text" class = "form-control" name="item_add" placeholder="book's item_id" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="add">
                        Add
                    </button>
                </span>
            </div>
            </form>
            <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">Delete from cart</span>
                <input type="text" class = "form-control" name="item_delete" placeholder="book's item_id" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="delete">
                        Delete
                    </button>
                </span>
            </div>
        </form>
        <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">Search book</span>
                <input type="text" class = "form-control" name="bkname" placeholder="book's name" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="bkname">
                        Search
                    </button>
                </span>
            </div>
        </form>
        <br>
        <form method="post">
            <div class="btn-group btn-group-lg">
            	<input type="submit" class="btn btn-primary " name="logout" value="log out">
                <input type="submit" class="btn btn-primary " name="cart" value="cart">
                <input type="submit" class="btn btn-primary " name="order" value="order">
            </div>
        </form>
    </div>
    <h1 id="bookname"><%out.println(tp1); %></h1>
    <h2 id="price"><%out.println(tp2); %></h2>
    <h2 id="category"><%out.println(tp3); %></h2>
    <h2 id="detail"></h2>
    
    </center>
</body>
</html>