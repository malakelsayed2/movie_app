import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

import 'custom_genre.dart';

class CustomMovieCard extends StatelessWidget {
  const CustomMovieCard({super.key, required this.model});
  final MovieModel model ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: model.id ,
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${model.backdropPath}",
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    SizedBox(width: 5),
                    Text(
                      "${model.voteAverage}/10",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 5,
                  runSpacing: 8,
                  children: [
                    CustomGenre(genre: "genre"),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(CupertinoIcons.time, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      model.releaseDate,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(CupertinoIcons.heart),
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
