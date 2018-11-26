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

//Check if there is an error code passed through. i.e. If the login process failed
int err = 0;
if(request.getParameter("err") != null)
	 err = Integer.parseInt(request.getParameter("err"));
//Show feedback to user as to what went wrong
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
<form action="loginprocess.jsp" method="post">  
User name:<input type="text" name="username"/><br/><br/>  
Password:<input type="password" name="password"/><br/><br/>  
<input type="submit" value="login"/>
</form> 
<h3 align="left"><a href='signup.jsp'>Sign Up</a></h3>
</body>
</html>