<%@ page import="java.sql.*" %>
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

String id = request.getParameter("id");

int eventNum = -1;
String eventName = "";
String description = "";
String city = "";
String location = "";
int maxCapacity;


String sql = "SELECT * FROM Event WHERE enum = " + id;

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
	}
}catch(SQLException e){
	out.println(e);
}


out.print("<h3 align='right'>ID: "+eventNum+"</h3>");
out.print("<h1 align='center'>"+eventName+"</h1>");
out.print("<h3 align='left'>City: "+city+"</h3>");
out.print("<h3 align='left'>Description: "+description+"</h3>");
out.print("<h3 align='left'>Location: "+location+"</h3>");

%>
</body>
</html>