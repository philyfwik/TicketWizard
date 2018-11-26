<%@ page import="java.util.HashMap, java.net.URLEncoder"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body>

	<%
		// Get the current list of products
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		if (productList == null || productList.isEmpty()) {
			out.println("<H1>Your shopping cart is empty!</H1>");
			productList = new HashMap<String, ArrayList<Object>>();
		} else {
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			out.println("<h1>Your Shopping Cart</h1>");
			out.print("<table><tr><th>Event ID</th><th>Event Name</th><th>Quantity</th><th></th>");
			out.println("<th>Price</th><th>Subtotal</th><th></th></tr>");

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

				out.print("<td align=\"center\"><a href='removefromcart.jsp?id=" + product.get(0) + "'>--</a>"
						+ product.get(3) + "<a href='addtocart.jsp?id=" + product.get(0) + "&name="
						+ URLEncoder.encode(product.get(1).toString(), "Windows-1252") + "&price=" + product.get(2)
						+ "''>++</a></td>");
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

			out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
		}
	%>
	<h2>
		<a href="browse.jsp">Continue Shopping</a>
	</h2>
</body>
</html>

