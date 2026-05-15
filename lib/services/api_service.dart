import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';
import '../models/city.dart';
import '../utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<List<dynamic>> search(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/search.php?q=$query'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Country?> getCountry(String code) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/country.php?code=$code'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('error')) return null;
        return Country.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<City?> getCity(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/city.php?id=$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('error')) return null;
        return City.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
