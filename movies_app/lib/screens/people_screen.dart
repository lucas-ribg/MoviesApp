import 'package:flutter/material.dart';
import 'package:movies_app/screens/people_details_screen.dart';
import 'package:movies_app/services/tmdb_service.dart';

class People extends StatefulWidget {
  const People({super.key});

  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  TMDBService tmdb = TMDBService();
  List<Map<String, dynamic>> _results = [];

  @override
  void initState() {
    super.initState();
    _list();
  }

  Future<void> _list() async {
    var resultAux = await tmdb.getTrendingList('person');
    setState(() {
      _results = resultAux;
    });
  }

    void _navigateToDetails(String personId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeopleDetails(id: personId.toString()),
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
                      foregroundImage: NetworkImage(tmdb.getImage(_results[index]['profile_path'])),
                    ),
                    title: Text(_results[index]['name']),
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