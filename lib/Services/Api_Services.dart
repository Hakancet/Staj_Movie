import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_movie/Models/Movie_Articles.dart';


class MovieApi {
  static MovieApi _singleton = MovieApi._iternal();
  MovieApi._iternal();


  factory MovieApi(){
    return _singleton;
  }

  static Future<List<CategoryName>?> getMovieList() async{
    final url = Uri.parse('https://neonet.onrender.com/movie') ;
    final response = await http.get(url);


    if (response.statusCode == 200) {
      List<dynamic> responseJson = json.decode(response.body);
      List<CategoryName> movieList = responseJson.map((json) => CategoryName.fromJson(json)).toList();
      return movieList;
    } else {
      throw Exception('Bilgiler Yüklenmedi');
    }
  }
}