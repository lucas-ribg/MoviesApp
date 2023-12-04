import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TMDBService {
  static const String _baseUrl = 'https://api.themoviedb.org/3/';
  static const String _imageUrl = 'https://image.tmdb.org/t/p/w200';
  static final String? _apiKey = dotenv.env['API_KEY'];
  static final String? _apiToken = dotenv.env['API_TOKEN'];
  final Map<String, String> _headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $_apiToken',
  };

  Future<List<Map<String, dynamic>>> getSearchResults(String type, String keyword) async {
    var url = '$_baseUrl/search/$type?include_adult=false&language=en-US&page=1&query=$keyword';
    final response = await http.get(Uri.parse(url), headers: _headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(data['results']);
      return results;
    } else {
      throw Exception('Erro');
    }
  }

  Future<List<Map<String, dynamic>>> getTrendingList(String type) async {
    final response = await http.get(Uri.parse('$_baseUrl/trending/$type/day?language=en-US'), headers: _headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(data['results']);
      return results;
    } else {
      throw Exception('Erro');
    }
  }

  Future<Map<String, dynamic>> getDetails(String type, String id) async {
    final response = await http.get(Uri.parse('$_baseUrl$type/$id'), headers: _headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> details = Map<String, dynamic>.from(data);
      return details;
    } else {
      throw Exception('Erro');
    }
  }

  String getImage(String? path) {
    if (path != null && path.isNotEmpty) {
      return _imageUrl + path;
    } else {
      return 'https://www.themoviedb.org/assets/2/apple-touch-icon-cfba7699efe7a742de25c28e08c38525f19381d31087c69e89d6bcb8e3c0ddfa.png';
    }
  }
}