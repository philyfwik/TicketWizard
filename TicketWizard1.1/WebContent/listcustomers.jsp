<%@ page import="java.sql.*"%>

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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List All Customers</title>
</head>
<body>
<%

if(session.getAttribute("isadmin")!= null){
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";
	
	try(Connection con = DriverManager.getConnection(url, uid, pw)){
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery("SELECT uid, username, upw, firstname, lastname, email FROM TUser");
		out.print("<table width='100'><tr><th>Uid</th><th>Username</th><th>Password</th><th>Name</th><th></th><th>Email</th></tr>");
		while(rst.next()){
			out.print("<tr><td>"+rst.getInt("uid") +"</td><td>"+rst.getString("username")+"</td><td>"+
		rst.getString("upw")+ "</td><td>"+rst.getString("firstname")+"</td><td>"+rst.getString("lastname")+"</td><td>"+rst.getString("email")+"</td></tr>");
		}
		out.print("</table>");
	}catch(SQLException e){
		out.print(e);
	}
}else{
	out.print("<h2>This tool is only accessible to admins</h2>");
	out.print("<a href='homepage.jsp'>Go Home</a>");
}
%>
</body>
</html>