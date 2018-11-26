<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Order Processing</title>
</head>
<body>

	<%
		int err = 0;
		if (request.getParameter("err") != null) {
			err = Integer.parseInt(request.getParameter("err"));
		}

		if (err == 1) {
			out.println("CardNumber / CCV must be integers");
		} else if (err == 2) {
			out.println("None of the fields can be blank");
		} else if (err == 3) {
			out.println("Cardnumber must be 8 characters. CCV must be 3");
		} else if (err == 4) {
			out.println("Invalid Exp. Date");
		} else {
			@SuppressWarnings({ "unchecked" })
			HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
					.getAttribute("productList");
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			out.print("<table><tr><th>Event ID</th><th>Event Name</th><th>Quantity</th><th></th>");
			out.println("<th>Price</th><th>Subtotal</th><th></th></tr>");
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			double total = 0;
			while (iterator.hasNext()) {
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				if (product.size() < 4) {
					out.println("Expected product with four entries. Got: " + product);
					continue;
				}

				out.print("<tr><td>" + product.get(0) + "</td>");
				out.print("<td>" + product.get(1) + "</td>");

				out.print("<td align=\"center\">" + product.get(3) + "</td>");
				out.print("<td></td><td align='right'>" + product.get(2) + "</td>");
				Object price = product.get(2);
				Object itemqty = product.get(3);
				double pr = Double.parseDouble(price.toString());
				int qty = Integer.parseInt(itemqty.toString());
				out.print("<td>" + pr * qty + "</td></tr>");
				total += pr * qty;
			}
		out.print("</table><br><h3 align='center'>Total: " + currFormat.format(total) + "</h3>");
		}
	%>

	<form action="orderprocess.jsp" method="post">
		Card Number: <input type="text" name="cardnum" /><br /> <br /> Exp.
		Date (YYYY-MM-DD)): <input type="text" name="expdate" /><br /> <br />
		ccv: <input type="password" name="ccv" /><br /> <br /> Full Name on
		Card: <input type="text" name="fullname" /><br /> <br /> Save
		Payment info? <input type="checkbox" name="chkBox"> <br /> <input
			type="submit" value="Place Order" />

	</form>


	<%
		out.println("<a href='homepage.jsp'>Go Home</a>");
	%>
</BODY>
</HTML>

