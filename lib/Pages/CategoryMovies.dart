import 'package:flutter/material.dart';
import 'package:staj_movie/Models/Movie_Articles.dart'; // Movie modelini import ettiğinizi varsayalım
import 'package:staj_movie/Services/CategoryName_Services.dart'; // Kategoriye göre filmleri çeken servisi import ettiğinizi varsayalım

class CategoryMovies extends StatefulWidget {
  final String categoryName;

  const CategoryMovies({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryMovies> createState() => _CategoryMoviesState();
}

class _CategoryMoviesState extends State<CategoryMovies> {
  late List<CategoryName> movies = []; // Kategoriye göre filmlerin listesini tutmak için

  @override
  void initState() {
    super.initState();
    fetchMoviesByCategory(widget
        .categoryName);
  }

  Future<void> fetchMoviesByCategory(String categoryName) async {
    try {
      List<CategoryName>? fetchedMovies =
          await CategoryNameApi.getMoviesByCategoryName(categoryName);
      setState(() {
        movies = fetchedMovies ?? [];
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movies[index].title ?? '' , style: TextStyle(color: Colors.white),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Çıkış Yılı: ${movies[index].year ?? ''}',style: TextStyle(color: Colors.white),),
                Text('Film Puanı: ${movies[index].averageRating ?? ''}',style: TextStyle(color: Colors.white),),
              ],
            ),
            leading: movies[index].poster != null &&
                    movies[index].poster!.isNotEmpty
                ? Image.network(
                    movies[index]
                        .poster!,
                    width: MediaQuery.of(context).size.width/8,
                    height: MediaQuery.of(context).size.height/8,
                    fit: BoxFit.cover,
                  )
                : SizedBox(),
          );
        },
      ),
    );
  }
}
