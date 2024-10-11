import 'package:flutter/material.dart';
import 'package:movie_app/modules/layouts/widgets/details/movei_details_screen.dart';

class SearchMovieCard extends StatelessWidget {
  final dynamic movie;
  const SearchMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        'https://image.tmdb.org/t/p/w500/${movie['poster_path']}';
    final String title = movie['title'] ?? 'Unknown ya man';
    final String releaseDate = movie['release_date'] ?? '';
    final String cast = movie['cast'] ?? 'Cast info not available now ya broo';
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MovieDetailsScreen(movieId: movie['id'].toString()),
          ),
        );
      },
      child: Card(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2, // Limit to 2 lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Release Date: $releaseDate',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cast: $cast',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 2, // Limit cast to 2 lines if necessary
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
