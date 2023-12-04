import 'package:flutter/material.dart';
import 'package:movies_app/screens/movies_details_screen.dart';
import 'package:movies_app/services/tmdb_service.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  TMDBService tmdb = TMDBService();
  List<Map<String, dynamic>> _results = [];

  @override
  void initState() {
    super.initState();
    _list();
  }

  Future<void> _list() async {
    var resultAux = await tmdb.getTrendingList('movie');
    setState(() {
      _results = resultAux;
    });
  }

  void _navigateToDetails(String movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetails(id: movieId.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _navigateToDetails(_results[index]['id'].toString());
                    },
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(tmdb.getImage(_results[index]['poster_path'])),
                    ),
                    title: Text(_results[index]['original_title']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}