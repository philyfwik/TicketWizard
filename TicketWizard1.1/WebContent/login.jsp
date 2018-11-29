<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Login</title>
</head>
<body>
	<div class='content'>
		<h3>Login</h3>
		<%
			//Check if there is an error code passed through. i.e. If the login process failed
			int err = 0;
			if (request.getParameter("err") != null)
				err = Integer.parseInt(request.getParameter("err"));
			//Show feedback to user as to what went wrong
			switch (err) {
			case 1:
				out.print("Username cannot be null");
				break;
			case 2:
				out.print("Password cannot be null");
				break;
			case 3:
				out.print("Invalid Credentials");
				break;
			}
			String code = request.getParameter("code");
			int cd = 0;
			if (code != null)
				cd = Integer.parseInt(code);
			out.println("<form class='userForm' action='loginprocess.jsp?code=" + cd + "' method='post'>");
		%>
		<br />
		<div id='fields'>
			<label>Username:</label><input type="text" name="username" size='20' /><br />
			<br /> <label>Password:</label><input type="password" name="password"
				size='20' /><br />
			<br />
			<br />
			<div class='wrapper'>
				<a id='signup' class='button medButton' href='signup.jsp'>Sign
					Up</a> <input id='login' class='button medButton' type="submit"
					value="Login" />
			</div>
		</div>
		</form>
	</div>
</body>
</html>