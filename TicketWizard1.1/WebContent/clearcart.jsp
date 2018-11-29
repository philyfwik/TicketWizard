<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

productList = new HashMap<String, ArrayList<Object>>();

session.setAttribute("productList", productList);

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

try(Connection con = DriverManager.getConnection(url, uid, pw)){
	String sql = "DELETE FROM Cart WHERE uid = " + session.getAttribute("userid") + " ;";
	Statement stmt = con.createStatement();
	stmt.executeUpdate(sql);
}catch(SQLException e){
	out.println(e);
}
%>
<jsp:forward page="showcart.jsp" />