<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
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
<title>Event Tickets</title>
</head>
<body>
	<h1>List of Tickets</h1>
	<div class='content'>
		<%
			//Note: Forces loading of SQL Server driver

			if (session.getAttribute("userid") != null) {
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
				String uid = "msheroub";
				String pw = "21218169";

				String id = request.getParameter("id");

				String sql1 = "SELECT T.tnum, U.firstname, U.lastname FROM Ticket T JOIN TUser U ON (T.uid = U.uid) WHERE T.enum = "
						+ id;

				// Make connection
				try (Connection con = DriverManager.getConnection(url, uid, pw)) {
					Statement pStmt1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CONCUR_READ_ONLY);
					ResultSet rst1 = pStmt1.executeQuery(sql1);
					//out.println("<b>OrderId | CustomerId | Customer Name | Total Amount </b><br>");
					if (rst1.next()) {
						out.println("<table><tr><th>Ticket Number</th><th>Full Name</th></tr>");
						rst1.previous();
						while (rst1.next()) {
							String ticketid = rst1.getString("tnum");
							String firstname = rst1.getString("firstname");
							String lastname = rst1.getString("lastname");

							out.println(
									"<tr><td>" + ticketid + "</td><td>" + firstname + " " + lastname + "</td></tr>");
						}
						out.println("</table>");

					} else
						out.println("<h1>No one has bought any tickets yet.</h1>");

				} catch (SQLException ex) {
					out.println(ex);
				}
			} else {
				response.sendRedirect("login.jsp?code=3");
			}

			// Clear cart
		%>

	</div>
	<br>
	<br>
	<br>
	<div align="left">
		<a class='button' href='homepage.jsp'>Back to Home</a>
	</div>

</body>
</html>

