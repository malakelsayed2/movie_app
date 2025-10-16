import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';

import '../view_model/app_brain.dart';

class ApiService {
  static final String endpoint = "https://api.themoviedb.org/3/movie/popular";

  static final String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZjhiZDc2NTdhNjcyZDlkZjk1MjFkYzQ0NWRjY2FhYSIsIm5iZiI6MTc2MDQ1ODYyNC45MjQsInN1YiI6IjY4ZWU3NzgwZDBiMTAzYmMzYzI4MzAxZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SozlzYkJ6tgk-deqwxvZtFoG95mzkawPx-SAaWvvqVQ";

  static void fetchPopularMovies() async {
    final Map<String, String> header = {
      'Authorization': 'Bearer $apiKey',
      'accept': 'application/json',
    };

    final url = Uri.parse(endpoint);

    final response = await http.get(url, headers: header);
    // print(response.body);

    if (response.statusCode == 200) {
      final mapResponse = jsonDecode(response.body);
      // print(mapResponse);

      final results = mapResponse["results"] as List;

      // print(results);

      final fetchedMovies = results.map((map) {
        return MovieModel(
          adult: map['adult'],
          id: map['id'],
          originalLanguage: map['original_language'],
          originalTitle: map['original_title'],
          overview: map['overview'],
          popularity: map['popularity'],
          releaseDate: map['release_date'],
          title: map['title'],
          voteAverage: map['vote_average'],
          voteCount: map['vote_count'],
          backdropPath: map['backdrop_path'],
          posterPath: map['poster_path'],
        );
      }).toList();

      // print(fetchedMovies.length) ;
      // print(fetchedMovies.runtimeType) ;

      appBrain.movieList.value = fetchedMovies ;
    }
  }
}
