<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="styles.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Event</title>
</head>
<body>
	<%
		//User Must be logged in to create an event, if user is not logged in, redirect to login page
		if (request.getSession().getAttribute("userid") == null)
			response.sendRedirect("login.jsp");

		//Error handling
		int err = 0;
		if (request.getParameter("err") != null)
			err = Integer.parseInt(request.getParameter("err"));
		switch (err) {
		case 1:
			out.print("Non-Optional Fields cant be blank");
			break;
		case 3:
			out.print("Invalid ticket price / Capacity. Leave blank for defaults (Free tickets / 100 Attendees )");
			break;
		}
	%>
	<div class='content'>
		<h1>Create Event</h1>
		<form class='userForm' action="eventprocess.jsp" method="post">
			<div id='fields'>
				<label>*Event Name:</label><input type="text" name="eventname" /><br />
				<br /> <label>Event Description:</label><input type="text"
					name="edescription" /><br />
				<br /> <label>*City:</label><input type="text" name="ecity" /><br />
				<br /> <label>Location:</label><input type="text" name="elocation" /><br />
				<br /> <label>Capacity:</label><input type="text" name="capacity" /><br />
				<br /> <label>Ticket Price:</label><input type="text"
					name="ticketprice" /><br />
				<br /> <label>Category: </label><select name="category">
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
			<br>
			<br> <input class='button' type="submit" value="Create Event" />
		</form>
		<p class='small'>Leave ticket-price blank if event is free</p>
	</div>
	<br>
	<br>
	<br>
	<div align="left">
		<a class='button' href='homepage.jsp'>Back to Home</a>
	</div>
</body>
</html>