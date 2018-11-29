<%@ page import="java.sql.*"%>
<%
	String id = request.getParameter("id");
	String ename = request.getParameter("ename");
	String description = request.getParameter("description");
	String city = request.getParameter("city");
	String location = request.getParameter("location");
	String category = request.getParameter("category");
	String mxcaptemp = request.getParameter("maxcapacity");
	String tikprictemp = request.getParameter("ticketPrice");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	int err = 0;

	if (err != 0) {
		response.sendRedirect("editevent.jsp?id=" + id + "&err=" + err);
	} else {

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {

			PreparedStatement pstmt = con.prepareStatement(
					"UPDATE Event SET ename = ?, description = ?, city = ?, location = ?, category = ?, maxcapacity = ?, ticketPrice = ? WHERE enum = ?");

			pstmt.setString(1, ename);
			pstmt.setString(2, description);
			pstmt.setString(3, city);
			pstmt.setString(4, location);
			pstmt.setString(5, category);
			pstmt.setString(6, mxcaptemp);
			pstmt.setString(7, tikprictemp);
			pstmt.setString(8, id);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			out.print(e);
		}
	}
%>
