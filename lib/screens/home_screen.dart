import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/favourites_screen.dart';
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
        title: const Text(
          "Popular Movies",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavouritesScreen()),
              );
            },
            icon: Icon(CupertinoIcons.heart),
          ),
          IconButton(
            onPressed: () {
              appBrain.changeTheme();
            },
            icon: Icon(
              appBrain.isDark.value
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: appBrain.movieList,
        builder: (BuildContext context, value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: appBrain.movieList.value.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MovieDetails(
                            model: appBrain.movieList.value[index],
                          );
                        },
                      ),
                    );
                  },
                  child: CustomMovieCard(
                    model: appBrain.movieList.value[index],
                    onPressed: () {
                      appBrain.favourites.value.add(
                        MovieModel(
                          adult: appBrain.movieList.value[index].adult,
                          backdropPath:
                              appBrain.movieList.value[index].backdropPath,
                          id: appBrain.movieList.value[index].id,
                          originalLanguage:
                              appBrain.movieList.value[index].originalLanguage,
                          originalTitle:
                              appBrain.movieList.value[index].originalTitle,
                          overview: appBrain.movieList.value[index].overview,
                          popularity:
                              appBrain.movieList.value[index].popularity,
                          posterPath:
                              appBrain.movieList.value[index].posterPath,
                          releaseDate:
                              appBrain.movieList.value[index].releaseDate,
                          title: appBrain.movieList.value[index].title,
                          voteAverage:
                              appBrain.movieList.value[index].voteAverage,
                          voteCount: appBrain.movieList.value[index].voteCount,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
