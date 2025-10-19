
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';

//Global variable that any file can access it
final appBrain = AppBrain() ;
class AppBrain{
  ValueNotifier <List<MovieModel>>movieList = ValueNotifier([]) ;

  ValueNotifier isDark = ValueNotifier(true) ;
  ValueNotifier <List<MovieModel>> favourites = ValueNotifier([]) ;

  void changeTheme(){
    isDark.value = !isDark.value ;
  }
}