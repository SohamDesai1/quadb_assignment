import 'package:flutter/material.dart';
import 'package:quadb_assignment/detail_page.dart';
import 'package:quadb_assignment/widgets/card.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _search = TextEditingController();
  bool isSearchPressed = false;
  List<String> movies = [];
  List<String> thumbnails = [];
  List<String> descs = [];
  List<String> status = [];
  List<String> type = [];
  List<String> image = [];
  List<String> date = [];

  Future<Tuple3<List<String>, List<String>, List<String>>> fetch() async {
    var apiURL = "https://api.tvmaze.com/search/shows?q=${_search.text}";
    final res = await http.get(Uri.parse(apiURL));
    final data = json.decode(res.body);
    movies = List<String>.from(data.map((e) => e["show"]["name"]));
    type = List<String>.from(data.map((e) => e["show"]["type"]));
    status = List<String>.from(data.map((e) => e["show"]["status"]));
    for (var q = 0; q < data.length && data[q]["show"]["image"] != null; q++) {
      String description = data[q]["show"]["summary"];
      final document = html_parser.parse(description);
      String plainText = document.body!.text;
      List<String> lines = plainText.split('\n');
      var desc = lines.length > 1 ? '${lines[0]}\n${lines[1]}' : plainText;
      descs.add(desc);
      String photo = data[q]["show"]["image"]["medium"];
      thumbnails.add(photo);
      image.add(data[q]["show"]["image"]["original"]);
    }
    setState(() {
      isSearchPressed = true;
    });
    // log(thumbnails.length.toString());
    return Tuple3<List<String>, List<String>, List<String>>(
        movies, descs, thumbnails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 85.w,
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () => fetch(),
                          child: const Icon(Icons.search)),
                      hintText: "Search"),
                ),
              ),
            ),
            Visibility(
              visible: isSearchPressed,
              child: results(),
            )
          ],
        ),
      ),
    );
  }

  Widget results() {
    return FutureBuilder<Tuple3<List<String>, List<String>, List<String>>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movies = snapshot.data!.item1;
            var desc = snapshot.data!.item2;
            var thumbnail = snapshot.data!.item3;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    for (var j = 0; j < thumbnail.length; j += 3)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => DetailPage(
                                              mname: movies[j],
                                              desc: desc[j],
                                              status: status[j],
                                              image: image[j],
                                              type: type[j],
                                            ))),
                                child: MovieCard(
                                  image: thumbnail[j],
                                  name: movies[j],
                                  desc: "${desc[j]}...",
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => DetailPage(
                                              mname: movies[j + 1],
                                              desc: desc[j + 1],
                                              status: status[j + 1],
                                              image: image[j + 1],
                                              type: type[j + 1],
                                            ))),
                                child: MovieCard(
                                  image: thumbnail[j + 1],
                                  name: movies[j + 1],
                                  desc: "${desc[j + 1]}...",
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => DetailPage(
                                              mname: movies[j + 2],
                                              desc: desc[j + 2],
                                              status: status[j + 2],
                                              image: image[j + 2],
                                              type: type[j + 2],
                                            ))),
                                child: MovieCard(
                                  image: thumbnail[j + 2],
                                  name: movies[j + 2],
                                  desc: "${desc[j + 2]}...",
                                ),
                              ),
                              if (thumbnails.length % 2 == 0)
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (_) => DetailPage(
                                                mname: movies[
                                                    thumbnails.length - 1],
                                                desc:
                                                    desc[thumbnails.length - 1],
                                                status: status[
                                                    thumbnails.length - 1],
                                                image: image[
                                                    thumbnails.length - 1],
                                                type:
                                                    type[thumbnails.length - 1],
                                              ))),
                                  child: MovieCard(
                                    image: thumbnail[thumbnails.length - 1],
                                    name: movies[thumbnails.length - 1],
                                    desc: "${desc[thumbnails.length - 1]}...",
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          )
                        ],
                      ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
                child: SnackBar(content: Text("Error fetching Movies")));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
