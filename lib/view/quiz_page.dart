import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/bloc/quiz_creation_bloc.dart';
import 'package:unotest/domain/model/question.dart';
import 'package:unotest/domain/model/quiz.dart';
import 'package:unotest/view/question_page.dart';

class QuizPage extends StatelessWidget {
  final Quiz quiz;
  static const String routeName = '/quiz_page';

  const QuizPage(this.quiz, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Title'),
        const SizedBox(height: 10),
        _QuizTextInputField(quiz.title),
        const SizedBox(height: 10),
        const Text('Description (optional)'),
        const SizedBox(height: 10),
        _QuizTextInputField(quiz.description),
        const SizedBox(height: 10),
        const _Questions()
      ],
    )));
  }
}

class _QuizTextInputField extends StatefulWidget {
  final String text;

  const _QuizTextInputField(this.text, {Key? key}) : super(key: key);

  @override
  State<_QuizTextInputField> createState() => _QuizTextInputFieldState();
}

class _QuizTextInputFieldState extends State<_QuizTextInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controller,
        onChanged: (text) => BlocProvider.of<QuizCreationBloc>(context)
            .add(QuizCreationTitleEntered(text)));
  }
}

class _Questions extends StatelessWidget {
  const _Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocListener<QuizCreationBloc, QuizCreationState>(
        listener: (context, state) {
          if (state is QuizCreationOpenNew) {
            Navigator.of(context).pushNamed(QuestionPage.routeName);
          }
          if (state is QuizCreationEditQuestion) {
            Navigator.of(context)
                .pushNamed(QuestionPage.routeName, arguments: state.question);
          }
        },
        child: BlocBuilder<QuizCreationBloc, QuizCreationState>(
            builder: (context, state) {
          return ListView(
            children: [
              ...state.quiz.questions
                  .map((question) => _QuestionItem(question))
                  .toList(),
              const _AddQuestionButton()
            ],
          );
        }),
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final Question question;

  const _QuestionItem(this.question);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<QuizCreationBloc>(context)
            .add(QuizCreationQuestionEdited(question));
      },
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Text('${question.statement}|||${question.id}'),
          ],
        ),
      ),
    );
  }
}

class _AddQuestionButton extends StatelessWidget {
  const _AddQuestionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            context.read<QuizCreationBloc>().add(QuizCreationQuestionAdded()),
        child: const Text('Add question'));
  }
}
