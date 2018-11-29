<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<style>
.content h3 {
	text-align: left;
}
.content {
	padding-bottom: 64px;
}
#price {
	padding-bottom: 48px;
}
#edit {
	float: right;
}
</style>
</head>
<body>
<%
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

//Event num passed through url
String id = request.getParameter("id");

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

out.println("<title>" + eventName + "</title>");

//Print out the event details
out.print("<h3 align='right'>ID: "+eventNum+"</h3>");
out.println("<div class='content wide'>");
out.print("<h1>"+eventName+"</h1>");
out.print("<h3>City: "+city+"</h3>");
out.print("<h3>Description: "+description+"</h3>");
out.print("<h3>Location: "+location+"</h3>");
out.print("<h3 id='price'>Ticket Price: " + currFormat.format(ticketprice) + "</h3>");
out.print("<div align='left'><a class='button' href='db_addtocart.jsp?id=" + eventNum + "&name="+ URLEncoder.encode(eventName, "Windows-1252")+"&price="+ticketprice+"'>Add to Cart</a>");

//if the host of the event is the user thats currently logged in
if(hostid == userid || session.getAttribute("isadmin") != null){
	out.println("<a id='edit' class='button' href='editevent.jsp'>Edit Event<a>");
}

out.println("</div></div>");
out.println("<br/><br/><div align='left'><a class='button' href='browse.jsp'>Back to Browse</a></div>");
%>
</body>
</html>