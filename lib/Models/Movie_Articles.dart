class movie {
  String? sId;
  String? title;
  int? year;
  String? poster;
  int? duration;
  String? releaseDate;
  double? averageRating;

  movie(
      {this.sId,
        this.title,
        this.year,
        this.poster,
        this.duration,
        this.releaseDate,
        this.averageRating});

  movie.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    year = json['year'];
    poster = json['poster'];
    duration = json['duration'];
    releaseDate = json['releaseDate'];
    averageRating = json['averageRating']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['year'] = this.year;
    data['poster'] = this.poster;
    data['duration'] = this.duration;
    data['releaseDate'] = this.releaseDate;
    data['averageRating'] = this.averageRating;
    return data;
  }
}