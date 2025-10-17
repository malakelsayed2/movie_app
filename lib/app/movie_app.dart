import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/view_model/app_brain.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appBrain.isDark,
      builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          home: HomeScreen(),
          theme: appBrain.isDark.value ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
