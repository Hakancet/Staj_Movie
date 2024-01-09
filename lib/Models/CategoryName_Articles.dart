class CategoryName {
  String? sId;
  String? title;
  int? year;
  String? poster;
  int? averageRating;

  CategoryName(
      {this.sId, this.title, this.year, this.poster, this.averageRating});

  CategoryName.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    year = json['year'];
    poster = json['poster'];
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['year'] = this.year;
    data['poster'] = this.poster;
    data['averageRating'] = this.averageRating;
    return data;
  }
}