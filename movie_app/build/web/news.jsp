<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>News</title>
  <link rel="stylesheet" href="css/main.css">
        
    </head>
        <body> 
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
        
    <div class="list">
      
  </div>
       
      <rssapp-wall id="fOn2rMmW7c6XUQiN"></rssapp-wall><script src="https://widget.rss.app/v1/wall.js" type="text/javascript" async></script>
     
                                        
     </body>
</html>
