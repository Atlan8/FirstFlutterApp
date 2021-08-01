import 'package:first_flutter_app/mock/movie_data.dart';
import 'package:first_flutter_app/model/home/movie_model.dart';
import 'package:first_flutter_app/views/base/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key
  }): super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> movies = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 5));
    movies = List.of(allMovies);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: isLoading ? 5 : movies.length,
        itemBuilder: (context, index) {
          if (isLoading) {
            return buildMovieShimmer();
          } else {
            final movie = movies[index];
            return buildMovieList(movie);
          }
        }
    );
  }

  Widget buildMovieList(MovieModel model) =>
      ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(model.urlImg),
        ),
        title: Text(model.title, style: TextStyle(fontSize: 16),),
        subtitle: Text(
          model.detail, style: TextStyle(fontSize: 14), maxLines: 1,
        ),
      );

  Widget buildMovieShimmer() =>
      ListTile(
        leading: CustomWidget.circular(height: 64, width: 64,),
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomWidget.rectangular(height: 16, width: MediaQuery.of(context).size.width * 0.3,),
        ),
        subtitle: CustomWidget.rectangular(height: 14),
      );
}