import 'package:flutter/material.dart';
import 'package:staj_movie/Models/Movie_Articles.dart';

class MovieDetail extends StatefulWidget {
  final movie Movie;

  const MovieDetail({Key? key, required this.Movie}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.Movie.title ?? '',
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
                        widget.Movie.poster ?? '',
                        width: 200,
                        height: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 15,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Science Fiction',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Drama',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.Movie.year.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.av_timer_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.Movie.duration.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              '  Dk',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.Movie.averageRating.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    ' Konusu :  lorem100" ifadesi genellikle lorem ipsum metinlerinde kullanılan bir terimdir ve genellikle bir dizi rastgele kelimeden oluşan, gerçek anlamı olmayan bir metni ifade eder. Lorem ipsum, bir yazı yerleştirme standardı olarak kullanılır ve genellikle tasarımları test etmek veya metin yerleştirmek için kullanılır.',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Country : United States',
                    style: TextStyle(fontSize: 18 , color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Category : Drama, Science Fiction',
                    style: TextStyle(fontSize: 18 , color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Data Release : ${widget.Movie.releaseDate ?? 'Unknown'}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Cast : Tim Robbins, Rebbeca Ferguson, Avi Nash, Rashinda Jones, David , Tim Robbins',
                    style: TextStyle(fontSize: 18 , color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
