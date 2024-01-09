import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_movie/Models/Movie_Articles.dart';


class CategoryNameApi {
  static CategoryNameApi _singleton = CategoryNameApi._iternal();
  CategoryNameApi._iternal();


  factory CategoryNameApi(){
    return _singleton;
  }

  static Future<List<CategoryName>?> getMoviesByCategoryName(String categoryName) async {
    final url = Uri.parse('https://neonet.onrender.com/movie/find?categories=["$categoryName"]');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseJson = json.decode(response.body);
      List<CategoryName> categoryNameList = responseJson.map((json) => CategoryName.fromJson(json)).toList();
      return categoryNameList;
    } else {
      throw Exception('Bilgiler Yüklenmedi');
    }
  }
}