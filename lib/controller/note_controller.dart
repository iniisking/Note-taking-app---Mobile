import 'package:notesapp/models/get_all_notes_model.dart';
import 'package:notesapp/services/api_service.dart';

class NoteController {
  final ApiService _apiService = ApiService();

  Future<List<Note>> getNotes() async {
    try {
      return await _apiService.getAllNotes();
    } catch (e) {
      rethrow;
    }
  }
}
