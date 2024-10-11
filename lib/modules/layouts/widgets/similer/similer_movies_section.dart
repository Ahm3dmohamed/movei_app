import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/modules/layouts/widgets/details/movei_details_screen.dart';
import 'package:movie_app/modules/manager/api_manager.dart';
import 'package:movie_app/service/models/similer_movei_model.dart';

class SimilarMoviesSection extends StatefulWidget {
  const SimilarMoviesSection({
    super.key,
    required this.apiManager,
    required this.context,
    required this.movieId,
  });

  final ApiManager apiManager;
  final BuildContext context;
  final String movieId;

  @override
  State<SimilarMoviesSection> createState() => _SimilarMoviesSectionState();
}

class _SimilarMoviesSectionState extends State<SimilarMoviesSection> {
  List bookMarkMovei = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<SimilarMoviesModel>(
      future: widget.apiManager
          .getSimilarMovies(widget.movieId), // Fetch similar movies
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Error Fetching Similar Movies"));
        }

        var similarMovies = snapshot.data!.results!;
        const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

        return Container(
          padding: const EdgeInsets.only(top: 12, left: 5),
          height: MediaQuery.sizeOf(context).width,
          color: MyAppColor.widgetColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "More Like This",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: size.height * .30, // Explicit height to avoid overflow
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: similarMovies.length,
                  itemBuilder: (context, index) {
                    String? posterPath = similarMovies[index].posterPath;
                    num? movieId = similarMovies[index].id;
                    String fullPosterUrl =
                        posterPath != null && posterPath.isNotEmpty
                            ? "$imageBaseUrl$posterPath"
                            : 'https://via.placeholder.com/200';

                    return InkWell(
                      onTap: () {
                        // Here we pass the movie ID based on the current index
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(
                              movieId: similarMovies[index].id.toString(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(size.height * .01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    fullPosterUrl,
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: -12,
                                  left: -16,
                                  child: IconButton(
                                    iconSize: 44,
                                    color:
                                        bookMarkMovei.contains(widget.movieId)
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
                            SizedBox(height: size.height * .01),
                            SizedBox(
                              width: 100,
                              child: Text(
                                similarMovies[index].title ?? "Unknown",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
