import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_movie/Models/Recommended_Articles.dart';

class RecommenderApi {
  static RecommenderApi _singleton = RecommenderApi._internal();
  RecommenderApi._internal();

  factory RecommenderApi() {
    return _singleton;
  }
  static Future<List<RecommendedMovies>?> getRecommendedList() async {
    final url = Uri.parse('https://neonet.onrender.com/movie/main');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);

      // recommendedMovies anahtarını kontrol ettim
      if (responseJson.containsKey('recommendedMovies')) {
        List<dynamic> movieList = responseJson['recommendedMovies'];

        // recommendedMovies içindeki veriyi RecommendedMovies listesine dönüştürdüm
        List<RecommendedMovies> recommendedList = movieList
            .map((json) => RecommendedMovies.fromJson(json))
            .toList();

        return recommendedList;
      } else {
        throw Exception('recommendedMovies anahtarı bulunamadı veya yapı farklı');
      }
    } else {
      throw Exception('Bilgiler Yüklenmedi');
    }
  }

}
