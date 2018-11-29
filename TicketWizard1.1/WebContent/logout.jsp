<%

//Set session userid to null
request.getSession().setAttribute("userid", null);
request.getSession().setAttribute("isadmin", null);
response.sendRedirect("homepage.jsp");
%>