import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/modules/layouts/widgets/details/movei_details_screen.dart';
import 'package:movie_app/service/models/recommended_sction.dart';
import 'package:movie_app/modules/manager/api_manager.dart';

class RecommendedWidget extends StatefulWidget {
  RecommendedWidget({super.key});

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  final ApiManager apiManager = ApiManager();

  List bookMarkMovei = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<RecommendedSection>(
      future: apiManager.getRecomendedSection(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error while fetching data"));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("No data found"));
        } else {
          var recommendedMovies = snapshot.data!.results!;

          const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

          return Container(
            padding: EdgeInsets.only(
              top: size.height * .01,
            ),
            color: const Color(0xff282A28), // Background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.height * .02,
                  ),
                  child: const Text(
                    "Recommended",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendedMovies.length,
                    itemBuilder: (context, index) {
                      var movie = recommendedMovies[index];
                      num? movieId = recommendedMovies[index].id;
                      String posterUrl = movie.posterPath != null
                          ? "$imageBaseUrl${movie.posterPath}"
                          : '';
                      return Container(
                        width: size.width * 0.35,
                        margin:
                            const EdgeInsets.only(top: 4, left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                          movieId: movieId.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: const Color(0xff282A28),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: posterUrl.isNotEmpty
                                          ? Image.network(
                                              posterUrl,
                                              width: double.infinity,
                                              height: 140,
                                              fit: BoxFit.cover,
                                            )
                                          : const Center(
                                              child: Text(
                                                "No Poster",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -4,
                                  left: -5,
                                  child: IconButton(
                                    iconSize: 44,
                                    color: bookMarkMovei.contains(movieId)
                                        ? MyAppColor.selectedIconColor
                                            .withOpacity(.8)
                                        : MyAppColor.savedIconColor,
                                    onPressed: () {
                                      setState(() {
                                        if (bookMarkMovei.contains(movieId)) {
                                          bookMarkMovei.remove(movieId);
                                        } else {
                                          bookMarkMovei.add(movieId);
                                        }
                                      });
                                    },
                                    icon: Icon(bookMarkMovei.contains(movieId)
                                        ? Icons.bookmark_added
                                        : Icons.bookmark_add),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 18),
                              decoration:
                                  const BoxDecoration(color: Color(0xff282A28)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 10,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        "${movie.voteAverage}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    movie.title ?? "Unknown",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${movie.releaseDate?.split('-')[0]} • ${movie.voteCount} votes",
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
