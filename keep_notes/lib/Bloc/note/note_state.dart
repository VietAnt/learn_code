part of 'note_bloc.dart';

@immutable
class NoteState {
  final int color;
  final String category;
  final Color colorCategory;
  final bool isList;
  final int noteLength;

  NoteState({
    this.color = 0xff1977F3,
    this.category = 'No List',
    this.colorCategory = Colors.grey,
    this.isList = true,
    this.noteLength = 0,
  });

  NoteState copyWith({
    int? color,
    String? category,
    Color? colorCategory,
    bool? isList,
    int? noteLength,
  }) =>
      NoteState(
        color: color ?? this.color,
        category: category ?? this.category,
        colorCategory: colorCategory ?? this.colorCategory,
        isList: isList ?? this.isList,
        noteLength: noteLength ?? this.noteLength,
      );
}
