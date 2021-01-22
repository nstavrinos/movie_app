<!DOCTYPE html>
<html lang="en">
<head>
	<title>About Us</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
  <script defer src="fontawesome/fontawesome-all.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/about_us.css">
<!--===============================================================================================-->
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

  </nav>

	<div class="bg-contact100">
		<div class="container-contact100">
			<div class="wrap-contact100" style="background-image: url('img/about_us.jpeg');">
				<div class="contact100-pic js-tilt" data-tilt>
                                    <span class="contact100-form-title">
						About Us
					</span>
                                    <p><b>
                This website has been designed to provide information about movies.
		Its easy-to-use platform allows the user to discover ratings and Overviews
		of a wide selection of movies from TMDB database.                </b>
                </p>   
                
                <p><b> 
                The user also has the ability to create an account,so he can
                save his favourite movies on his list and chat live with other members of the site .
                </b> </p>
                 
                <p><b>
		This site has been developed by Nikolaos Stavrinos and Konstantinos Konstantinidis
                </b> </p>
                
				</div>

				<form method="POST" class="contact100-form validate-form">
					<span class="contact100-form-title">
						Contact Us
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Name is required">
						<input class="input100" type="text" name="name" placeholder="Name" requierd>
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-user" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<input class="input100" type="text" name="email" placeholder="Email" requierd>
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Message is required">
						<textarea class="input100" name="message" placeholder="Message"requierd></textarea>
						<span class="focus-input100"></span>
					</div>

					<div class="container-contact100-form-btn">
						<button class="contact100-form-btn">
							Send
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
        <script src="https:/smtpjs.com/v3/smtp.js"></script>
        <script src="js/about_us.js"></script>
</body>
</html>
