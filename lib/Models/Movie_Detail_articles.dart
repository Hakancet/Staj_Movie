class AllMovieDetail {
  String? sId;
  String? title;
  int? year;
  String? poster;
  String? description;
  bool? isPopular;
  bool? isRecommended;
  int? duration;
  String? releaseDate;
  double? averageRating;
  List<String>? actors;
  String? type;
  List<String>? categories;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AllMovieDetail(
      {this.sId,
        this.title,
        this.year,
        this.poster,
        this.description,
        this.isPopular,
        this.isRecommended,
        this.duration,
        this.releaseDate,
        this.averageRating,
        this.actors,
        this.type,
        this.categories,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AllMovieDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    year = json['year'];
    poster = json['poster'];
    description = json['description'];
    isPopular = json['isPopular'];
    isRecommended = json['isRecommended'];
    duration = json['duration'];
    releaseDate = json['releaseDate'];
    averageRating = json['averageRating'];
    actors = json['actors'].cast<String>();
    type = json['type'];
    categories = json['categories'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['year'] = this.year;
    data['poster'] = this.poster;
    data['description'] = this.description;
    data['isPopular'] = this.isPopular;
    data['isRecommended'] = this.isRecommended;
    data['duration'] = this.duration;
    data['releaseDate'] = this.releaseDate;
    data['averageRating'] = this.averageRating;
    data['actors'] = this.actors;
    data['type'] = this.type;
    data['categories'] = this.categories;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}