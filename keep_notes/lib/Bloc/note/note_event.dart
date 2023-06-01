part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

//Todo: 1.AddNoteFrave
class AddNoteFrave extends NoteEvent {
  final String title;
  final String body;
  final DateTime created;
  final int color;
  final String category;
  final bool isComplete;

  AddNoteFrave({
    required this.title,
    required this.body,
    required this.created,
    required this.color,
    required this.category,
    required this.isComplete,
  });
}

//Todo: 2.SelectedColorEvent: Lựa_chọn_màu
class SelectedColorEvent extends NoteEvent {
  final int color;

  SelectedColorEvent(this.color);
}

//Todo: 3.SelectedCategoryEvent: lựa_chọn_danh_mục
class SelectedCategoryEvent extends NoteEvent {
  final String category;
  final Color colorCategory;

  SelectedCategoryEvent(this.category, this.colorCategory);
}

//Todo: 4.ChangedListToGrid: Thay_đổi_danh_sách
class ChangedListToGrid extends NoteEvent {
  final bool isList;

  ChangedListToGrid(this.isList);
}

//Todo: 5.UpdateNoteEvent: Cập_nhật_danh_sách
class UpdateNoteEvent extends NoteEvent {
  final String title;
  final String body;
  final DateTime created;
  final int color;
  final String category;
  final bool isComplete;
  final int index;

  UpdateNoteEvent({
    required this.title,
    required this.body,
    required this.created,
    required this.color,
    required this.category,
    required this.isComplete,
    required this.index,
  });
}

//Todo: 6.DeleteNoteEvent: Xóa_event
class DeleteNoteEvent extends NoteEvent {
  final int index;

  DeleteNoteEvent(this.index);
}

//Todo: 7.LengthAllNoteEvent
class LengthAllNoteEvent extends NoteEvent {
  final int length;

  LengthAllNoteEvent(this.length);
}
