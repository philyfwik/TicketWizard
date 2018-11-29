<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

productList = new HashMap<String, ArrayList<Object>>();

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />