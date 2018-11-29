<%@ page import="java.sql.*"%>

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
		ResultSet rst = stmt.executeQuery("SELECT orderNo, enum, uid, tnum, amountPaid, purchasetime FROM OrderInfo");
		out.print("<table border='1' width='50%'><tr><th>OrderNo</th><th>Event ID</th><th>User ID</th><th>Amount Paid</th><th>Date</th></tr>");
		while(rst.next()){
			out.print("<tr><td>"+rst.getInt("orderNo") +"</td><td>"+rst.getInt("enum")+"</td><td>"+
		rst.getInt("uid")+ "</td><td>"+rst.getDouble("amountPaid")+"</td><td>"+rst.getDate("purchasetime")+"</td></tr>");
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