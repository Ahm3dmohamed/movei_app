class SearchModel {
  num? page;
  List<dynamic>? results;
  num? totalPages;
  num? totalResults;

  SearchModel({this.page, this.results, this.totalPages, this.totalResults});

  SearchModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];

    if (json['results'] != null) {
      results = List<dynamic>.from(json['results']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    if (results != null) {
      data['results'] = results;
    }
    return data;
  }
}
