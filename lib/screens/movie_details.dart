import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/custom_genre.dart';

import '../models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.model});

  final MovieModel model ;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context) ;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: model.id ,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500${model.backdropPath}",
                    height: size.size.height*0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade900.withOpacity(0.8),
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context) ;
                      },
                      icon: Icon(CupertinoIcons.left_chevron),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: size.size.height*0.6,
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    "${model.voteAverage}/10",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(model.releaseDate, style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 5,
                            runSpacing: 8,
                            children: [
                              CustomGenre(genre: "genre"),
                              CustomGenre(genre: "genre"),
                              CustomGenre(genre: "genre"),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            model.overview ,
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
