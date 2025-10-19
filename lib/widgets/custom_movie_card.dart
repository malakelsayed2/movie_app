import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

import '../view_model/app_brain.dart';
import 'custom_genre.dart';

class CustomMovieCard extends StatelessWidget {
  const CustomMovieCard({
    super.key,
    required this.model,
  });

  final MovieModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: model.id,
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${model.backdropPath}",
                height: 180,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    SizedBox(width: 5),
                    Text(
                      "${model.voteAverage.toStringAsFixed(1)}/10",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: 8,
                  children: model.genreIds.map((id) {
                    final label =  appBrain.genreMap[id] ;
                        return CustomGenre(genre: label?? "N/A") ;
                  },).toList(),
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.time, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      model.releaseDate,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: appBrain.favourites,
                      builder: (context, value, child) {
                        return IconButton(
                          onPressed: () {
                            if (appBrain.favourites.value.contains(model)) {
                              appBrain.removeFromFavourites(model);
                            } else {
                              appBrain.addToFavourites(model);
                            }
                          },
                          icon: appBrain.favourites.value.contains(model)
                              ? Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.red,
                                )
                              : Icon(CupertinoIcons.heart),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
