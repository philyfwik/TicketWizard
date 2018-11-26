<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%
	@SuppressWarnings({ "unchecked" })
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
			.getAttribute("productList");

	String id = request.getParameter("id");
	ArrayList<Object> product = new ArrayList<Object>();
	product.add(id);
	
	if (productList.containsKey(id)) {
		product = (ArrayList<Object>) productList.get(id);
		int curAmount = ((Integer) product.get(3)).intValue();
		if(curAmount == 1){
			productList.remove(id);
		}else
			product.set(3, new Integer(curAmount - 1));
	}
	
	session.setAttribute("productList", productList);

	response.sendRedirect("showcart.jsp");
%>