<%-- 
    Document   : newjsp
    Created on : Jan 15, 2021, 4:17:55 PM
    Author     : Kostas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        session.setAttribute("username", null);
        session.setAttribute("password", null);
        response.sendRedirect("index.jsp");
        out.println("alert('User has disconnected');");

%>