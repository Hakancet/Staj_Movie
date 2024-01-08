import 'package:flutter/material.dart';
import 'package:staj_movie/Models/Movie_Articles.dart';
import 'package:staj_movie/Pages/DetailPage.dart';
import 'package:staj_movie/Pages/SearchPage.dart';
import 'package:staj_movie/Services/Api_Services.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  late List<movie> movies = []; // Film listesi

  MovieApi movieApi = MovieApi(); // Api sınıfından bir örnek

  @override
  void initState() {
    super.initState();
    fetchMovies(); // Filmleri çekmek için API'yi çağırır
  }

  Future<void> fetchMovies() async {
    try {
      List<movie>? fetchedMovies = await MovieApi.getMovieList(); // API'den filmleri çek
      setState(() {
        movies = fetchedMovies!; // Çekilen filmleri listeye ekle
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Action',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Commedy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Horror',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Adventura',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
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
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Tıklanan film detay sayfasına yönlendirilir
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetail(Movie: movies[index]),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  // Resim
                                  Image.network(
                                    movies[index].poster ?? '',
                                    width: 200,
                                    height: 270,
                                    fit: BoxFit.cover,
                                  ),
                                  // Metinler
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
                                            Icon(Icons.star, color: Colors.white, size: 16),
                                            Icon(Icons.star, color: Colors.white, size: 16),
                                            Icon(Icons.star, color: Colors.white, size: 16),
                                            Icon(Icons.star, color: Colors.white, size: 16),
                                            Icon(Icons.star, color: Colors.white, size: 16),
                                            SizedBox(width: 4),
                                            Text(
                                              movies[index].averageRating?.toStringAsFixed(1) ?? '',
                                              style: TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          movies[index].title ?? '',
                                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
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
                            child: Stack(
                              children: [
                                // Resim
                                Image.network(
                                  movies[index].poster ?? '',
                                  width: 200,
                                  height: 270,
                                  fit: BoxFit.cover,
                                ),
                                // Metinler
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
                                          Icon(Icons.star, color: Colors.white, size: 16),
                                          Icon(Icons.star, color: Colors.white, size: 16),
                                          Icon(Icons.star, color: Colors.white, size: 16),
                                          Icon(Icons.star, color: Colors.white, size: 16),
                                          Icon(Icons.star, color: Colors.white, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            movies[index].averageRating?.toStringAsFixed(1) ?? '',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        movies[index].title ?? '',
                                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
