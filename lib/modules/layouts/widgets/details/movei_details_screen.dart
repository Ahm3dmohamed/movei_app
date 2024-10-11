import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/modules/manager/api_manager.dart';
import 'package:movie_app/modules/layouts/widgets/similer/similer_movies_section.dart';
import 'package:movie_app/service/models/movei_details_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final ApiManager apiManager = ApiManager();
  List bookMarkMovei = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppColor.widgetColor,
        title: const Text(
          "Movie Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<MoveiDetailsModel>(
        future:
            apiManager.getMoveiDetails(widget.movieId), // Fetch movie details
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Error Fetching data"));
          }

          final movieDetails = snapshot.data!;
          const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
          String? backdropPath = movieDetails.backdropPath;
          String? posterPath = movieDetails.posterPath;
          String movieTitle = movieDetails.title ?? "Unknown Title";
          String releaseDate =
              movieDetails.releaseDate ?? "Unknown Release Date";
          String fullBackdropUrl =
              backdropPath != null && backdropPath.isNotEmpty
                  ? "$imageBaseUrl$backdropPath"
                  : 'https://via.placeholder.com/500';
          String fullPosterUrl = posterPath != null && posterPath.isNotEmpty
              ? "$imageBaseUrl$posterPath"
              : 'https://via.placeholder.com/200';
          num rating = movieDetails.voteAverage ?? 0.0;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      fullBackdropUrl,
                      fit: BoxFit.cover,
                      width: size.width,
                      height: size.height * .20,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 30,
                      left: 20,
                      child: Center(
                        child: IconButton(
                          iconSize: 50,
                          icon: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          onPressed: () {
                            // Video play functionality can be implemented here
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * .02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        releaseDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18)),
                                child: Image.network(
                                  fullPosterUrl,
                                  width: size.height * .16,
                                  height: size.height * .23,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Positioned(
                                top: -12,
                                left: -16,
                                child: IconButton(
                                  iconSize: 44,
                                  color: bookMarkMovei.contains(widget.movieId)
                                      ? MyAppColor.selectedIconColor
                                          .withOpacity(.8)
                                      : MyAppColor.savedIconColor,
                                  onPressed: () {
                                    setState(() {
                                      if (bookMarkMovei
                                          .contains(widget.movieId)) {
                                        bookMarkMovei.remove(widget.movieId);
                                      } else {
                                        bookMarkMovei.add(widget.movieId);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                      bookMarkMovei.contains(widget.movieId)
                                          ? Icons.bookmark_added
                                          : Icons.bookmark_add),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieDetails.overview ?? "No Overview",
                                  maxLines: 8,
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .02),
                      // Similar Movies Section
                      SimilarMoviesSection(
                        apiManager: apiManager,
                        context: context,
                        movieId: widget.movieId,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
