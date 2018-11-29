<%@ page import="java.util.HashMap, java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<style>
.content h3 {
	text-align: left;
}

.content {
	padding-bottom: 64px;
}

#price {
	padding-bottom: 48px;
}

#edit {
	float: right;
}
</style>
<head>
<title>Your Cart</title>
</head>
<body>

	<%
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
		String uid = "msheroub";
		String pw = "21218169";

		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = new HashMap<String, ArrayList<Object>>();

		// Get the current list of products
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		out.println("<h1>Your Shopping Cart</h1>");
		out.print("<table><tr><th>Event ID</th><th>Event Name</th><th>Quantity</th><th></th>");
		out.println("<th>Price</th><th>Subtotal</th><th></th></tr>");

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			String sql = "SELECT * FROM Cart WHERE uid = " + session.getAttribute("userid").toString();
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

		double total = 0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			if (product.size() < 4) {
				out.println("Expected product with four entries. Got: " + product);
				continue;
			}

			out.print("<tr><td>" + product.get(0) + "</td>");
			out.print("<td>" + product.get(1) + "</td>");

			out.print("<td align=\"center\"><a href='removefromcart.jsp?id=" + product.get(0) + "&ar=-1'>--</a>"
					+ product.get(3) + "<a href='addtocart.jsp?id=" + product.get(0) + "&name="
					+ URLEncoder.encode(product.get(1).toString(), "Windows-1252") + "&price=" + product.get(2)
					+ "&ar=1'>++</a></td>");
			Object price = product.get(2);
			Object itemqty = product.get(3);
			double pr = 0;
			int qty = 0;

			try {
				pr = Double.parseDouble(price.toString());
			} catch (Exception e) {
				out.println("Invalid price for ticket: " + product.get(0) + " price: " + price);
			}
			try {
				qty = Integer.parseInt(itemqty.toString());
			} catch (Exception e) {
				out.println("Invalid quantity for tickets: " + product.get(0) + " quantity: " + qty);
			}

			out.print("<td></td><td align=\"right\">" + currFormat.format(pr) + "</td>");
			out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td>");
			//out.print("<td></td><td><a href='removeCart.jsp?id="+product.get(0)+"&name="+URLEncoder.encode((String)product.get(1), "Windows-1252")+"&price="+pr+"'>Remove From Cart</td>");
			out.println("</tr>");
			total = total + pr * qty;
		}
		out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>" + "<td align=\"right\">"
				+ currFormat.format(total) + "</td></tr>");
		out.println("</table>");
		out.println("<a href='clearcart.jsp'>Clear Cart</a>");

		out.println("<h2><a class='button' href=\"checkout.jsp\">Check Out</a></h2>");
	%>
	<h2>
		<a class='button' href="browse.jsp">Go Shopping</a>
	</h2>
</body>
</html>

