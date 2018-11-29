<%@ page import="java.sql.*"%>
<%
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	//Get values of textboxes from signup form
	String username = request.getParameter("username");
	String password = request.getParameter("initPass");
	String cpassword = request.getParameter("confirmPass");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String phonenum = request.getParameter("phonenum");

	int err = -1;

	if (username == "" || password == "" || firstname == "" || cpassword == "" || lastname == ""
			|| email == "") {
		err = 1; //Non-Optional Fields cant be blank
		response.sendRedirect("signup.jsp?err=" + err);
	} else if (!password.equals(cpassword)) {
		err = 2; //Pass != Confirm pass
		response.sendRedirect("signup.jsp?err=" + err);
	} else if (!email.contains("@") || !email.contains(".")) {

	} else {

		//If the values are valid, insert into TUser the new user

		try { // Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " + e);
		}

		String sql = "INSERT INTO TUser VALUES (?,?,?,?,?,?,?, 'false'); ";

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			PreparedStatement pStmt = con.prepareStatement(sql);

			pStmt.setString(1, username);
			pStmt.setString(2, password);
			pStmt.setString(3, firstname);
			pStmt.setString(4, lastname);
			pStmt.setString(5, address);
			pStmt.setString(6, email);
			pStmt.setString(7, phonenum);

			pStmt.executeUpdate();

			Statement stmt = con.createStatement();
			ResultSet rst = stmt
					.executeQuery("SELECT DISTINCT uid FROM TUser WHERE username = '" + username + "'");
			if (rst.next())
				request.getSession().setAttribute("userid", rst.getInt("uid"));


			int cd = 0;
			if (request.getParameter("code") != null)
				cd = Integer.parseInt(request.getParameter("code"));

			//Where to redirect
			if (cd == 1)
				response.sendRedirect("order.jsp");
			else
				response.sendRedirect("homepage.jsp");

		} catch (SQLException e) {
			out.print(e);
		}
	}
%>