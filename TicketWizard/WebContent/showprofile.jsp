<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Profile</title>
</head>
<body>
<%
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

String id = request.getParameter("id");

out.println("<h3 align='right'><a href='homepage.jsp'>Go Home</a></h3>");

String username = "";
String firstname = "";
String lastname = "";
String email = "";
String address ="";
String phonenum ="";

Object temp = request.getSession().getAttribute("userid");

int userid = -1;
if(temp != null)
	userid = Integer.parseInt(temp.toString());

String sql = "SELECT username, firstname, lastname, address, email, phone FROM TUser WHERE uid = " + id;

try(Connection con = DriverManager.getConnection(url, uid, pw)){
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery(sql);
	
	while(rst.next()){
		username = rst.getString("username");
		firstname = rst.getString("firstname");
		lastname = rst.getString("lastname");
		address = rst.getString("address");
		email = rst.getString("email");
		phonenum = rst.getString("phone");
	}
}catch(SQLException e){
	out.println(e);
}


out.print("<h1 align='center'>User: "+username+"</h1>");
out.print("<h3 align='left'>Name: "+firstname + " " + lastname +"</h3>");
out.print("<h3 align='left'>Address: "+address+"</h3>");
out.print("<h3 align='left'>Email: "+email+"</h3>");
out.print("<h3 align='left'>Phone Num: "+phonenum+"</h3>");


if(id.equals(request.getSession().getAttribute("userid").toString())){
	out.println("<h3 align='left'><a href='editProfile.jsp'>Edit Profile<a></h3>");
}
%>
</body>
</html>