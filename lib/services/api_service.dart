import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:notesapp/models/get_all_notes_model.dart';

class ApiService {
  // For Android emulator, use 10.0.2.2 instead of localhost
  final String baseUrl =
      'http://10.0.2.2:5001'; // Just the base URL without the path

  Future<List<Note>> getAllNotes() async {
    try {
      final uri =
          Uri.parse('$baseUrl/api/notes'); // This is where I extend the URL

      print('Requesting URL: $uri'); // Debug print

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Success response: ${response.body}'); // Debug print
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Note.fromJson(json)).toList();
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        throw Exception(
            'Failed to load notes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching notes: $e');
      throw Exception('Error fetching notes: $e');
    }
  }
}
