import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/bloc/question_creation_bloc.dart';
import 'package:unotest/domain/model/answer.dart';

class QuestionPage extends StatelessWidget {
  static const String routeName = '/question_page';

  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QuestionCreationBloc(),
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                leading: TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                backgroundColor: Colors.orange,
                actions: [TextButton(child: Text('Save'), onPressed: () {})],
              ),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _QuestionText(),
                    SizedBox(height: 10),
                    _AddAnswerButton(),
                    _Answers()
                  ]))),
    );
  }
}

class _QuestionText extends StatelessWidget {
  const _QuestionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField();
  }
}

class _Answers extends StatelessWidget {
  const _Answers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(child:
        BlocBuilder<QuestionCreationBloc, QuestionCreationState>(
            builder: (context, state) {
      final correctAnswers = state.question.correctAnswersId;
      final answers = state.question.answers;
      return ListView.builder(
          itemCount: answers.length,
          itemBuilder: (context, index) => _AnswerForm(
              answer: answers[index],
              isCorrect: correctAnswers.contains(answers[index].id)));
    }));
  }
}

class _AddAnswerButton extends StatelessWidget {
  const _AddAnswerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          BlocProvider.of<QuestionCreationBloc>(context)
              .add(QuestionCreationAnswerAdded());
        },
        child: Text('Add answer'));
  }
}

class _AnswerForm extends StatelessWidget {
  final Answer answer;
  final bool isCorrect;

  const _AnswerForm({Key? key, required this.answer, required this.isCorrect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isCorrect,
            onChanged: (value) {
              if (value != null) {
                BlocProvider.of<QuestionCreationBloc>(context).add(
                    QuestionCreationAnswerChanged(
                        answerId: answer.id, isCorrect: value));
              }
            }),
        Expanded(
            child: TextField(
                onChanged: (text) => QuestionCreationTextAnswerChanged(
                    answerId: answer.id, newText: text)))
      ],
    );
  }
}
