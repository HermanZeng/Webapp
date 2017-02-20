<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>

<head>
<title>Log in</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="/jquery-2.2.2.min.js"></script>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>

<body>

	<div class="container">
		<div class="jumbotron" align="center">
			<h1 style="text-align: center">Login</h1>
			<s:form method="post" role="form" action="login">
				<div class="form-group" align="center">
					<s:textfield type="text" label="ID"
						class="form-control" name="user_id" placeholder="user_id"
						 /> <br> <br>
				</div>
				<div class="form-group" align="center">
					<s:textfield type="password" label="Password"
						class="form-control" name="password" placeholder="password"
						 /> <br> <br>
				</div>
				<s:textfield type="submit" name="submit" value="submit" />
			</s:form>
		</div>
	</div>

</body>

</html>