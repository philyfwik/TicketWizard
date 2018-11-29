<%@ page
	import="java.sql.*"%>
<%
	String id = request.getParameter("id");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String cpassword = request.getParameter("confirmPass");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String phonenum = request.getParameter("phonenum");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	int err = 0;
	if (!email.contains("@")) {
		err = 1;
	}

	try {
		Integer.parseInt(phonenum);
	} catch (NumberFormatException e) {
		err = 2;
	}

	if (err != 0) {
		response.sendRedirect("editprofile.jsp?id=" + id + "&err=" + err);
	} else {

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("SELECT * FROM TUser WHERE uid = " + id);
			while (rst.next()) {
				if (username == "")
					username = rst.getString("username");
				if (password == "")
					password = rst.getString("password");
				if (firstname == "")
					firstname = rst.getString("firstname");
				if (lastname == "")
					lastname = rst.getString("lastname");
				if (email == "")
					email = rst.getString("email");
				if (address == "")
					address = rst.getString("address");
				if (phonenum == "")
					phonenum = rst.getString("phonenum");
			}

			PreparedStatement pstmt = con.prepareStatement(
					"UPDATE TUser SET username = ?, password = ?, firstname = ?, lastname = ?, email = ?, address = ?, phonenum = ? WHERE uid = ?");
			
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, firstname);
			pstmt.setString(4, lastname);
			pstmt.setString(5, email);
			pstmt.setString(6, address);
			pstmt.setString(7, phonenum);
			pstmt.setString(8, id);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
