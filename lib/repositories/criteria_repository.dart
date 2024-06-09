import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/criteria.dart';

class CriteriaRepository {
  Future<List<Criteria>> fetchCriteria() async {
    final url =
        'https://api.allorigins.win/get?url=http://coding-assignment.bombayrunning.com/data.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // The response body from allorigins is wrapped, so we need to decode twice
        final jsonResponse = json.decode(response.body);
        final data = json.decode(jsonResponse['contents']);
        return data
            .map<Criteria>((criteria) => Criteria.fromJson(criteria))
            .toList();
      } else {
        throw Exception('Failed to load criteria: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception('Couldn\'t find the criteria');
    } on FormatException {
      throw Exception('Bad response format');
    }
  }
}
