import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_movie/Models/Category_Articles.dart';


class CategoryApi {
  static CategoryApi _singleton = CategoryApi._iternal();
  CategoryApi._iternal();


  factory CategoryApi(){
    return _singleton;
  }

  static Future<List<Category>?> getCategoryList() async{
    final url = Uri.parse('https://neonet.onrender.com/category') ;
    final response = await http.get(url);


    if (response.statusCode == 200) {
      List<dynamic> responseJson = json.decode(response.body);
      List<Category> category = responseJson.map((json) => Category.fromJson(json)).toList();
      return category;
    } else {
      throw Exception('Bilgiler Yüklenmedi');
    }
  }
}