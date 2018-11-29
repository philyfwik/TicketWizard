<%@ page import="java.sql.*,java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
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
<title>Browse Events</title>
</head>
<body>
	<div align="left">
		<a href='homepage.jsp'>Back to Home</a>
	</div>

	<h1>Search for the events you want to go to:</h1>

	<form method="get" action="browse.jsp">
		<input type="text" name="eventName" size="50"> <input
			class='button smlButton' type="submit" value="Submit"> <input
			class='button smlButton' type="reset" value="Reset"> <br />
		<span class='small'>(Leave blank for all events)</span> <br /> <label>Category:
		</label><select name="category">
			<option value="">All</option>
			<option value="Food">Food</option>
			<option value="Charity">Charity</option>
			<option value="Education">Education</option>
			<option value="Music">Music</option>
			<option value="Sports">Sports</option>
			<option value="Games">Games</option>
			<option value="Other">Other</option>
		</select><label> | Sort By:</label><select name="sortby">
			<option value="ename">Name</option>
			<option value="currcapacity">Popularity</option>
		</select><br /> <br />
	</form>

	<div class='content'>
		<%
			// Get product name to search for
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

			String name = request.getParameter("eventName");
			String category = request.getParameter("category");
			String sortby = request.getParameter("sortby");
			String ascdesc = " ASC";
			if(sortby == null)
				sortby = "ename";
			
			if (sortby.equals("currcapacity"))
				ascdesc = " DESC";

			if (category == "")
				category = null;

			String sql = "SELECT ename, description, city, category, enum, currcapacity FROM Event WHERE ename LIKE '%" + name
					+ "%' ORDER BY " + sortby + ascdesc;
			String sql2 = "SELECT ename, description, city, category, enum, currcapacity FROM Event WHERE ename LIKE '%" + name
					+ "%' AND category = ? ORDER BY " + sortby + ascdesc;

			// Make the connection
			try {
				con = DriverManager.getConnection(url, uid, pw);
				PreparedStatement pStmt = null;
				if (name != null & category != null) {
					//out.println("<h3 align='center'>" + sortby + ascdesc+ "</h3>");
					pStmt = con.prepareStatement(sql2);
					out.println("<h3 align='center'>SHOWING: " + category + "</h3>");
					pStmt.setString(1, category);
				} else if (name != null & category == null) {
					//out.println("<h3 align='center'>" + sortby + ascdesc+ "</h3>");
					pStmt = con.prepareStatement(sql);
				} else if (name == null & category != null) {
					out.println("<h2 align='center'>SHOWING: " + category + "</h2>");
					//out.println("<h3 align='center'>" + sortby + ascdesc+ "</h3>");
					pStmt = con.prepareStatement(
							"SELECT ename, description, city, category, enum, currcapacity FROM Event WHERE category = ? ORDER BY "
									+ sortby + ascdesc);
					pStmt.setString(1, category);
				} else {
					//out.println("<h3 align='center'>" + sortby + ascdesc+ "</h3>");
					pStmt = con.prepareStatement(
							"SELECT ename, description, city, enum, category, currcapacity FROM Event ORDER BY " + sortby + ascdesc);
				}

				ResultSet rst = pStmt.executeQuery();
				out.println(
						"<table width='100%'><tr><th></th><th>Event Name</th><th>Description</th><th>City</th><th>Category</th><th>Attending</th></tr> ");
				while (rst.next()) {
					//"&name="+URLEncoder.encode(rst.getString("ename"), "Windows-1252")+"&city="+URLEncoder.encode(rst.getString("city"), "Windows-1252")
					out.println("<tr><td><a class='button smlButton small' href='eventview.jsp?id=" + rst.getInt("enum")
							+ "'>View Event</td><td>" + rst.getString("ename") + "</td><td>"
							+ rst.getString("description") + "</td><td>" + rst.getString("city") + "</td><td>"
							+ rst.getString("category") + "</td><td>"+ rst.getInt("currcapacity")+"</tr>");
				}
			} catch (SQLException ex) {
				out.println(ex);
			}
			out.println("</table>");

			con.close();
		%>
	</div>
	<br>
	<br>
</body>
</html>