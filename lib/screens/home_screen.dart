import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/view_model/app_brain.dart';
import '../widgets/custom_movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ApiService.fetchPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Movies",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
          IconButton(onPressed: () {
            appBrain.changeTheme();
          }, icon: Icon(appBrain.isDark.value ?Icons.light_mode_outlined : Icons.dark_mode)),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: appBrain.movieList,
        builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
            itemCount: appBrain.movieList.value.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MovieDetails(model: appBrain.movieList.value[index]);
                      },
                    ),
                  );
                },
                child: CustomMovieCard(model: appBrain.movieList.value[index]),
              );
            },
          );
        },
      ),
    );
  }
}
