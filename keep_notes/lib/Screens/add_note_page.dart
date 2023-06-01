import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_notes/Bloc/note/note_bloc.dart';
import 'package:keep_notes/Helper/selected_category.dart';
import 'package:keep_notes/Helper/warning.dart';
import 'package:keep_notes/Widgets/selected_color.dart';
import 'package:keep_notes/Widgets/text_field.dart';
import 'package:keep_notes/Widgets/text_frave.dart';
import 'package:keep_notes/Widgets/text_write_note.dart';

//Todo: AddNotePage: Thêm_Note_Page
class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clearText();
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void clearText() {
    _titleController.clear();
    _noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF2F3F7),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F3F7),
        elevation: 0,
        title: const TextFrave(
          text: 'Add Note',
          fontWeight: FontWeight.w500,
          fontSize: 20,
          isTitle: true,
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Center(
            child: TextFrave(
              text: 'Cancel',
              fontSize: 15,
              color: Color(0xff0C6F2),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (_titleController.text.trim().isNotEmpty &&
                  _noteController.text.trim().isNotEmpty) {
                noteBloc.add(
                  AddNoteFrave(
                    title: _titleController.text,
                    body: _noteController.text,
                    created: DateTime.now(),
                    color: noteBloc.state.color,
                    category: noteBloc.state.category,
                    isComplete: false,
                  ),
                );
                clearText();
                Navigator.pop(context);
              } else {
                modalWarning(context, 'Title and note is Required');
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 60,
              child: const TextFrave(
                text: 'Save',
                fontSize: 15,
                color: Color(0xff0C6CF2),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextTitle(controller: _titleController),
                SizedBox(height: 20),
                TextWriteNote(controller: _noteController),
                SizedBox(height: 20),
                _Category(),
                SizedBox(height: 30),
                SelectedColors(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF6F8F9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextFrave(text: 'Category'),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: 40,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 7, spreadRadius: -5.0),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => showDialogBottomFrave(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<NoteBloc, NoteState>(
                      builder: (_, state) {
                        return Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: state.colorCategory, width: 4.0),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<NoteBloc, NoteState>(
                      builder: (_, state) {
                        return TextFrave(
                          text: state.category,
                          fontWeight: FontWeight.w600,
                        );
                      },
                    ),
                    const Icon(Icons.expand_more)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
