import 'package:flutter/material.dart';
import 'package:unotest/view/main_page.dart';
import 'package:unotest/view/question_page.dart';

import '../domain/model/question.dart';

class QuizRouter {
  static MaterialPageRoute? onRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case QuestionPage.routeName:
        final question = (settings.arguments ?? Question.empty()) as Question;
        return MaterialPageRoute(builder: (context) => QuestionPage(question));
    }
    return null;
  }
}
