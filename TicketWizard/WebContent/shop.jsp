<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_msheroub;";
String uid = "msheroub";
String pw = "21218169";

%>

<html>
<head>
        <title>Ticket Wizard</title>
</head>
<body>
<%
i

%>
<h3 align="left"><a href="login.jsp">Login</a></h3>

<h1 align="center">Welcome to Ticket Wizard</h1>

<h2 align="center"><a href="browse.jsp">Browse Events</a></h2>

<h2 align="center"><a href="createevent.jsp">Create an Event</a></h2>


</body>
</head>


