import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:keep_notes/Model/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState()) {
    on<AddNoteFrave>(_addNewNote);
    on<SelectedColorEvent>(_selectedColor);
    on<SelectedCategoryEvent>(_selectedCategory);
    on<ChangedListToGrid>(_changedListToGrid);
    on<UpdateNoteEvent>(_updateNote);
    on<DeleteNoteEvent>(_deleteNote);
    on<LengthAllNoteEvent>(_lengthAllNote);
  }

  //Todo: 1._addNewNote:
  Future<void> _addNewNote(AddNoteFrave event, Emitter<NoteState> emit) async {
    var box = Hive.box<NoteModel>('keepNote');

    var noteModel = NoteModel(
      title: event.title,
      body: event.body,
      color: event.color,
      isComplete: event.isComplete,
      category: event.category,
      created: DateTime.now(),
    );
    box.add(noteModel);
  }

  //Todo: 2.selectedColor
  Future<void> _selectedColor(
      SelectedColorEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(color: event.color));
  }

  //Todo: 3.selectedCategory
  Future<void> _selectedCategory(
      SelectedCategoryEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(
        category: event.category, colorCategory: event.colorCategory));
  }

  //Todo: 4.changeListGird
  Future<void> _changedListToGrid(
      ChangedListToGrid event, Emitter<NoteState> emit) async {
    emit(state.copyWith(isList: event.isList));
  }

  //Todo: 5.updateNote
  Future<void> _updateNote(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    var box = Hive.box<NoteModel>('keepNote');

    var noteModel = NoteModel(
      title: event.title,
      body: event.body,
      color: event.color,
      isComplete: event.isComplete,
      category: event.category,
      created: event.created,
    );
    box.putAt(event.index, noteModel);
  }

  //Todo: 6.deleteNote
  Future<void> _deleteNote(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    var box = Hive.box<NoteModel>('keepNote');

    box.delete(event.index);
  }

  //Todo: 7.lengthAllNote
  Future<void> _lengthAllNote(
      LengthAllNoteEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(noteLength: event.length));
  }
}
