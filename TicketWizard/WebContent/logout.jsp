<%

//Set session userid to null
request.getSession().setAttribute("userid", null);
response.sendRedirect("homepage.jsp");
%>