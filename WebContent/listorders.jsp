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
<script src="/jquery-2.2.2.min.js"></script>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>



<body>
	<center>
		<table class="table table-striped">
			<caption>store</caption>
			<thead>
				<tr>
					<th>order_id</th>
					<th>user_id</th>
					<th>item_id</th>
					<th>bookname</th>
					<th>price</th>
					<th>numbers</th>
					<th>date</th>
					<th>sum</th>
				</tr>
			</thead>
			<tbody>
				<%
					String byyear = request.getParameter("byyear");
					String bymonth = request.getParameter("bymonth");
					String bydate = request.getParameter("bydate");
					String byuser = request.getParameter("byuser");
					String bybook = request.getParameter("bybook");
					out.println(byyear);
					out.println(bymonth);
					out.println(bydate);
					int sum = 0;
					if(byyear != null)
					{
						SessionFactory sf = new Configuration().configure().buildSessionFactory();
						Session sess = sf.openSession();
						Transaction tx = sess.beginTransaction();
						Query query = sess.createSQLQuery("SELECT * FROM book natural join orders where date like '%"+byyear+"%';");
						List<Object[]> lists= query.list();
						tx.commit(); 
						for(Object[] temp : lists )
						{
							out.println("<tr>");
							out.println("<td>"+temp[3]+"</td>");
							out.println("<td>"+temp[4]+"</td>");
							out.println("<td>"+temp[0]+"</td>");
							out.println("<td>"+temp[1]+"</td>");
							out.println("<td>"+temp[2]+"</td>");
							out.println("<td>"+temp[5]+"</td>");
							out.println("<td>"+temp[6]+"</td>");
							out.println("<td>");
							int total = (Integer)temp[2] * (Integer)temp[5];
							sum += total;
							out.println(total);
							out.println("</td>");
							out.println("<tr>");
							//out.println(temp.getItem_id() + " " + temp.getPrice());
						} 
						out.println("<h1>Sum:");
						out.println(sum);
						out.println("</h1>");
						out.flush();
						sess.close();
					}
					if(bymonth != null)
					{
						SessionFactory sf = new Configuration().configure().buildSessionFactory();
						Session sess = sf.openSession();
						Transaction tx = sess.beginTransaction();
						Query query = sess.createSQLQuery("SELECT * FROM book natural join orders where date like '%-"+bymonth+"-%';");
						List<Object[]> lists= query.list();
						tx.commit(); 
						for(Object[] temp : lists )
						{
							out.println("<tr>");
							out.println("<td>"+temp[3]+"</td>");
							out.println("<td>"+temp[4]+"</td>");
							out.println("<td>"+temp[0]+"</td>");
							out.println("<td>"+temp[1]+"</td>");
							out.println("<td>"+temp[2]+"</td>");
							out.println("<td>"+temp[5]+"</td>");
							out.println("<td>"+temp[6]+"</td>");
							out.println("<td>");
							int total = (Integer)temp[2] * (Integer)temp[5];
							sum += total;
							out.println(total);
							out.println("</td>");
							out.println("<tr>");
							//out.println(temp.getItem_id() + " " + temp.getPrice());
						} 
						out.println("<h1>Sum:");
						out.println(sum);
						out.println("</h1>");
						out.flush();
						sess.close();
					}
					if(bydate != null)
					{
						SessionFactory sf = new Configuration().configure().buildSessionFactory();
						Session sess = sf.openSession();
						Transaction tx = sess.beginTransaction();
						Query query = sess.createSQLQuery("SELECT * FROM book natural join orders where date like '%-"+bydate+"%';");
						List<Object[]> lists= query.list();
						tx.commit(); 
						for(Object[] temp : lists )
						{
							out.println("<tr>");
							out.println("<td>"+temp[3]+"</td>");
							out.println("<td>"+temp[4]+"</td>");
							out.println("<td>"+temp[0]+"</td>");
							out.println("<td>"+temp[1]+"</td>");
							out.println("<td>"+temp[2]+"</td>");
							out.println("<td>"+temp[5]+"</td>");
							out.println("<td>"+temp[6]+"</td>");
							out.println("<td>");
							int total = (Integer)temp[2] * (Integer)temp[5];
							sum += total;
							out.println(total);
							out.println("</td>");
							out.println("<tr>");
							//out.println(temp.getItem_id() + " " + temp.getPrice());
						} 
						out.println("<h1>Sum:");
						out.println(sum);
						out.println("</h1>");
						out.flush();
						sess.close();
					}
					if(byuser != null)
					{
						SessionFactory sf = new Configuration().configure().buildSessionFactory();
						Session sess = sf.openSession();
						Transaction tx = sess.beginTransaction();
						Query query = sess.createSQLQuery("SELECT * FROM book natural join orders order by user_id;");
						List<Object[]> lists= query.list();
						tx.commit(); 
						for(Object[] temp : lists )
						{
							out.println("<tr>");
							out.println("<td>"+temp[3]+"</td>");
							out.println("<td>"+temp[4]+"</td>");
							out.println("<td>"+temp[0]+"</td>");
							out.println("<td>"+temp[1]+"</td>");
							out.println("<td>"+temp[2]+"</td>");
							out.println("<td>"+temp[5]+"</td>");
							out.println("<td>"+temp[6]+"</td>");
							out.println("<td>");
							int total = (Integer)temp[2] * (Integer)temp[5];
							out.println(total);
							out.println("</td>");
							out.println("<tr>");
							//out.println(temp.getItem_id() + " " + temp.getPrice());
						} 
						out.flush();
						sess.close();
					}
					if(bybook != null)
					{
						SessionFactory sf = new Configuration().configure().buildSessionFactory();
						Session sess = sf.openSession();
						Transaction tx = sess.beginTransaction();
						Query query = sess.createSQLQuery("SELECT * FROM book natural join orders order by item_id;");
						List<Object[]> lists= query.list();
						tx.commit(); 
						for(Object[] temp : lists )
						{
							out.println("<tr>");
							out.println("<td>"+temp[3]+"</td>");
							out.println("<td>"+temp[4]+"</td>");
							out.println("<td>"+temp[0]+"</td>");
							out.println("<td>"+temp[1]+"</td>");
							out.println("<td>"+temp[2]+"</td>");
							out.println("<td>"+temp[5]+"</td>");
							out.println("<td>"+temp[6]+"</td>");
							out.println("<td>");
							int total = (Integer)temp[2] * (Integer)temp[5];
							out.println(total);
							out.println("</td>");
							out.println("<tr>");
							//out.println(temp.getItem_id() + " " + temp.getPrice());
						} 
						out.flush();
						sess.close();
					}
				%>
			</tbody>
		</table>

		<%
			if (byuser != null)
			{
				out.println("<table class=\"table table-striped\">");
				out.println("<caption>sales</caption>");
				out.println("<thead>");
				out.println("<tr>");
				out.println("<th>user_id</th>");
				out.println("<th>money_spent</th>");
				out.println("<th>number_of_books_bought</th>");
				out.println("</tr>");
				out.println("</thead>");
				out.println("<tbody>");
				SessionFactory sf = new Configuration().configure().buildSessionFactory();
				Session sess = sf.openSession();
				Transaction tx = sess.beginTransaction();
				Query query = sess.createSQLQuery("SELECT user_id,sum(numbers * price), sum(numbers) FROM user natural join orders natural join book group by user_id;");
				List<Object[]> lists= query.list();
				tx.commit(); 
				for(Object[] temp : lists )
				{
					out.println("<tr>");
					out.println("<td>"+temp[0]+"</td>");
					out.println("<td>"+temp[1]+"</td>");
					out.println("<td>"+temp[2]+"</td>");
					out.println("<tr>");
					//out.println(temp.getItem_id() + " " + temp.getPrice());
				} 
				out.flush();
				sess.close();
				out.println("</tbody>");
				out.println("</table>");
			}
		if (bybook != null)
		{
			out.println("<table class=\"table table-striped\">");
			out.println("<caption>sales</caption>");
			out.println("<thead>");
			out.println("<tr>");
			out.println("<th>item_id</th>");
			out.println("<th>bookname</th>");
			out.println("<th>total_sale</th>");
			out.println("<th>sale_quantity</th>");
			out.println("</tr>");
			out.println("</thead>");
			out.println("<tbody>");
			SessionFactory sf = new Configuration().configure().buildSessionFactory();
			Session sess = sf.openSession();
			Transaction tx = sess.beginTransaction();
			Query query = sess.createSQLQuery("SELECT item_id, bookname, sum(numbers * price), sum(numbers) FROM orders natural join book group by item_id;");
			List<Object[]> lists= query.list();
			tx.commit(); 
			for(Object[] temp : lists )
			{
				out.println("<tr>");
				out.println("<td>"+temp[0]+"</td>");
				out.println("<td>"+temp[1]+"</td>");
				out.println("<td>"+temp[2]+"</td>");
				out.println("<td>"+temp[3]+"</td>");
				out.println("<tr>");
				//out.println(temp.getItem_id() + " " + temp.getPrice());
			} 
			out.flush();
			sess.close();
			out.println("</tbody>");
			out.println("</table>");
		}
		%>

		<div style="padding: 0px 600px 10px;" align="center">
			<form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">By year</span>
                <input type="text" class = "form-control" name="byyear" placeholder="year" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="add">
                        View
                    </button>
                </span>
            </div>
            </form>
            <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">By month</span>
                <input type="text" class = "form-control" name="bymonth" placeholder="month" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="delete">
                        View
                    </button>
                </span>
            </div>
        </form>
        <form class="bs-example bs-example-form" role = "form" method="post">
            <div class="input-group input-group-lg">
                <span class="input-group-addon">By date</span>
                <input type="text" class = "form-control" name="bydate" placeholder="date" >
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" name="delete">
                        View
                    </button>
                </span>
            </div>
        </form>
        <br>
			<form method="post">
				<div class="btn-group btn-group-lg">
					<input type="submit" class="btn btn-primary " name="byuser" value="by user"> 
					<input type="submit" class="btn btn-primary " name="bybook" value="by book"> 
				</div>
			</form>
		</div>
	</center>
</body>
</html>