import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Global variable that any file can access it
final appBrain = AppBrain();

class AppBrain {
  ValueNotifier<List<MovieModel>> movieList = ValueNotifier([]);

  ValueNotifier isDark = ValueNotifier(true);

  ValueNotifier<List<MovieModel>> favourites = ValueNotifier([]);
  Map<int, String> genreMap = {};

  int currentPage = 1;

  Future initializeApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final savedTheme = await prefs.getBool('theme');
    isDark.value = savedTheme ?? true;

    await ApiService.fetchGenre();
    await ApiService.fetchPopularMovies();
    favourites.value = favourites.value = movieList.value
        .where((model) => prefs.getInt(model.id.toString()) != null)
        .toList();
  }

  void changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = !isDark.value;
    await prefs.setBool('theme', isDark.value);
  }

  void addToFavourites(MovieModel model) async {
    //Modify list in place
    // favoriteMovies.value.add(movies);
    //Returns new list object
    favourites.value = [...favourites.value, model];
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(model.id.toString(), model.id);

    // favourites.value.add(model) ;
  }

  void removeFromFavourites(MovieModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    favourites.value = favourites.value
        .where((currentmodel) => currentmodel.id != model.id)
        .toList();
    // Remove data for the 'counter' key.
    await prefs.remove(model.id.toString());
  }
}
