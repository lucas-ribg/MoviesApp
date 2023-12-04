import 'package:flutter/material.dart';
import 'package:movies_app/services/tmdb_service.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _query = '';
  String _type = 'movie';
  String _nameVar = 'original_title';
  String _imageVar = 'poster_path';
  TMDBService tmdb = TMDBService();
  List<Map<String, dynamic>> _results = [];

  Future<void> _search() async {
    var resultAux = await tmdb.getSearchResults(_type, _query);
    setState(() {
      _results = resultAux;
    });
    if (_type == 'movie') {
      setState(() {
        _nameVar = 'original_title';
        _imageVar = 'poster_path';
      });
    }
    if (_type == 'person') {
      setState(() {
        _nameVar = "name";
        _imageVar = "profile_path";
      });
    }
    if (_type == 'tv') {
      setState(() {
        _nameVar = "name";
        _imageVar = "poster_path";
      });
    }
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
            TextField(
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search for',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _query = '';
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRadio('movie', 'Movies'),
                _buildRadio('tv', 'TV'),
                _buildRadio('person', 'People'),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _search,
              icon: const Icon(Icons.search),
              label: const Text('Search'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(tmdb.getImage(_results[index][_imageVar])),
                    ),
                    title: Text(_results[index][_nameVar]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio(String value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _type,
          onChanged: (selectedValue) {
            setState(() {
              _type = selectedValue.toString();
            });
          },
        ),
        Text(label),
      ],
    );
  }
}