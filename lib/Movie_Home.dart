import 'package:flutter/material.dart';
import 'package:staj_movie/Models/Category_Articles.dart';
import 'package:staj_movie/Models/Movie_Articles.dart';
import 'package:staj_movie/Models/Movie_Detail_articles.dart';
import 'package:staj_movie/Models/Recommended_Articles.dart';
import 'package:staj_movie/Pages/CategoryMovies.dart';
import 'package:staj_movie/Pages/DetailPage.dart';
import 'package:staj_movie/Pages/RecommendPage.dart';
import 'package:staj_movie/Pages/SearchPage.dart';
import 'package:staj_movie/Services/Api_Services.dart';
import 'package:staj_movie/Services/CategoryName_Services.dart';
import 'package:staj_movie/Services/Category_Services.dart';
import 'package:staj_movie/Services/Movie_Detail_Services.dart';
import 'package:staj_movie/Services/Recommender_Service.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  late List<CategoryName> movies = [];
  late List<RecommendedMovies> recommended = [];
  late List<AllMovieDetail> detail = [];
  late List<MovieDetail> moviedetail = [];
  late List<Category> category = [];
  late List<CategoryName> categoryName  = [];

  MovieApi movieApi = MovieApi();
  RecommenderApi recommenderApi = RecommenderApi();
  MovieDetailApi movieDetailApi = MovieDetailApi();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchMovies();
      fetchRecommender();
      fetchCategory(); // Kategorileri çek
    }
  }

  // fetchCategory metodu API'den kategorileri çekmek için kullanılabilir
  Future<void> fetchCategory() async {
    try {
      List<Category>? fetchedCategory = await CategoryApi.getCategoryList();
      setState(() {
        category = fetchedCategory ?? []; // Çekilen kategorileri listeye ekle
      });
    } catch (e) {
      print('Hata: $e');
    }
  }



  Future<void> fetchMovies() async {
    try {
      List<CategoryName>? fetchedMovies = await MovieApi.getMovieList();
      setState(() {
        movies = fetchedMovies!; // Çekilen filmleri listeye ekle
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> fetchMovieDetail(String movieId) async {
    try {
      AllMovieDetail? fetchedMovieDetail = await MovieDetailApi.getMovieDetail(movieId);
      setState(() {
        detail = fetchedMovieDetail != null ? [fetchedMovieDetail] : [];
      });
    } catch (e) {
      print('Hata: $e');
    }
  }


  Future<void> fetchRecommender() async {
    try {
      List<RecommendedMovies>? fetchedRecommended = await RecommenderApi.getRecommendedList();
      setState(() {
        recommended = fetchedRecommended!.cast<RecommendedMovies>(); // Çekilen filmleri listeye ekle
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchMoviesByCategory(String categoryId) async {
    try {
      List<CategoryName>? fetchedMovies = await CategoryNameApi.getMoviesByCategoryName(categoryId);
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          'NEOFILM',
          style: TextStyle(
              color: Colors.red, fontSize: 29, fontWeight: FontWeight.w500),
        ),
        elevation: 3,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // category isimleri geldiği alan
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Tıklandığında kategori adını al ve CategoryMovies sayfasına yönlendir
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryMovies(categoryName: category[index].name ?? ''),
                                  ),
                                );
                              },
                              child: Chip(
                                label: Text(category[index].name ?? '', style: const TextStyle(color: Colors.white)),
                                backgroundColor: Colors.grey[900],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const Divider(
                      height: 35,
                      color: Colors.white,
                      endIndent: 5,
                      indent: 5,
                      thickness: 0.5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Recommended',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommended.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= recommended.length) {
                            return SizedBox();
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecommendPage(recommendedMovies: recommended[index]),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  recommended[index].poster != null && recommended[index].poster!.isNotEmpty
                                      ? Image.network(
                                    recommended[index].poster!,
                                    width: 200,
                                    height: 270,
                                    fit: BoxFit.cover,
                                  )
                                      : Placeholder(),
                                  Container(
                                    width: 200,
                                    height: 310,
                                    color: Colors.black26,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              recommended[index].averageRating?.toStringAsFixed(1) ?? '',
                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          recommended[index].title ?? '',
                                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Series',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetail(Movie: movies[index]),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Image.network(
                                    movies[index].poster ?? '',
                                    width: 200,
                                    height: 270,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 310,
                                    color: Colors.black26,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const Icon(Icons.star, color: Colors.white, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              movies[index].averageRating?.toStringAsFixed(1) ?? '',
                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          movies[index].title ?? '',
                                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
