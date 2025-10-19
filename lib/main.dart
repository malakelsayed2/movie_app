import 'package:flutter/material.dart';
import 'package:movie_app/app/movie_app.dart';
import 'package:movie_app/view_model/app_brain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appBrain.initializeApp() ;
  runApp(MovieApp());
}
