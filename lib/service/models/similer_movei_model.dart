class SimilarMoviesModel {
  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  SimilarMoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SimilarMoviesModel.fromJson(Map<String, dynamic> json) {
    return SimilarMoviesModel(
      page: json['page'],
      results: (json['results'] as List<dynamic>?)
          ?.map((movieJson) => Movie.fromJson(movieJson))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class Movie {
  String? posterPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  List<int>? genreIds;
  int? id;
  String? originalTitle;
  String? originalLanguage;
  String? title;
  String? backdropPath;
  double? popularity;
  int? voteCount;
  bool? video;
  double? voteAverage;

  Movie({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      posterPath: json['poster_path'],
      adult: json['adult'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalTitle: json['original_title'],
      originalLanguage: json['original_language'],
      title: json['title'],
      backdropPath: json['backdrop_path'],
      popularity: json['popularity'].toDouble(),
      voteCount: json['vote_count'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
    );
  }
}
