<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Event View</title>
</head>
<body>
<%
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

//Event num passed through url
String id = request.getParameter("id");

out.println("<h3 align='right'><a href='homepage.jsp'>Go Home</a></h3>");

//Initializing Default Values
int eventNum = -1;
String eventName = "";
String description = "";
String city = "";
String location = "";
int maxCapacity;
int hostid = 0;
double ticketprice = 0;

//Check if the user is logged in/ There is a user id in the session
Object temp = request.getSession().getAttribute("userid");
int userid = -1;
if(temp != null)
	userid = Integer.parseInt(temp.toString());


String sql = "SELECT * FROM Event WHERE enum = " + id;


//Get Event Details
try(Connection con = DriverManager.getConnection(url, uid, pw)){
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery(sql);

	
	while(rst.next()){
		eventNum = rst.getInt("enum");
		eventName = rst.getString("ename");
		description = rst.getString("description");
		city = rst.getString("city");
		location = rst.getString("location");
		maxCapacity = rst.getInt("maxCapacity");
		hostid = rst.getInt("hostid");
		ticketprice = rst.getDouble("ticketprice");
	}
}catch(SQLException e){
	out.println(e);
}

//Print out the event details
out.print("<h3 align='right'>ID: "+eventNum+"</h3>");
out.print("<h1 align='center'>"+eventName+"</h1>");
out.print("<h3 align='left'>City: "+city+"</h3>");
out.print("<h3 align='left'>Description: "+description+"</h3>");
out.print("<h3 align='left'>Location: "+location+"</h3>");
out.print("<h3 align='left'><a href='addtocart.jsp?id=" + eventNum + "&name="+ URLEncoder.encode(eventName, "Windows-1252")+"&price="+ticketprice+"'>Add to Cart</a> Ticket Price: "+currFormat.format(ticketprice)+"</h3>");

//if the host of the event is the user thats currently logged in
if(hostid == userid){
	out.println("<h3 align='left'><a href='editevent.jsp'>Edit Event<a></h3>");
}
%>
</body>
</html>