<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Edit Event</title>
</head>
<body>
	<div class='content'>
		<h3>Edit Event</h3>

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
			out.println("<form class='userFrom' action='editeventprocess.jsp?id=" + id + "' method='post'>");
			//<form class='userForm' action="editprofileprocess.jsp" method="post">
		%>
		<div id='fields'>
			<label>Event Name:</label><input type="text" name="ename" /><br />
			<br /> <label>Description:</label><input type="text"
				name="description" /><br /> <br /> <label>City:</label><input
				type="text" name="city" /><br /> <br /> <label>Location:</label><input
				type="text" name="location" /><br /> <br /> <label>Max
				Capacity:</label><input type="text" name="maxcapacity" /><br /> <br /> <label>Ticket Price:</label><input
				type="text" name="ticketPrice" /><br /> <br /> <label>Category:</label><select name="category">
					<option value="Sports">Sports</option>
					<option value="Food">Food</option>
					<option value="Charity">Charity</option>
					<option value="Education">Education</option>
					<option value="Music">Music</option>
					<option value="Theatre">Theatre</option>
					<option value="Games">Games</option>
					<option value="Other">Other</option>
				</select><br />
				<br />
		</div>
		<br> <br> <input class='button' type="submit"
			value="Edit Profile" />
		</form>
		Leave blank for no change
	</div>
</body>
</html>