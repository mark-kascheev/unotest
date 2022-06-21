import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/domain/model/answer.dart';
import 'package:unotest/domain/model/question.dart';

class QuestionCreationBloc
    extends Bloc<QuestionCreationEvent, QuestionCreationState> {
  QuestionCreationBloc(Question question) : super(QuestionCreationState(question)) {
    on<QuestionCreationStatementEntered>(_updateQuestionText);
    on<QuestionCreationAnswerAdded>(_addNewAnswer);
    on<QuestionCreationAnswerChanged>(_checkCorrectness);
    on<QuestionCreationTextAnswerChanged>(_updateAnswerText);
    on<QuestionCreationSaved>(_validateQuestion);
  }

  void _updateQuestionText(
      QuestionCreationStatementEntered event, Emitter emit) {
    emit(QuestionCreationState(state.question.copyWith(statement: event.text)));
  }

  void _addNewAnswer(QuestionCreationAnswerAdded event, Emitter emit) {
    state.question.answers.add(Answer.empty());
    emit(QuestionCreationState(state.question));
  }

  void _checkCorrectness(QuestionCreationAnswerChanged event, Emitter emit) {
    final answerIsCorrect = event.isCorrect;
    if (answerIsCorrect) {
      state.question.correctAnswersId.add(event.answerId);
    } else {
      state.question.correctAnswersId.remove(event.answerId);
    }
    emit(QuestionCreationState(state.question));
  }

  void _updateAnswerText(
      QuestionCreationTextAnswerChanged event, Emitter emit) {
    final answers = state.question.answers;
    for (var i = 0; i < answers.length; i++) {
      final answer = answers[i];
      if (answer.id == event.answerId) {
        answers[i] = answer.copyWith(text: event.newText);
      }
    }
    emit(QuestionCreationState(state.question));
  }

  void _validateQuestion(QuestionCreationSaved event, Emitter emit) {
    final errorList = <QuestionError>[];
    final question = state.question;

    if (question.statement.isEmpty) {
      errorList.add(QuestionError.missingStatement);
    }
    if (question.answers.length < 2) {
      errorList.add(QuestionError.emptyAnswers);
    } else if (question.correctAnswersId.isEmpty) {
      errorList.add(QuestionError.noOneCorrectAnswer);
    }
    if (findEmptyAnswerContent()) {
      errorList.add(QuestionError.someAnswerWithOutContent);
    }

    emit(errorList.isNotEmpty
        ? QuestionCreationSaveFailure(errorList, question)
        : QuestionCreationSaveSuccess(question));
  }

  bool findEmptyAnswerContent() {
    return state.question.answers.any((answer) => answer.text.isEmpty);
  }
}

enum QuestionError {
  missingStatement,
  emptyAnswers,
  noOneCorrectAnswer,
  someAnswerWithOutContent
}

abstract class QuestionCreationEvent {}

class QuestionCreationStatementEntered extends QuestionCreationEvent {
  final String text;

  QuestionCreationStatementEntered(this.text);
}

class QuestionCreationAnswerAdded extends QuestionCreationEvent {}

class QuestionCreationTextAnswerChanged extends QuestionCreationEvent {
  final String answerId;
  final String newText;

  QuestionCreationTextAnswerChanged(
      {required this.answerId, required this.newText});
}

class QuestionCreationAnswerChanged extends QuestionCreationEvent {
  final String answerId;
  final bool isCorrect;

  QuestionCreationAnswerChanged(
      {required this.answerId, required this.isCorrect});
}

class QuestionCreationSaved extends QuestionCreationEvent {}

class QuestionCreationState {
  final Question question;

  const QuestionCreationState(this.question);
}

class QuestionCreationSaveSuccess extends QuestionCreationState {
  QuestionCreationSaveSuccess(super.question);
}

class QuestionCreationSaveFailure extends QuestionCreationState {
  final List<QuestionError> errors;

  QuestionCreationSaveFailure(this.errors, super.question);
}
