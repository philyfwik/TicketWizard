<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="styles.css">
<head>
<title>Order Processing</title>
</head>
<body>

	<%
		Object userid = session.getAttribute("userid");
		Object seshname = session.getAttribute("seshusername");
		Object seshfirst = session.getAttribute("seshfirstname");
		if (userid != null)
			out.print("<h3 align='left'>Logged in as <a href='showprofile.jsp?id=" + userid + "'>" + seshname
					+ "</a><br>Welcome " + seshfirst + "<br><a href='logout.jsp'>logout</a></h3>");

		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
		String uid = "msheroub";
		String pw = "21218169";

		int err = 0;
		if (request.getParameter("err") != null) {
			err = Integer.parseInt(request.getParameter("err"));
		}

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

		out.print("<div class='content'>");
		if (err == 1) {
			out.println("<h3 align='center'>CardNumber / CCV must be integers</h3>");
		} else if (err == 2) {
			out.println("<h3 align='center'>None of the fields can be blank</h3>");
		} else if (err == 3) {
			out.println("<h3 align='center'>Cardnumber must be 8 characters. CCV must be 3</h3>");
		} else if (err == 4) {
			out.println("<h3 align='center'>Invalid Exp. Date</h3>");
		}

		String cardnum = "";
		String expdate = "";
		String ccv = "";
		String fullname = "";

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			String sql = "SELECT cardnum, expirydate, ccv, fullname FROM CreditCard WHERE uid = "
					+ session.getAttribute("userid");
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rst = pstmt.executeQuery();

			while(rst.next()) {
				cardnum = rst.getString("cardnum");
				expdate = rst.getString("expirydate");
				ccv = rst.getString("ccv");
				fullname = rst.getString("fullname");
			}
		} catch (SQLException e) {
			out.print(e);
		}

		out.println("<h2>Enter payment info</h2>"
				+ "<form class='userForm' action='orderprocess.jsp' method='post'>" + "<div id='fields'>"
				+ "<label>Card number:</label><input type='text' value='" + cardnum + "' name='cardnum' /><br />"
				+ "<br /> <label>Expiry date (YYYY-MM-DD):</label><input type='text'" + " value='" + expdate
				+ "' name='expdate' /><br /> <br /> <label>CCV:</label><input"
				+ " type='password' name='ccv' /><br /> <br /> <label>Full"
				+ " name on card:</label><input type='text' value='" + fullname
				+ "' name='fullname' /><br /> <br /> <label>Save"
				+ " payment info?</label><input type='checkbox' name='chkBox'> <br />" + "</div>"
				+ "<br> <br> <br> <input class='button' type='submit'" + "value='Place Order' />" + "</form>'");
	%>


	<br>
	<br>
	<div align="left">
		<a class='button' href='homepage.jsp'>Back to Home</a>
	</div>
</BODY>
</HTML>

