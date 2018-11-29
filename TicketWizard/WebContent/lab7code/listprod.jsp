<%@ page import="java.sql.*,java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A Student's Grocery</title>
</head>
<body>

	<h1>Search for the products you want to buy:</h1>

	<form method="get" action="listprod.jsp">
		<input type="text" name="productName" size="50"> <input
			type="submit" value="Submit"><input type="reset"
			value="Reset"> (Leave blank for all products)
	</form>

	<%
		// Get product name to search for
		String name = request.getParameter("productName");
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

		// Variable name now contains the search string the user entered
		// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

		// out.println(currFormat.format(5.0);	// Prints $5.00

		String sql = "SELECT productName, price, productId, categoryName FROM Product WHERE productName LIKE '%" + name
				+ "%' ORDER BY productName ASC";
		out.println("<table width='100%'><tr><th></th><th>Product Name</th><th>Category Name</th><th>Price</th></tr> ");
		// Make the connection
		try {
			con = DriverManager.getConnection(url, uid, pw);
			PreparedStatement pStmt = null;
			if(name != null){
				pStmt = con.prepareStatement(sql);
			}else{
				pStmt = con.prepareStatement("SELECT productName, price, productId, categoryName FROM Product");
			}
			ResultSet rst = pStmt.executeQuery();
			while (rst.next()) {
				//out.println("<form method='GET' action ='addcart.jsp?id="+rst.getInt(3)+"&name="+URLEncoder.encode(rst.getString(1), "Windows-1252")+"&price="+rst.getDouble(2)+"'>");
				out.println("<tr><td><a href='addcart.jsp?id="+rst.getInt(3)+"&name="+URLEncoder.encode(rst.getString(1), "Windows-1252")+"&price="+rst.getDouble(2)+"'>Add To Cart</td><td>" 
				+ rst.getString(1) + "</td><td>" +rst.getString(4) + "</td><td>"+ currFormat.format(rst.getDouble(2))
						+ "</td></tr>");
			}
		} catch (SQLException ex) {
			out.println(ex);
		}
		out.println("</table>");
		// Print out the ResultSet

		con.close();
		// For each product create a link of the form
		// addcart.jsp?id=<productId>&name=<productName>&price=<productPrice>
		// Note: As some product names contain special characters, need to encode URL parameter for product name like this: URLEncoder.encode(productName, "Windows-1252")
		// Close connection

		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);	// Prints $5.00
	%>

</body>
</html>