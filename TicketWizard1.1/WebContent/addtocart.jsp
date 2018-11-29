<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	if (session.getAttribute("userid") == null)
		response.sendRedirect("login.jsp?code=2");
	else {
		// Get the current list of products
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		if (productList == null) { // No products currently in list.  Create a list.
			productList = new HashMap<String, ArrayList<Object>>();
		}

		// Add new product selected
		// Get product information
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		Integer quantity = new Integer(1);

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			String sql = "UPDATE Cart SET quantity = (quantity  +  1) WHERE uid = ? AND enum = ? ;";
			String sql2 = "INSERT INTO Cart (uid, enum, ename, price, quantity) VALUES (?, ?, ?, ?, ?);";
			if (productList.containsKey(id)) {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, session.getAttribute("userid").toString());
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				System.out.println("Updated Cart");
			} else {
				PreparedStatement pstmt = con.prepareStatement(sql2);
				pstmt.setString(1, session.getAttribute("userid").toString());
				pstmt.setString(2, id);
				pstmt.setString(3, name);
				pstmt.setString(4, price);
				pstmt.setInt(5, quantity);
				pstmt.executeUpdate();
				System.out.println("Inserted into cart");
			}
		} catch (SQLException e) {
			out.println(e);
		}
		// Store product information in an ArrayList
		ArrayList<Object> product = new ArrayList<Object>();
		product.add(id);
		product.add(name);
		product.add(price);
		product.add(quantity);

		// Update quantity if add same item to order again
		if (productList.containsKey(id)) {
			product = (ArrayList<Object>) productList.get(id);
			int curAmount = ((Integer) product.get(3)).intValue();
			product.set(3, new Integer(curAmount + 1));
		} else
			productList.put(id, product);

		session.setAttribute("productList", productList);


		response.sendRedirect("showcart.jsp");
	}
%>