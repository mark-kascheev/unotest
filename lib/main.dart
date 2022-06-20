import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/bloc/quiz_creation_bloc.dart';
import 'package:unotest/view/main_page.dart';
import 'package:unotest/view/quiz_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCreationBloc(),
      child: const MaterialApp(
        onGenerateRoute: QuizRouter.onRoute,
        initialRoute: MainPage.routeName,
      ),
    );
  }
}
