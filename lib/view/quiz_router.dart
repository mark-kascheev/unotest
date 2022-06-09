import 'package:flutter/material.dart';
import 'package:unotest/view/main_page.dart';
import 'package:unotest/view/question_page.dart';

class QuizRouter {
  static MaterialPageRoute? onRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case QuestionPage.routeName:
        return MaterialPageRoute(builder: (context) => const QuestionPage());
    }

    return null;
  }
}
