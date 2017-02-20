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
	      user_id:content[0],
	      username:content[1],
	      password:content[2],
	      gender:content[3],
	      phone:content[4],
	      email:content[5],
	      address:content[6]
	    });
	    window.location.reload();
	  });
	});
</script>
</head>
<%
String user_id = request.getParameter("user_id");
String username = request.getParameter("username");
String password = request.getParameter("password");
String gender = request.getParameter("gender");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String address = request.getParameter("address");
System.out.println(password);
System.out.println(address);
if(user_id != null && user_id != "" && username != null && username != "" && password != null && password != "" && gender != null && gender != "" && phone != null && phone != "" && email != null && email != "" && address != null && address != "")
{
	HttpSession se = request.getSession();
	String id = (String)se.getAttribute("id");
	if(id != null)
	{
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from User where id = :user_id");
		query.setParameter("user_id", user_id);
		User user = (User)query.uniqueResult();
		if (user != null)
		{
			System.out.println("not null");
			user.setUsername(username);
			user.setPassword(password);
			user.setGender(gender);
			user.setPhone(phone);
			user.setEmail(email);
			user.setAddress(address);
		}
		sess.update(user);
		tx.commit();
		sess.close();
	}
}
%>

<%
String delete_user = request.getParameter("delete_user");
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

%>
<body>
<center>

    <table class="table table-striped" contenteditable="true">
        <caption>orders</caption>
        <thead>
            <tr>
                <th>user_id</th>
                <th>username</th>
                <th>password</th>
                <th>gender</th>
                <th>phone</th>
                <th>email</th>
                <th>address</th>
                <th>delete</th>
            </tr>
        </thead>
            <tbody>
	<%
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		//Transaction tx2 = sess.beginTransaction();
		Query query = sess.createQuery("from User");
		List<User> userlist= query.list();
		tx.commit(); 
		for(User temp : userlist )
		{
			out.println("<tr>");
			out.println("<td>"+temp.getId()+"</td>");
			out.println("<td>"+temp.getUsername()+"</td>");
			out.println("<td>"+temp.getPassword()+"</td>");
			out.println("<td>"+temp.getGender()+"</td>");
			out.println("<td>"+temp.getPhone()+"</td>");
			out.println("<td>"+temp.getEmail()+"</td>");
			out.println("<td>"+temp.getAddress()+"</td>");
			out.println("<td>");
			//out.println("<form method=\"post\">");
			out.println("<div class=\"btn-group\">");
			out.println("<button class=\"btn btn-primary \" name=\"item_add\" value="+temp.getId()+">save</button>");
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
                <span class="input-group-addon">Delete user</span>
                <input type="text" class = "form-control" name="delete_user" placeholder="book's item_id" >
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