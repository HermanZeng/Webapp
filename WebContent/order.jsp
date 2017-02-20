<%@ page import = "org.hibernate.SessionFactory" %>
<%@ page import = "org.hibernate.Query" %>
<%@ page import = "org.hibernate.Session" %>
<%@ page import = "org.hibernate.Transaction" %>
<%@ page import = "org.hibernate.cfg.Configuration" %>
<%@ page import = "Entity.User" %>
<%@ page import = "Entity.Book" %>
<%@ page import = "Entity.Cart" %>
<%@ page import = "Entity.Order" %>
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
String delete_item_id = request.getParameter("item_delete");
if(delete_item_id != null && delete_item_id != "")
{
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query qu = sess.createSQLQuery("delete from orders where id ="+id+" and item_id = "+ delete_item_id);
		qu.executeUpdate();
		tx.commit();
		sess.close();
		out.println(delete_item_id);
	}
}	
%>
<body>
<center>

    <table class="table table-striped">
        <caption>cart</caption>
        <thead>
            <tr>
                <th>ID</th>
                <th>name</th>
                <th>gender</th>
                <th>phone</th>
                <th>email</th>
                <th>address</th>
                <th>item_id</th>
                <th>bookname</th>
                <th>price</th>
                <th>numbers</th>
                <th>date</th>
            </tr>
        </thead>
            <tbody>
	<%
		HttpSession se = request.getSession();
		String id = (String)se.getAttribute("id");
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		out.println("select * from user natural join (orders natural join book) where user_id = "+id);
		Query query = sess.createSQLQuery("select * from user natural join (orders natural join book) where user_id = '"+id+"'");
		//query.setParameter("id", id);
		List<Object[]> lists= query.list();
		//tx.commit(); 
		int total = 0;
		for(Object[] temp : lists )
		{
			out.println("<tr>");
			out.println("<td>"+temp[0]+"</td>");
			out.println("<td>"+temp[1]+"</td>");
			out.println("<td>"+temp[3]+"</td>");
			out.println("<td>"+temp[4]+"</td>");
			out.println("<td>"+temp[5]+"</td>");
			out.println("<td>"+temp[6]+"</td>");
			out.println("<td>"+temp[7]+"</td>");
			out.println("<td>"+temp[11]+"</td>");
			out.println("<td>"+temp[12]+"</td>");
			out.println("<td>"+temp[9]+"</td>");
			out.println("<td>"+temp[10]+"</td>");
			out.println("<tr>");
			total += (Integer)temp[12] * (Integer)temp[9];
			//out.println(temp.getItem_id() + " " + temp.getPrice());
		} 
		String buy = request.getParameter("buy");
		if(buy != null)
		{
			for(Object[] temp : lists)
			{
				out.println(temp[0]);
				out.println(temp[1]);
				//out.println("insert into orders values(\'"+temp[1]+"\', \'"+temp[0]+"\')");
				Query q = sess.createSQLQuery("insert into orders values(\'"+temp[1]+"\', \'"+temp[0]+"\')");
				q.executeUpdate();
				/* Order order = new Order();
				order.setId((String)temp[1]);
				order.setItem_id((String)temp[0]);
				sess.save(order);*/
			}
		}
		tx.commit();
		out.flush();
		sess.close();
	%>
	
	</tbody>
    </table>
    <h1>Total: <%= total %></h1>
    <div style="padding: 0px 600px 10px;" align="center">
        <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">Delete from orders</span>
                <input type="text" class = "form-control" name="item_delete" placeholder="book's item_id" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="delete">
                        Delete
                    </button>
                </span>
            </div>
        </form>
    </div>
    </center>
</body>
</html>