<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
	// Get the current list of products
	@SuppressWarnings({ "unchecked" })
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
			.getAttribute("productList");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";
	
	int ar = 0;
	String sign = "";
	if(request.getParameter("ar") != null){
		ar = Integer.parseInt(request.getParameter("ar"));
	}
	if(ar == -1){
		sign = "-";
	}else
		sign = "+";
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String price = request.getParameter("price");
	Integer quantity = new Integer(1);

	try (Connection con = DriverManager.getConnection(url, uid, pw)) {
		String sql = "UPDATE Cart SET quantity = (quantity "+sign+" 1) WHERE uid = ? AND enum = ? ;";
		String sql2 = "INSERT INTO Cart (uid, enum, ename, price, quantity) VALUES ( ?, ?, ?, ?, ?);";
		if (productList.containsKey(id)) {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, session.getAttribute("userid").toString());
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} else {
			PreparedStatement pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, session.getAttribute("userid").toString());
			pstmt.setString(2, id);
			pstmt.setString(3, name);
			pstmt.setString(4, price);
			pstmt.setInt(5, quantity);
			pstmt.executeUpdate();
		}
	} catch (SQLException e) {
		out.println(e);
	}

	response.sendRedirect("loadcart.jsp");
%>