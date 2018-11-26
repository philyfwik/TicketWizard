<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<h3>Login Form</h3>  
<%  
//This page is to confirm that the user is the one using the page, you have to login twice if you are currently logged in

//Check if an error's been thrown in the login
int err = 0;
if(request.getParameter("err") != null)
	 err = Integer.parseInt(request.getParameter("err"));
switch(err){
case 1:
	out.print("Username cannot be null");
	break;
case 2:
	out.print("Password cannot be null");
	break;
case 3:
	out.print("Invalid Credentials");
	break;
}
  
 %>  
 <br/> 
Please login to proceed to payment. 
<form action="loginprocess.jsp?code=1" method="post">  
User name:<input type="text" name="username"/><br/><br/>  
Password:<input type="password" name="password"/><br/><br/>  
<input type="submit" value="login"/>
</form> 
<h3 align="left"><a href='signup.jsp?code=1'>Sign Up</a></h3>
</body>
</html>