const movieAPIpath = 'https://api.themoviedb.org/';
const api_key = '46270c06c4dcf45c52b9f26efbe2841d';

const popularMoviesURL = new URL(movieAPIpath + '3/movie/popular');
popularMoviesURL.searchParams.append('api_key', api_key);

const searchMoviesURL = new URL(movieAPIpath + '3/search/movie');
searchMoviesURL.searchParams.append('api_key', api_key);

const form = document.getElementById('search-form');
const searchBtn = document.getElementById('search-btn');
const saveBtn = document.getElementById('save-btn');

const movieSelected = (id) => {
  sessionStorage.setItem('movieID', id);
  window.location = 'movie.jsp';
};


// CREATE MOVIE ELEMENT
const createMovieElement = (movie, container) => {
  const movieElement = document.createElement('div');
  movieElement.classList.add('movie');

  //add poster
  const posterURL = 'https://image.tmdb.org/t/p/w1280';

        const { poster_path, title, vote_average, overview } = movie;
        movieElement.classList.add("movie");

        movieElement.innerHTML = `
            <img
                src="${posterURL + poster_path}"
                alt="${title}"
            />
            <div class="movie-info">
                <h3>${title}</h3>
                <span class="${getClassByRate(
                    vote_average
                )}">${vote_average}</span>
            </div>
            <div class="overview">
                <h3>Overview:</h3>
                ${overview}
            </div>
        `;
  movieElement.addEventListener('click', () => movieSelected(movie.id));
    container.appendChild(movieElement);

};

// SEARCH FUNCTION
const getSearchResults = (searchValue) => {
  const container = document.querySelector('.search-results');
  searchMoviesURL.searchParams.append('query', searchValue);
  const popularMovies = document.querySelector('.movies');

  popularMovies.style.display = 'none';
  if (container.children.length != 0) {
    container.innerHTML = '';
  }

  fetch(searchMoviesURL)
    .then(response => response.json())
    .then(data => {
      console.log(data);
      if (container.children.length == 0) {
        data.results.forEach(function(movie) {
          createMovieElement(movie, container);
        });
      }
    });
};

const searchForMovies = (e) => {
  e.preventDefault();
  const form = document.getElementById('search-form');
  const searchText = document.getElementById('search-field');
  let searchValue = searchText.value;
  console.log(searchValue);
  getSearchResults(searchValue);
  form.reset();
};

// load popular movies (home page)
const loadPopular = () => {
  fetch(popularMoviesURL)
    .then(response => response.json())
    .then(data => {
      data.results.forEach(function(movie) {
        const container = document.querySelector('.movies');
        createMovieElement(movie, container);
      });
    });
}

loadPopular();

form.addEventListener('submit', searchForMovies);
searchBtn.addEventListener('click', searchForMovies);


function getClassByRate(vote) {
    if (vote >= 8) {
        return "green";
    } else if (vote >= 5) {
        return "orange";
    } else {
        return "red";
    }
}


function getMovie() {
  const movieID = sessionStorage.getItem('movieID');
  const findMoviesURL = new URL(movieAPIpath + '3/movie/' + movieID);
  findMoviesURL.searchParams.append('api_key', api_key);

  const container = document.querySelector('.movie-selected');
  const posterContainer = document.querySelector('.poster');
  const movieInfo = document.querySelector('.movie-info');
  const overview = document.querySelector('.overview');
  const cast = document.querySelector('.cast');
  const trailers = document.querySelector('.trailers');

  fetch(findMoviesURL)
    .then(response => response.json())
    .then(movie => {
      console.log(movie);

      //add poster
      const posterURL = 'https://image.tmdb.org/t/p/w342';
      const moviePoster = document.createElement('img');
      moviePoster.src = posterURL + movie.poster_path;

      //add title
      const movieTitle = document.createElement('h1');
      
      movieTitle.innerHTML = movie.title;
      sessionStorage.setItem('movie_name', movie.title);
      movieTitle.classList.add('title');

      //add release-date
      const releaseDate = document.createElement('span');
      const releaseYear = movie.release_date.slice(0, 4);
      releaseDate.innerHTML = `(${releaseYear})`;
      releaseDate.classList.add('release-date');

      // add rating
      const rating = document.createElement('span');
      rating.innerHTML = `${movie.vote_average}`;
      rating.classList.add('rating');

      //add genres
      const genre = document.createElement('span');
      genre.classList.add('genre');

      const genreName = () => {
        console.log(movie.genres[0].name);
        let outcome = [];
        for (i = 0; i < movie.genres.length; i++) {
          outcome.push(movie.genres[i].name);
        }
        const result = outcome.join(' | ');
        genre.innerHTML = `<br> ${result}`;
      };

      genreName();

      //add runtime
      const runtime = document.createElement('span');
      runtime.classList.add('runtime');
      runtime.innerHTML = `<i class="far fa-clock"></i> ${movie.runtime} min`;

      //add description
      const movieOverview = document.createElement('p');
      movieOverview.innerHTML = movie.overview;
      movieOverview.classList.add('overview');

      //add movie credits
      const movieCredits = document.createElement('div');
      movieCredits.classList.add('movie-credits');

      const findCastURL = new URL(movieAPIpath + `3/movie/${movieID}/credits`);
      findCastURL.searchParams.append('api_key', api_key);

      fetch(findCastURL)
        .then(response => response.json())
        .then(data => {
            console.log(data);
            data.cast.forEach((my_cast, index) => {
                if (index<4){      
                    const castname = document.createElement('h1');      
                    castname.innerHTML = my_cast.name;
                    const characterPoster = document.createElement('img');
                    characterPoster.src = posterURL + my_cast.profile_path;
                      var x = document.createElement("LI");
                      x.appendChild(castname);
                      x.appendChild(characterPoster);
                      cast.appendChild(x);
                }
            });
        });

      //add videos
      const findVideosURL = new URL(movieAPIpath + `3/movie/${movieID}/videos`);
      findVideosURL.searchParams.append('api_key', api_key);

      fetch(findVideosURL)
        .then(response => response.json())
        .then(data => {
          console.log(data);
          data.results.forEach((video, index) => {
            const videos = document.createElement('div');
            videos.classList.add('popup');
            let trailer = `<iframe class="fr" width=600% height=400% src="https://www.youtube.com/embed/${video.key}"  frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>`;

            if (video.name.indexOf('Trailer') !== -1 && index <= 0) {
              videos.innerHTML = trailer;
              trailers.appendChild(videos);
            }
          });
        });

      //apend elements
      movieInfo.appendChild(movieTitle);
      movieInfo.appendChild(releaseDate);
      movieInfo.appendChild(rating);
      movieInfo.appendChild(genre);
      movieInfo.appendChild(runtime);
      overview.appendChild(movieOverview);
      posterContainer.appendChild(moviePoster);

    });
};


function getSearchResult (searchValue) {
  const container = document.querySelector('.search-results');
  searchMoviesURL.searchParams.append('query', searchValue.movie_saved);
  const popularMovies = document.querySelector('.movies');
    console.log(searchValue.movie_saved);

    //console.log(searchMoviesURL);
  popularMovies.style.display = 'none';
  if (container.children.length != 0) {
    container.innerHTML = '';
  }

  fetch(searchMoviesURL)
    .then(response => response.json())
    .then(data => {
       // console.log(data);
        movie=data.results[0];
        console.log(movie);
        createMovieElement(movie, container);      
    });
}


function getMovies_saved() {
  const container = document.querySelector('.search-results');
  const popularMovies = document.querySelector('.movies');

  popularMovies.style.display = 'none';
  if (container.children.length != 0) {
    container.innerHTML = '';
  }

  fetch("/movie_app/getmy_movies")
    .then(response => response.json())
    .then(data => {
      data.forEach(function(movie) {
        getSearchResult(movie);

      });
    });
}
