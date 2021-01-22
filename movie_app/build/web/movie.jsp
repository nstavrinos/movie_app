<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Movie App</title>
    
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="css/movie.css" >
  <script defer src="fontawesome/fontawesome-all.js"></script>
 
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
    </nav>
            
    <div class="container movie-selected">
      <div class="row main">
        <div class="col-md-4 poster"></div>
        <div class="col-md-8 description">
          <div class="movie-info"></div>
          <%
				uid = (String)session.getAttribute("username");
				if (uid != null)
				{
		%>
          <button id="save-btn">
              <i class="fas fa-heart"></i>
          </button>
          <%}
			%>
          <div class="overview"></div>
          <div class="cast">
              <h3> Cast</h3>
          </div>          
          </div>

          </div>

      <div class="videos">
        <h2 class="title">Trailer</h2>
        <div class="trailers"></div>
      </div>
    </div>
  </div>


  <script src="js/main.js"></script>
  <script>
    getMovie();
  </script>
  <script>
document.getElementById("save-btn").addEventListener("click", function() {
  var xhttp = new XMLHttpRequest();
  

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
    }
  };
  movie_n = sessionStorage.getItem('movie_name');
  console.log(movie_n+" has been saved!");
  xhttp.open("POST", "movie_save", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.send("movie="+movie_n);
});
</script>
</body>

</html>
