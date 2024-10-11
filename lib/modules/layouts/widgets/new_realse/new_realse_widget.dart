import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/modules/layouts/widgets/details/movei_details_screen.dart';
import 'package:movie_app/service/models/newrealse_section.dart';
import 'package:movie_app/modules/manager/api_manager.dart';

class NewRealse extends StatefulWidget {
  NewRealse({super.key});

  @override
  State<NewRealse> createState() => _NewRealseState();
}

class _NewRealseState extends State<NewRealse> {
  final ApiManager apiManager = ApiManager();

  List bookMarkMovei = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<NewRealeaseSection>(
      future: apiManager.getNewRealseMovei(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error while fetching data"),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text("No data found"),
          );
        } else {
          var newReleases = snapshot.data!.results!;
          const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

          return Container(
            padding: EdgeInsets.only(
              top: size.height * .01,
              bottom: 0,
            ),
            color: const Color(0xff282A28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.height * .02,
                  ),
                  child: const Text(
                    "New Releases",
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
                    itemCount: newReleases.length,
                    itemBuilder: (context, index) {
                      String? posterPath = newReleases[index].posterPath;
                      String fullPosterUrl =
                          posterPath != null && posterPath.isNotEmpty
                              ? "$imageBaseUrl$posterPath"
                              : '';
                      num? moveiId = newReleases[index].id;
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      movieId: moveiId.toString(),
                                    ),
                                  ));
                            },
                            child: Card(
                              color: const Color(0xff282A28),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: fullPosterUrl.isNotEmpty
                                    ? Image.network(
                                        fullPosterUrl,
                                        width: size.width * 0.35,
                                        height: size.height * 0.25,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Text(
                                          "No poster",
                                          style: TextStyle(color: Colors.white),
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
                              color: bookMarkMovei.contains(moveiId)
                                  ? MyAppColor.selectedIconColor.withOpacity(.8)
                                  : MyAppColor.savedIconColor,
                              onPressed: () {
                                setState(() {
                                  if (bookMarkMovei.contains(moveiId)) {
                                    bookMarkMovei.remove(moveiId);
                                  } else {
                                    bookMarkMovei.add(moveiId);
                                  }
                                });
                              },
                              icon: Icon(bookMarkMovei.contains(moveiId)
                                  ? Icons.bookmark_added
                                  : Icons.bookmark_add),
                            ),
                          ),
                        ],
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
