<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
	// Get the current list of products
	@SuppressWarnings({ "unchecked" })
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
			.getAttribute("productList");

	if (productList == null) { // No products currently in list.  Create a list.
		productList = new HashMap<String, ArrayList<Object>>();
	}

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	int rd = 0;
	if (request.getParameter("rd") != null)
		rd = Integer.parseInt(request.getParameter("rd"));

	try (Connection con = DriverManager.getConnection(url, uid, pw)) {
		String sql = "SELECT * FROM Cart WHERE uid = " + session.getAttribute("userid");
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		while (rst.next()) {
			String userID = rst.getString("uid");
			String eventnum = rst.getString("enum");
			String ename = rst.getString("ename");
			String price = rst.getString("price");
			Integer qty = rst.getInt("quantity");

			ArrayList<Object> product = new ArrayList<Object>();
			product.add(eventnum);
			product.add(ename);
			product.add(price);
			product.add(qty);

			productList.put(eventnum, product);

		}
		
		session.setAttribute("productList", productList);
	} catch (SQLException e) {
		out.println(e);
	}

	response.sendRedirect("showcart.jsp");
%>