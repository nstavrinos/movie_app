<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html"  pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Movie App</title>
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script defer src="fontawesome/fontawesome-all.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/main.css">

</head>
<body>
<div class="wrapper container-fluid">
  <nav >
	<a href="index.jsp" class="logo">
            <img src="img/PngItem_5335020.png"/>
        </a>

        <input type="checkbox" class="menu-btn" id="menu-btn"/>

        <label class="menu-icon" for="menu-btn">
            <span class="nav-icon"></span>
        </label>

        <!--menu-------------->
        <ul class="menu">
            <li><a href="index.jsp">Home</a></li>
			<%
				String uid = (String)session.getAttribute("username");
				if (uid == null)
				{
		%><!-- NOT A VALID USER, IF THE USER TRIES TO EXECUTE LOGGED IN PAGE DIRECTLY, ACCESS IS RESTRICTED -->
			<?php
                        // Start the session
                        session_start();
                        ?>
                        <li><a href="login.html" >LOG IN  </a></li>
		<%	
				}	
				else
				{
					%>
            <li><a href="profile.jsp">My List</a></li>
            <li><a href="http://83.212.78.178:5000/chatroom.html">Chat Room</a></li>
			<%}
			%>
            <li><a href="news.jsp">News</a></li>
            <li><a href="about_us.jsp">About Us</a></li>
            <%
                if (uid != null){  %>
                 <li> 
                     <div class="dropdown">
                        <button class="dropbtn"> 
                        <%out.print(session.getAttribute("username")+System.getProperty("line.separator"));  %>
                        </button>
                        <div class="dropdown-content">
                                 <a href="disconnect.jsp">disconnect</a>
                       </div>
                     </div> 
                </li>
        		<%	
				}	
					%>
                                     
                </ul>
        <script>
$(document).ready(function(){

    $.get("username_chatroom.jsp", function(data){
      sessionStorage.setItem("username", data);
              console.log(data);
    });
});</script>
        <!--search------------->

  </nav>
  <div class="container movie-search">
    <form id="search-form">
      <input id="search-field" type="text" placeholder="search" autocomplete="off"/>
      <button id="search-btn">
        <i class="fas fa-search"></i>
      </button>
    </form>
  </div>
  <div class="container movies">
  </div>
  <div class="container search-results">
  </div>
</div>
<script src="js/main.js"></script>
</body>
</html>
