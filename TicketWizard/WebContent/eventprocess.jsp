<%@ page import="java.sql.*"%>
<%
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	int err = 0;

	//Get parameters from createevent form
	String eventname = request.getParameter("eventname");
	String description = request.getParameter("edescription");
	String city = request.getParameter("ecity");
	String location = request.getParameter("elocation");
	String hostid = request.getSession().getAttribute("userid").toString();
	String tp = request.getParameter("ticketprice");
	double ticketprice = 0;

	//if Any of the non optional fields are blank
	if (eventname == "" || city == "" || hostid == "")
		err = 1;

	//Check that ticket price is a number
	try {
		if (tp != "")
			ticketprice = Double.parseDouble(tp);
	} catch (NumberFormatException e) {
		err = 3;
	}

	//Check that no errors have been thrown
	if (err != 0) {
		response.sendRedirect("createevent.jsp?err=" + err);
	} else {
		try { // Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " + e);
		}
		
		
		String sql = "INSERT INTO Event(ename, description, city, location, maxcapacity, hostid, ticketprice) VALUES (?, ?, ?, ?, 50,"
				+ hostid + ", ?);"; //Leave the capacity at 50 for now

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			PreparedStatement pStmt = con.prepareStatement(sql);
			pStmt.setString(1, eventname);
			pStmt.setString(2, description);
			pStmt.setString(3, city);
			pStmt.setString(4, location);
			pStmt.setDouble(5, ticketprice);

			pStmt.executeUpdate();

			out.println("<h1 align='center'>Event Successfully created</h1>");
			out.println("<h3 align='center'><a href='browse.jsp'>Browse</a></h3>");
		} catch (SQLException e) {
			out.println(e);
		}
	}
%>