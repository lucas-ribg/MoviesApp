import 'package:flutter/material.dart';
import 'package:movies_app/services/tmdb_service.dart';

class MovieDetails extends StatefulWidget {
  final String id;

  MovieDetails({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  TMDBService tmdb = TMDBService();
  Map<String, dynamic> _details = {};

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    var detailsAux = await tmdb.getDetails('movie', widget.id);
    setState(() {
      _details = detailsAux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _details.isNotEmpty
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            tmdb.getImage(_details['backdrop_path']),
            fit: BoxFit.cover,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'title: ' + _details['title'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'status: ' + _details['status'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'budget: ' + _details['budget'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'revenue: ' + _details['revenue'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'popularity: ' + _details['popularity'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'overview: ' + _details['overview'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      )
      : const Center(
          child: CircularProgressIndicator(), 
        ),
    );
  }
}