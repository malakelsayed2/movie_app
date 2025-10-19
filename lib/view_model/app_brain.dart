import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Global variable that any file can access it
final appBrain = AppBrain();

class AppBrain {
  ValueNotifier<List<MovieModel>> movieList = ValueNotifier([]);

  ValueNotifier isDark = ValueNotifier(true);

  ValueNotifier<List<MovieModel>> favourites = ValueNotifier([]);
  Map<int,String> genreMap = {} ;
  int currentPage =1 ;
  Future initializeApp()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final savedTheme = await prefs.getBool('theme') ;
    isDark.value  = savedTheme ?? true;
  }
  void changeTheme()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = !isDark.value;
    await prefs.setBool('theme', isDark.value);
  }

  void addToFavourites(MovieModel model) {
    //Modify list in place
    // favoriteMovies.value.add(movies);
    //Returns new list object
    favourites.value = [...favourites.value, model];

    // favourites.value.add(model) ;
  }

  void removeFromFavourites(MovieModel model) {
    favourites.value = favourites.value
        .where((currentmodel) => currentmodel.id != model.id)
        .toList();
  }
}
