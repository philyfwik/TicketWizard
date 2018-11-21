<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A Student's Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

String sql1 = "SELECT  orderId, customerId, totalAmount FROM Orders";
String sql2 = "SELECT  productId, quantity, price FROM OrderedProduct WHERE orderId = ?";

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
try(Connection con = DriverManager.getConnection(url, uid, pw)){
	PreparedStatement pStmt1 = con.prepareStatement(sql1);
	ResultSet rst1 = pStmt1.executeQuery();
	out.println("<table border='2'> <tr><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr> ");
	//out.println("<b>OrderId | CustomerId | Customer Name | Total Amount </b><br>");
	while(rst1.next()){
		int orderId = rst1.getInt(1);
		PreparedStatement pStmt3 = con.prepareStatement("SELECT DISTINCT cname FROM Customer WHERE customerId = ?");
		pStmt3.setInt(1, rst1.getInt(2));
		String cname = "Default";
		ResultSet rst3 = pStmt3.executeQuery();
		while(rst3.next()){
			cname = rst3.getString(1);
		}
		out.println("<tr><td>" + orderId + "</td><td>" + rst1.getInt(2) + "</td><td>" + cname +"</td><td>"+ rst1.getDouble(3) + "</td></tr>");
		//out.println(orderId + " | " + rst1.getInt(2) + " | " + cname + " | " + rst1.getDouble(3) + "<br>" );
		PreparedStatement pStmt2 = con.prepareStatement(sql2);
		pStmt2.setInt(1, orderId);
		ResultSet rst2 = pStmt2.executeQuery();
		out.println("<tr><td></td><td></td><td></td><td><table><tr><th>Product Id</th><th>Qunatity</th><th>Price</th></tr>");
		//out.println("					<i>Product Id | Quantity | Price</i><br>");
		while(rst2.next()){
			//out.println(rst1.getInt(1) + " | " + rst1.getInt(2) + " | " + rst1.getDouble(3) + "<br>");
			out.println("<tr><td>" + rst2.getInt(1) + "</td><td>"+rst2.getInt(2) + "</td><td>"+rst2.getDouble(3)+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
	
}catch(SQLException ex){
	out.println(ex);
}

// Write query to retrieve all order headers

// For each order in the ResultSet

	// Print out the order header information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

