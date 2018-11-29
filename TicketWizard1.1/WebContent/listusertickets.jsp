<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles.css">
<style>
.content {
	padding-bottom: 64px;
}
</style>
<title>Your Ticket List</title>
</head>
<body>
<h1>Your Ticket List</h1>
<div class='content'>
	<%
		//Note: Forces loading of SQL Server driver

		if (session.getAttribute("userid") != null) {
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
			String uid = "msheroub";
			String pw = "21218169";

			String sql1 = "SELECT  Ticket.tnum, Ticket.enum, Event.ename FROM Ticket JOIN Event ON (Ticket.enum = Event.enum) WHERE uid = "
					+ session.getAttribute("userid");

			try { // Load driver class
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			} catch (java.lang.ClassNotFoundException e) {
				out.println("ClassNotFoundException: " + e);
			}

			// Make connection
			try (Connection con = DriverManager.getConnection(url, uid, pw)) {
				PreparedStatement pStmt1 = con.prepareStatement(sql1);
				ResultSet rst1 = pStmt1.executeQuery();
				//out.println("<b>OrderId | CustomerId | Customer Name | Total Amount </b><br>");
				if (rst1.next())
					out.println(
							"<table><tr><th>Ticket ID</th><th>Event Number</th><th>Event Name</th></tr>");
				else
					out.println("<h1>You have no tickets.</h1>");
				while (rst1.next()) {
					String ticketid = rst1.getString("tnum");
					String ename = rst1.getString("ename");
					int eventnum = rst1.getInt("enum");

					out.println(
							"<tr><td>" + ticketid + "</td><td>" + eventnum + "</td><td>" + ename + "</td></tr>");
				}
				out.println("</table>");

			} catch (SQLException ex) {
				out.println(ex);
			}
		} else {
			response.sendRedirect("login.jsp?code=3");
		}

	// Clear cart
	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	productList = new HashMap<String, ArrayList<Object>>();

	session.setAttribute("productList", productList);
	
	%>
	
</div>
<br><br><br>
<div align="left"><a class='button' href='homepage.jsp'>Back to Home</a></div>

</body>
</html>
