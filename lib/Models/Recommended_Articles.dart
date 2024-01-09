class RecommendedMovies {
  String? sId;
  String? title;
  int? year;
  String? poster;
  int? duration;
  String? releaseDate;
  double? averageRating;

  RecommendedMovies({
    this.sId,
    this.title,
    this.year,
    this.poster,
    this.duration,
    this.releaseDate,
    this.averageRating,
  });

  RecommendedMovies.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    year = json['year'];
    poster = json['poster'];
    duration = json['duration'];
    releaseDate = json['releaseDate'];
    averageRating = json['averageRating']?.toDouble(); // averageRating double'a dönüştürüldü
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['year'] = year;
    data['poster'] = poster;
    data['duration'] = duration;
    data['releaseDate'] = releaseDate;
    data['averageRating'] = averageRating;
    return data;
  }
}
