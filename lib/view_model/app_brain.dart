import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';

//Global variable that any file can access it
final appBrain = AppBrain();

class AppBrain {
  ValueNotifier<List<MovieModel>> movieList = ValueNotifier([]);

  ValueNotifier isDark = ValueNotifier(true);

  ValueNotifier<List<MovieModel>> favourites = ValueNotifier([]);

  void changeTheme() {
    isDark.value = !isDark.value;
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
