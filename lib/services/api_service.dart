import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';

import '../view_model/app_brain.dart';

class ApiService {
  static final String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZjhiZDc2NTdhNjcyZDlkZjk1MjFkYzQ0NWRjY2FhYSIsIm5iZiI6MTc2MDQ1ODYyNC45MjQsInN1YiI6IjY4ZWU3NzgwZDBiMTAzYmMzYzI4MzAxZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SozlzYkJ6tgk-deqwxvZtFoG95mzkawPx-SAaWvvqVQ";

  static Future fetchPopularMovies({int page = 1}) async {
    final String endpoint =
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=$page";
    final Map<String, String> header = {
      'Authorization': 'Bearer $apiKey',
      'accept': 'application/json',
    };

    final url = Uri.parse(endpoint);

    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      final mapResponse = jsonDecode(response.body);

      final results = mapResponse["results"] as List;

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
          genreIds: map['genre_ids'],
        );
      }).toList();

      appBrain.movieList.value = [
        ...appBrain.movieList.value,
        ...fetchedMovies,
      ];

      appBrain.currentPage += 1;
    }
  }

  static Future fetchGenre() async {
    final String endpoint =
        'https://api.themoviedb.org/3/genre/movie/list?language=en';
    final Map<String, String> header = {
      'Authorization': 'Bearer $apiKey',
      'accept': 'application/json',
    };

    final url = Uri.parse(endpoint);

    final response = await http.get(url, headers: header);

    Map<int, String> genreMap = {};

    if (response.statusCode == 200) {
      final mapResponse = jsonDecode(response.body);
      final genreList = mapResponse["genres"] as List;
      for (Map map in genreList) {
        genreMap[map["id"]] = map["name"];
      }

      appBrain.genreMap = genreMap;
    }
  }
}
