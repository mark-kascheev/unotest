import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/bloc/quizzes_manager_bloc.dart';
import 'package:unotest/domain/model/quiz.dart';
import 'package:unotest/view/quiz_page.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main_page';

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizzesManagerBloc, QuizzesManagerState>(
      listener: (context, state) {
        if(state is QuizzesManagerOpenQuiz) {
          Navigator.pushNamed(context, QuizPage.routeName, arguments: state.quiz);
        }
      },
      child: SafeArea(child: Scaffold(body:
          BlocBuilder<QuizzesManagerBloc, QuizzesManagerState>(
              builder: (context, state) {
        if (state is QuizzesManagerInitial) {
          final quizzes = state.quizzes;
          return ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) => _QuizItem(quizzes[index]));
        }
        return const SizedBox();
      }))),
    );
  }
}

class _QuizItem extends StatelessWidget {
  const _QuizItem(this.quiz, {Key? key}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          BlocProvider.of<QuizzesManagerBloc>(context).add(QuizzesManagerQuizOpened(quiz));
        },
        child: SizedBox(
            height: 50,
            child: Text(quiz.title)
        )
    );
  }
}
