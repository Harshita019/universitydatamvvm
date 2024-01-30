import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model.dart';



class ViewModel {
  Future<List<Model>> getData() async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=United+States'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Model.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
