<%@ page import="java.sql.*"%>

<%
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";
	String username = request.getParameter("username");
	String pass = request.getParameter("password");

	String code = request.getParameter("code");
	int cd = 0;
	if (code != null)
		cd = Integer.parseInt(code);

	boolean valid = false;

	int err = 3;
	try { // Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " + e);
	}
	if (username == "") {
		err = 1;
	} else if (pass == "") {
		err = 2;
	} else {

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("SELECT uid, isadmin FROM TUser WHERE username = '" + username
					+ "' AND upw = '" + pass + "' COLLATE Latin1_General_CS_AS");
			if (rst.next()) {
				err = 0;
				valid = true;
				request.getSession().setAttribute("userid", rst.getInt("uid"));

				if (rst.getInt("isadmin") == 1)
					request.getSession().setAttribute("isadmin", 1 );
			}
			
		} catch (SQLException e) {
			out.println(e);
		}
	}

	if (err == 0 && cd == 1)
		response.sendRedirect("order.jsp");
	else if (err == 0 && cd == 3)
		response.sendRedirect("listusertickets.jsp");
	else if (err == 0 && cd == 2)
		response.sendRedirect("browse.jsp");
	else if (err == 0)
		response.sendRedirect("homepage.jsp");
	else if(err != 0 && cd == 1)
		response.sendRedirect("checkout.jsp?err="+err);
	else
		response.sendRedirect("login.jsp?err=" + err);
%>