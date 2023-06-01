import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_notes/Bloc/general/general_bloc.dart';
import 'package:keep_notes/Bloc/note/note_bloc.dart';
import 'package:keep_notes/Model/note_model.dart';
import 'package:keep_notes/Screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('keepNote');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteBloc()),
        BlocProvider(create: (context) => GeneralBloc()),
      ],
      child: MaterialApp(
        title: 'Keep Note - Fraved',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
