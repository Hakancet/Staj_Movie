import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_movie/Models/Movie_Detail_articles.dart';

class MovieDetailApi {
  static Future<AllMovieDetail?> getMovieDetail(String movieId) async {
    final url = Uri.parse('https://neonet.onrender.com/movie/$movieId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      AllMovieDetail movie = AllMovieDetail.fromJson(responseJson);
      return movie;
    } else {
      throw Exception('Bilgiler Yüklenmedi');
    }
  }
}