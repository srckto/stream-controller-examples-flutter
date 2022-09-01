import 'dart:async';

import 'package:stream_examples/contracts/disposable.dart';
import 'package:stream_examples/note/note_model.dart';

class NoteController implements Disposable {
  NoteController() {
    notes = [];
    _notesStreamController.add(notes);
    _addNoteController.stream.listen(_addNote);
    _removeNoteController.stream.listen(_removeNote);
  }

  late List<NoteModel> notes;

  final StreamController<List<NoteModel>> _notesStreamController =
      StreamController<List<NoteModel>>();
  Stream<List<NoteModel>> get notesStream => _notesStreamController.stream;
  StreamSink<List<NoteModel>> get notesSink => _notesStreamController.sink;

  final StreamController<NoteModel> _addNoteController = StreamController<NoteModel>();
  StreamSink<NoteModel> get addNoteSink => _addNoteController.sink;

  final StreamController<NoteModel> _removeNoteController = StreamController<NoteModel>();
  StreamSink<NoteModel> get removeNoteSink => _removeNoteController.sink;

  @override
  void dispose() {
    _notesStreamController.close();
    _addNoteController.close();
    _removeNoteController.close();
  }

  _addNote(NoteModel model) {
    notes.add(model);
    notesSink.add(notes);
  }

  _removeNote(NoteModel model) {
    notes.remove(model);
    notesSink.add(notes);
  }
}
