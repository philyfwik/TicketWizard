<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up Page</title>
</head>
<body>
<% 
int err = 0;
if(request.getParameter("err") != null)
	 err = Integer.parseInt(request.getParameter("err"));

int cd = 0;
if(request.getParameter("code") != null)
	 cd = Integer.parseInt(request.getParameter("code"));

switch(err){
case 1:
	out.print("Non-Optional Fields cant be blank");
	break;
case 2:
	out.print("Passwords do not match");
	break;
}

if(cd==1)
	out.print("<form action='signupprocess.jsp?code='"+cd+" method='post'>");
else
	out.print("<form action='signupprocess.jsp' method='post'>");
%>

<form action="signupprocess.jsp" method="post">  
User Name:<input type="text" name="username"/><br/><br/>  
Password:<input type="password" name="initPass"/><br/><br/>  
Confirm Password:<input type="password" name="confirmPass"/><br/><br/>  
First Name:<input type="text" name="firstname"/><br/><br/>  
Last Name:<input type="text" name="lastname"/><br/><br/>
Email:<input type="text" name="email"/><br/><br/>
Address*:<input type="text" name="address"/><br/><br/> 
Phone Number*:<input type="text" name="phonenum"/><br/><br/>       
<input type="submit" value="Sign Up"/>

</form>
*: Optional
</body>
</html>