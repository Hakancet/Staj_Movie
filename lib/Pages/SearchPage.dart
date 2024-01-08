import 'package:flutter/material.dart';
import 'package:staj_movie/Models/Movie_Articles.dart';
import 'package:staj_movie/Pages/DetailPage.dart';
import 'package:staj_movie/Services/Api_Services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<movie> allMovies = [];
  late List<movie> filteredMovies = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void searchMovie(String query) {
    setState(() {
      this.query = query;
      filteredMovies = allMovies.where((movie) {
        final title = movie.title?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<void> fetchMovies() async {
    try {
      var fetchedMovies = await MovieApi.getMovieList();
      if (fetchedMovies != null) {
        setState(() {
          allMovies = List<movie>.from(fetchedMovies);
          filteredMovies = allMovies;
        });
      } else {
      }
    } catch (e) {
      print('Hata: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        title: TextField(
          onChanged: searchMovie,
          decoration: const InputDecoration(
            hintText: 'Film Adı Girin',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Önerilen Filmler',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Chip(
                    label: Text(filteredMovies[index].title ?? '', style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.grey[900],
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.white,
            endIndent: 10,
            indent:10,
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredMovies[index].title ?? '', style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetail(Movie: filteredMovies[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
