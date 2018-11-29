<%@ page import="java.util.HashMap"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";
	
	@SuppressWarnings({ "unchecked" })
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
			.getAttribute("productList");

	String id = request.getParameter("id");
	ArrayList<Object> product = new ArrayList<Object>();
	product.add(id);
	String sql = "";
	if (productList.containsKey(id)) {
		product = (ArrayList<Object>) productList.get(id);
		int curAmount = ((Integer) product.get(3)).intValue();
		if (curAmount == 1) {
			productList.remove(id);
			sql = "DELETE FROM Cart WHERE uid = ? AND enum = ? ";
		} else {
			product.set(3, new Integer(curAmount - 1));
			productList.remove(id);
			productList.put(id, product);
			sql = "UPDATE Cart SET quantity = (quantity  -  1) WHERE uid = ? AND enum = ? ;";

		}
	}

	try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, session.getAttribute("userid").toString());
			pstmt.setString(2, id);
			pstmt.executeUpdate();
	} catch (SQLException e) {
		out.println(e);
	}

	session.setAttribute("productList", productList);

	response.sendRedirect("showcart.jsp");
%>