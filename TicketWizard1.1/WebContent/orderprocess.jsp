<%@ page import="java.sql.*, java.util.UUID"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map, java.util.Date"%>
<%@ page import="main.functions"%>
<%

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
	String uid = "msheroub";
	String pw = "21218169";

	String cardnum = request.getParameter("cardnum");
	String expdate = request.getParameter("expdate");
	String fullname = request.getParameter("fullname");
	String ccv = request.getParameter("ccv");
	String saveinfo = request.getParameter("chkBox");

	String userid = session.getAttribute("userid").toString();

	int err = 0;

	try {
		if (ccv != null)
			Integer.parseInt(ccv);
		if (cardnum != null)
			Integer.parseInt(cardnum);
	} catch (NumberFormatException e) {
		err = 1;
	}

	java.util.Date dt = new Date();
	
	if (cardnum == "" || expdate == "" || fullname == "" || ccv == "") {
		err = 2;
	} else if (cardnum.length() != 8 || ccv.length() != 3) {
		err = 3;
	} else if (!functions.isValidFormat("yyyy-MM-dd", expdate) || !dt.after(functions.toDate(expdate))) {
		err = 4;
	} else {
		try { // Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " + e);
		}

		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

		Connection con = null;
		try {
			con = DriverManager.getConnection(url, uid, pw);
		} catch (SQLException e) {
			out.println(e);
		}

		while (iterator.hasNext()) {
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();

			try {
				Statement stmt = con.createStatement();
				ResultSet rst = stmt
						.executeQuery("SELECT DISTINCT currcapacity, maxcapacity FROM Event WHERE enum = "
								+ product.get(0).toString());
				if (rst.next()) {
					int currcapacity = rst.getInt("currcapacity");
					int maxcapacity = rst.getInt("maxcapacity");

					if (currcapacity + Integer.parseInt(product.get(3).toString()) > maxcapacity) {
						err = 5;
						response.sendRedirect("error.jsp?err=" + err);
					}
					
					String updateSQL = "UPDATE Event SET currcapacity = "
							+ (currcapacity + Integer.parseInt(product.get(3).toString()))+ " WHERE enum = " + product.get(0).toString();
					stmt.executeUpdate(updateSQL);
				}
			} catch (SQLException e) {

			}

			for (int i = 1; i <= Integer.parseInt(product.get(3).toString()); i++) {
				String ticketId = UUID.randomUUID().toString();
				out.println(ticketId);
				String ticketSQL = "INSERT INTO Ticket(tnum, uid, enum) VALUES(?, ?, ?);";
				try {
					PreparedStatement pstmt = con.prepareStatement(ticketSQL);
					pstmt.setString(1, ticketId);
					pstmt.setString(2, userid);
					pstmt.setString(3, product.get(0).toString());

					pstmt.executeUpdate();

					System.out.println("Ticket Info Successfully Updated :" + i);
				} catch (SQLException e) {
					out.println(e);
				}

			}
			String orderSQL = "INSERT INTO OrderInfo(enum, uid, amountPaid, purchasetime) VALUES(?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = con.prepareStatement(orderSQL);
				pstmt.setString(1, product.get(0).toString());
				pstmt.setString(2, userid);
				pstmt.setDouble(3, Integer.parseInt(product.get(3).toString())
						* Double.parseDouble(product.get(2).toString()));

				java.util.Date utilDate = new Date();
				java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
				pstmt.setDate(4, sqlDate);

				pstmt.executeUpdate();

				System.out.println("OrderInfo Successfully Updated");
			} catch (SQLException e) {
				out.println(e);
			}

		}

		//If user wants to save credit card info, check if user already has a card saved, if so overwrite said card info 
		if (saveinfo != null) {
			String cardSQL = "INSERT INTO CreditCard VALUES (?, ?, ?, ?, ?)";
			String sql2 = "UPDATE CreditCard SET cardnum = ? , expirydate = ?, ccv = ?, fullname = ? WHERE uid = ? ;";
			try {
				Statement stmt = con.createStatement();
				ResultSet rst = stmt.executeQuery("SELECT DISTINCT uid FROM CreditCard");

				if (rst.next()) {
					PreparedStatement pstmt = con.prepareStatement(sql2);
					pstmt.setString(1, cardnum);
					pstmt.setString(2, expdate);
					pstmt.setString(3, ccv);
					pstmt.setString(4, fullname);
					pstmt.setString(5, userid);
					pstmt.executeUpdate();
					System.out.println("Credit Card Info Successfully Updated");
				} else {
					PreparedStatement pstmt = con.prepareStatement(cardSQL);
					pstmt.setString(1, userid);
					pstmt.setString(2, cardnum);
					pstmt.setString(3, expdate);
					pstmt.setString(4, ccv);
					pstmt.setString(5, fullname);
					pstmt.executeUpdate();
					System.out.println("Credit Card Info Saved.");
				}

			} catch (SQLException e) {
				System.out.println(e);
			}
		}

		con.close();
	}

	if (err == 0) {
		session.setAttribute("productList", null);
		response.sendRedirect("listusertickets.jsp");
	} else
		response.sendRedirect("order.jsp?err=" + err);
%>