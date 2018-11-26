<%@ page import="java.sql.*,java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Browse Events</title>
</head>
<body>

	<h1>Search for the events you want to go to:</h1>

	<form method="get" action="browse.jsp">
		<input type="text" name="eventName" size="50"> <input
			type="submit" value="Submit"><input type="reset"
			value="Reset"> (Leave blank for all events)
	</form>

	<%
		// Get product name to search for
		String name = request.getParameter("eventName");
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
		String uid = "msheroub";
		String pw = "21218169";

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		Connection con = null;

		//Note: Forces loading of SQL Server driver
		try { // Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " + e);
		}

		String sql = "SELECT ename, description, city, enum FROM Event WHERE ename LIKE '%" + name
				+ "%' ORDER BY ename ASC";
		
		out.println("<table width='100%'><tr><th></th><th>Event Name</th><th>Description</th><th>City</th></tr> ");
		// Make the connection
		try {
			con = DriverManager.getConnection(url, uid, pw);
			PreparedStatement pStmt = null;
			if(name != null){
				pStmt = con.prepareStatement(sql);
			}else{
				pStmt = con.prepareStatement("SELECT ename, description, city, enum FROM Event ORDER BY ename ASC");
			}
			ResultSet rst = pStmt.executeQuery();
			while (rst.next()) {
				//"&name="+URLEncoder.encode(rst.getString("ename"), "Windows-1252")+"&city="+URLEncoder.encode(rst.getString("city"), "Windows-1252")
				out.println("<tr><td><a href='eventview.jsp?id="+rst.getInt("enum")+"'>View Event</td><td>" 
				+ rst.getString("ename") + "</td><td>" +rst.getString("description") + "</td><td>"+ rst.getString("city")
						+ "</td></tr>");
			}
		} catch (SQLException ex) {
			out.println(ex);
		}
		out.println("</table>");
		// Print out the ResultSet

		con.close();

	%>

</body>
</html>