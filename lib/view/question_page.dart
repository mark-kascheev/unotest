import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/bloc/question_creation_bloc.dart';
import 'package:unotest/bloc/quiz_creation_bloc.dart';
import 'package:unotest/domain/model/answer.dart';
import 'package:unotest/domain/model/question.dart';

class QuestionPage extends StatelessWidget {
  static const String routeName = '/question_page';

  final Question question;

  const QuestionPage(this.question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QuestionCreationBloc(question),
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                leading: TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                backgroundColor: Colors.orange,
                actions: const [_SaveButton()],
              ),
              body: BlocListener<QuestionCreationBloc, QuestionCreationState>(
                  listener: (context, state) {
                    if (state is QuestionCreationSaveSuccess) {
                      BlocProvider.of<QuizCreationBloc>(context)
                          .add(QuizCreationQuestionSaved(state.question));
                      Navigator.of(context).pop();
                    }
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _QuestionText(question.statement),
                        SizedBox(height: 10),
                        _Errors(),
                        _AddAnswerButton(),
                        _Answers()
                      ])))),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text('Save'),
        onPressed: () {
          BlocProvider.of<QuestionCreationBloc>(context)
              .add(QuestionCreationSaved());
        });
  }
}

class _QuestionText extends StatefulWidget {
  final String statement;

  const _QuestionText(this.statement, {Key? key}) : super(key: key);

  @override
  State<_QuestionText> createState() => _QuestionTextState();
}

class _QuestionTextState extends State<_QuestionText> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.statement;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (statement) => BlocProvider.of<QuestionCreationBloc>(context)
          .add(QuestionCreationStatementEntered(statement)),
    );
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

class _AnswerForm extends StatefulWidget {
  final Answer answer;
  final bool isCorrect;

  const _AnswerForm({Key? key, required this.answer, required this.isCorrect})
      : super(key: key);

  @override
  State<_AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends State<_AnswerForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.answer.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: widget.isCorrect,
            onChanged: (value) {
              if (value != null) {
                BlocProvider.of<QuestionCreationBloc>(context).add(
                    QuestionCreationAnswerChanged(
                        answerId: widget.answer.id, isCorrect: value));
              }
            }),
        Expanded(
            child: TextField(
                controller: _controller,
                onChanged: (text) =>
                    BlocProvider.of<QuestionCreationBloc>(context).add(
                        QuestionCreationTextAnswerChanged(
                            answerId: widget.answer.id, newText: text))))
      ],
    );
  }
}

class _Errors extends StatelessWidget {
  const _Errors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionCreationBloc, QuestionCreationState>(
        buildWhen: (previous, current) {
      if (current is QuestionCreationSaveFailure ||
          current is QuestionCreationSaveSuccess) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is QuestionCreationSaveFailure) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...state.errors.map((error) => _Error(error)).toList()],
        );
      }
      return const SizedBox();
    });
  }
}

class _Error extends StatelessWidget {
  final QuestionError error;

  const _Error(this.error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorText = '';
    switch (error) {
      case QuestionError.missingStatement:
        errorText = 'Statement is missing';
        break;
      case QuestionError.noOneCorrectAnswer:
        errorText = 'Select one correct answer';
        break;
      case QuestionError.someAnswerWithOutContent:
        errorText = 'Fill answer text';
        break;
      case QuestionError.emptyAnswers:
        errorText = 'Add at least two answers';
        break;
    }
    return Text(errorText, style: const TextStyle(color: Colors.red));
  }
}
