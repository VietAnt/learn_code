import 'package:flutter/material.dart';
import 'package:keep_notes/Widgets/text_frave.dart';

//Todo: showModalGridView
void showModalGridView(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.white60,
    useSafeArea: true,
    builder: (context) => AlertDialog(
      content: Container(
        height: 200,
        child: const Column(
          children: [
            TextFrave(text: 'Option'),
          ],
        ),
      ),
    ),
  );
}
