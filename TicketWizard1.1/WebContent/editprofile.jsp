<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Edit Profile</title>
</head>
<body>
	<div class='content'>
		<h3>Edit Profile</h3>

		<%
			int err = 0;
			if (request.getParameter("err") != null)
				err = Integer.parseInt(request.getParameter("err"));
			switch (err) {
			case 1:
				out.println("Invalid Email");
				break;
			case 2:
				out.println("Invalid PhoneNumber");
				break;
			}
			String id = request.getParameter("id");
			out.println("<form class='userFrom' action='editprofileprocess.jsp?id=" + id + "' method='post'>");
			//<form class='userForm' action="editprofileprocess.jsp" method="post">
		%>
		<div id='fields'>
			<label>User Name:</label><input type="text" name="username" /><br />
			<br /> <label>Password:</label><input type="password"
				name="initPass" /><br /> <br /> <label>Confirm Password:</label><input
				type="password" name="confirmPass" /><br /> <br /> <label>First
				Name:</label><input type="text" name="firstname" /><br /> <br /> <label>Last
				Name</label><input type="text" name="lastname" /><br /> <br /> <label>Email:</label><input
				type="text" name="email" /><br /> <br /> <label>Address:</label><input
				type="text" name="address" /><br /> <br /> <label>Phone
				Number:</label><input type="text" name="phonenum" /><br /> <br />
		</div>
		<br> <br> <input class='button' type="submit"
			value="Edit Profile" />
		</form>
		Leave blank for no change
	</div>
</body>
</html>