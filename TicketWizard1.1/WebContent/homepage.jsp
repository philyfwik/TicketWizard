<%@ page import="java.sql.*" %>

<link rel="stylesheet" href="styles.css">
<title>Ticket Wizard</title>
<style>	
h2 .button {
	margin-bottom: 16px;
}
.floatingR {
	border: none;
}
</style>
<%

//Get session user id, if one exists
Object id = request.getSession().getAttribute("userid");

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


String username = "";
String firstname = "";
String email = "";
%>

<html>
<head>
        <title>Ticket Wizard</title>
</head>
<body>
<%

//If user is not logged in, prompt user to login
//If user is logged in, desplay name and have a view user link
if(id == null){
	out.print("<h3 align='left'><a class='button' href='login.jsp'>Login</a></h3>");
}else{
	
	try(Connection con = DriverManager.getConnection(url,uid,pw)){
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery("SELECT DISTINCT username, firstname, email FROM TUser WHERE uid = " + id.toString());
		while(rst.next()){
			username = rst.getString("username");
			firstname = rst.getString("firstname");
			email = rst.getString("email");
			
			session.setAttribute("seshusername", username);
			session.setAttribute("seshfirstname", firstname);
		}
	}catch(SQLException e){
		out.print(e);
	}
	out.print("<h3 align='left'>Logged in as <a href='showprofile.jsp?id="+id.toString()+"'>" + username+ "</a><br>Welcome " + firstname + "<br><a href='logout.jsp'>logout</a></h3>");
}
%>
<div class='content'>
<h1 align="center"><img src="titlelogo.jpg"></h1>

<h2 align="center"><a class="button" href="browse.jsp">Browse Events</a></h2>

<h2 align="center"><a class="button" href="createevent.jsp">Create an Event</a></h2>


<%
//If user is logged in, then have the option of viewing user tickets
if(id != null){
	out.println("<h2 align='center'><a class='button' href='listusertickets.jsp'>View Your tickets</a></h2>");
	out.println("<h2 align='center'><a class='button' href='viewcartfromdb.jsp'>Your Cart</a></h2>");
}

Object isadmin = session.getAttribute("isadmin");

if(isadmin != null){
	out.println("<footer><a href='listcustomers.jsp'>List Customers</a>");
	out.print(" | <a href='statistics.jsp'>Statistics</a> | ");
	out.print("<a href='showorderinfo.jsp'>Show order info</a></footer>");
}

%>
</div>
</body>
</head>


