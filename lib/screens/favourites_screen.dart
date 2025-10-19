import 'package:flutter/material.dart';
import 'package:movie_app/view_model/app_brain.dart';
import 'package:movie_app/widgets/custom_movie_card.dart';

import 'movie_details.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: appBrain.favourites,
        builder: (context, value, child) {
          return appBrain.favourites.value.isEmpty
              ? Center(child: Text("No Favourites to show!" , style: TextStyle(fontSize: 20),))
              : SizedBox(
                height: double.infinity,
                child: ListView.builder(
                    itemCount: appBrain.favourites.value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MovieDetails(
                                  model: appBrain.favourites.value[index],
                                );
                              },
                            ),
                          );
                        },
                        child: CustomMovieCard(
                          model: appBrain.favourites.value[index],
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
