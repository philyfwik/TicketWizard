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
<title>A Student's Grocery Order Processing</title>
</head>
<body>

	<%
		// Get customer id
		String custId = request.getParameter("customerId");
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
		String uid = "msheroub";
		String pw = "21218169";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		Connection con = null;
		boolean stop = false;
		String err = "";

		try {
			con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();
			try {
				int x = Integer.parseInt(custId);
			} catch (NumberFormatException e) {
				err = "Customer ID can only be a number. Please enter a valid ID";
				stop = true;
			}

			if (!stop) {
				ResultSet rst = stmt
						.executeQuery("SELECT DISTINCT customerId FROM Customer WHERE customerId = " + custId);

				if (!rst.next()) {
					stop = true;
					err = "Customer ID does not exist in our records. Please enter another ID";
				}
				if (productList.isEmpty()) {
					err = "Shopping Cart is empty!";
					stop = true;
				}
			}
		} catch (SQLException ex) {
			out.println(ex);
		}

		if (stop) {
			out.println("<h1>" + err + "</h1>");
			out.println("<button type='button' name='back' onclick='history.back()'>Go Back</button>");
		} else {
			String sql = "INSERT INTO Orders (customerId, totalAmount) VALUES (?, ?)";
			String sql2 = "INSERT INTO OrderedProduct VALUES (?,?,? ,?)";
			double totalAmount = 0;
			int refNum = 0;

			try {
				PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1, Integer.parseInt(custId));
				pstmt.setDouble(2, totalAmount);
				pstmt.executeUpdate();

				ResultSet keys = pstmt.getGeneratedKeys();
				keys.next();
				int orderId = keys.getInt(1);
				
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				
				out.println("<h1>Your Order Summary</h1>");
				out.println("<table> <tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th></th><th>Price</th><th>SubTotal</th></tr>");
				
				while (iterator.hasNext()) {
					
					PreparedStatement OPstmt = con.prepareStatement(sql2);
					OPstmt.setInt(1, orderId);
					
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String productId = (String) product.get(0);
					String price = (String) product.get(2);
					double pr = Double.parseDouble(price);
					int qty = ((Integer) product.get(3)).intValue();
					
					OPstmt.setInt(2, Integer.parseInt(productId));
					OPstmt.setInt(3, qty);
					OPstmt.setDouble(4, pr);
					
					refNum += Integer.parseInt(productId);
					totalAmount += pr*qty;
					
					OPstmt.executeUpdate();
					out.println("<tr><td>"+productId+"</td><td>"+(String)product.get(1)+"</td><td>"+ qty +"</td><td></td><td>"+ currFormat.format(pr)+"</td><td>"+ currFormat.format(pr*qty)+"</td></tr>");
				}
				
				Statement update = con.createStatement();
				update.executeUpdate("UPDATE Orders SET totalAmount = " + totalAmount + " WHERE orderId = " + orderId);
				
				out.println("<tr><td></td><td></td><td></td><td></td><td><b>Order Total: </b>" +currFormat.format(totalAmount) +  "</td></tr></table>");
			} catch (SQLException ex) {
				out.println(ex);
			}
			out.println("<h1>Order Completed. Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: " + refNum + "</h1>");
			
			try{
				String cname ="";
				Statement s = con.createStatement();
				ResultSet rst = s.executeQuery("SELECT DISTINCT cname FROM Customer WHERE customerId = " + custId);
				while(rst.next()){
					cname = rst.getString(1);
				}
				out.println("<h1>Shipping to customer: " + custId + " Name: " + cname + "</h1>");
			}catch(SQLException ex){
				out.println(ex);
			}
		}
		
		out.println("<a href='shop.html'>Go Home</a>");

	%>
</BODY>
</HTML>

