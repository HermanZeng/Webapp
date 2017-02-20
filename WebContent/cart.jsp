
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
<body>

<center>

    <table class="table table-striped">
        <caption>cart</caption>
        <thead>
            <tr>
                <th>id</th>
                <th>item_id</th>
                <th>bookname</th>
                <th>price</th>
                <th>numbers</th>
            </tr>
        </thead>
            <tbody>
	<%
		HttpSession se = request.getSession();
		String id = (String)se.getAttribute("id");
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createSQLQuery("select * from cart natural join book where user_id = :id");
		query.setParameter("id", id);
		List<Object[]> lists= query.list();
		//tx.commit(); 
		for(Object[] temp : lists )
		{
			out.println("<tr>");
			out.println("<td>"+temp[2]+"</td>");
			out.println("<td>"+temp[0]+"</td>");
			out.println("<td>"+temp[4]+"</td>");
			out.println("<td>"+temp[5]+"</td>");
			out.println("<td>"+temp[3]+"</td>");
			out.println("<tr>");
			//out.println(temp.getItem_id() + " " + temp.getPrice());
		} 
		String buy = request.getParameter("buy");
		if(buy != null)
		{
			for(Object[] temp : lists)
			{
				out.println(temp[2]);
				out.println(temp[0]);
				out.println(temp[3]);
				String item_id = (String)temp[0];
				int numbers = (Integer)temp[3];
				Query q = sess.createQuery("from Order where user_id = :id and item_id = :item_id");
				q.setParameter("id", id);
				q.setParameter("item_id", item_id);
				Order order = (Order)q.uniqueResult();
				if(order == null)
				{
					order = new Order();
					order.setUser_id(id);
					order.setItem_id(item_id);
					order.setNumbers(numbers);
					sess.save(order);
				}
				else
				{
					int tmp = order.getNumbers();
					tmp = tmp + numbers;
					order.setNumbers(tmp);
					sess.update(order);
				}
				Query qu = sess.createSQLQuery("delete from cart where user_id ='"+id+"' and item_id = '"+ item_id+"'");
				qu.executeUpdate();
				// out.println("insert into orders values(\'"+temp[1]+"\', \'"+temp[0]+"\')");
				// Query q = sess.createSQLQuery("insert into orders values(\'"+temp[1]+"\', \'"+temp[0]+"\')");
				// q.executeUpdate();
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
    <div style="padding: 0px 600px 10px;" align="center">
        <form method="post">
            <div class="btn-group btn-group-lg">
                <input type="submit" class="btn btn-primary " name="buy" value="buy">
            </div>
        </form>
    </div>
    </center>
</body>
</html>