import 'package:flutter/material.dart';
import 'package:unotest/view/main_page.dart';
import 'package:unotest/view/quiz_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: QuizRouter.onRoute,
      initialRoute: MainPage.routeName,
    );
  }
}
