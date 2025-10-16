//Global variable that any file can access it

import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';

final appBrain = AppBrain() ;
class AppBrain{
  ValueNotifier <List<MovieModel>>movieList = ValueNotifier([]) ;
}