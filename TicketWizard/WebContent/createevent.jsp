<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Event</title>
</head>
<body>
<%

//User Must be logged in to create an event, if user is not logged in, redirect to login page
if(request.getSession().getAttribute("userid") == null)
	response.sendRedirect("login.jsp");

//Error handling
int err = 0;
if(request.getParameter("err") != null)
	 err = Integer.parseInt(request.getParameter("err"));
switch(err){
case 1:
	out.print("Non-Optional Fields cant be blank");
	break;
case 3:
	out.print("Invalid ticket price. Leave blank for free");
	break;
}
%>
<form action="eventprocess.jsp" method="post">  
Event Name:<input type="text" name="eventname"/><br/><br/>  
Event Description*:<input type="text" name="edescription"/><br/><br/>  
City:<input type="text" name="ecity"/><br/><br/>  
Location*:<input type="text" name="elocation"/><br/><br/> 
Ticket Price*:<input type="text" name="ticketprice"/><br/><br/> 
<input type="submit" value="Create Event"/>
</form>
*: Optional fields. Leave ticket-price blank if event is free.
</body>
</html>