import 'package:flutter/material.dart';
import 'package:staj_movie/Models/Category_Articles.dart';
import 'package:staj_movie/Models/Movie_Detail_articles.dart';
import 'package:staj_movie/Models/Recommended_Articles.dart';
import 'package:staj_movie/Pages/CategoryMovies.dart';
import 'package:staj_movie/Services/Category_Services.dart';
import 'package:staj_movie/Services/Movie_Detail_Services.dart';

class RecommendPage extends StatefulWidget {
  final RecommendedMovies recommendedMovies;

  const RecommendPage({Key? key, required this.recommendedMovies}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  late List<Category> category = [];
  late List<Category> movieCategories = []; // Film kategorileri
  late List<AllMovieDetail>? movieDetails; // Filmin detayları

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchCategory(); // Kategorileri çek
      movieDetails = [];
      fetchMovieDetails(); // Film detaylarını çek
    }
  }

  Future<void> fetchMovieDetails() async {
    try {
      String movieId = widget.recommendedMovies.sId ?? '';
      AllMovieDetail? fetchedMovieDetail = await MovieDetailApi.getMovieDetail(movieId);

      setState(() {
        movieDetails = fetchedMovieDetail != null ? [fetchedMovieDetail] : [];
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> fetchCategory() async {
    try {
      List<Category>? fetchedCategory = await CategoryApi.getCategoryList();
      setState(() {
        category = fetchedCategory ?? [];
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
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                if (movieDetails != null && movieDetails!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieDetails![0].title ?? '',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          movieDetails![0].poster ?? '',
                          width: 150,
                          height: 280,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var category in movieCategories)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: Text(
                                category.name ?? '',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          Row(
                            children: [
                              const Icon(Icons.date_range_outlined, color: Colors.white,),
                              Text(
                                ' ${movieDetails![0].year.toString()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timelapse_outlined, color: Colors.white,),
                              Text(
                                '  ${movieDetails![0].duration.toString()} Dk',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.white,),
                              Text(
                                ' ${movieDetails![0].averageRating.toString()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Overview:',
                      style: TextStyle(
                          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieDetails![0].description ?? '',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Date Release: ${movieDetails![0].releaseDate ?? 'Unknown'}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Actors: ${movieDetails![0].actors?.isNotEmpty ?? false ? movieDetails![0].actors!.join(", ") : 'Unknown'}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
