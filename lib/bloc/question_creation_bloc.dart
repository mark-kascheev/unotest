import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/domain/model/answer.dart';
import 'package:unotest/domain/model/question.dart';

class QuestionCreationBloc
    extends Bloc<QuestionCreationEvent, QuestionCreationState> {
  QuestionCreationBloc()
      : super(QuestionCreationState(Question.empty())) {
    on<QuestionCreationTextEntered>(_updateQuestionText);
    on<QuestionCreationAnswerAdded>(_addNewAnswer);
    on<QuestionCreationAnswerChanged>(_checkCorrectness);
    on<QuestionCreationTextAnswerChanged>(_updateAnswerText);

  }

  void _updateQuestionText(QuestionCreationTextEntered event, Emitter emit) {
    emit(QuestionCreationState(state.question.copyWith(statement: event.text)));
  }

  void _addNewAnswer(QuestionCreationAnswerAdded event, Emitter emit) {
    final answers = state.question.answers;
    answers.add(Answer.empty());
    emit(QuestionCreationState(state.question.copyWith(answers: answers)));
  }

  void _checkCorrectness(QuestionCreationAnswerChanged event, Emitter emit) {
    final answerIsCorrect = event.isCorrect;
    if(answerIsCorrect) {
      state.question.correctAnswersId.add(event.answerId);
    } else {
      state.question.correctAnswersId.remove(event.answerId);
    }
    emit(state);
  }

  void _updateAnswerText(QuestionCreationTextAnswerChanged event, Emitter emit) {
    for(var answer in state.question.answers) {
      if(answer.id == event.answerId) {
        answer.copyWith(text: event.newText);
      }
    }
    emit(state);
  }
}

abstract class QuestionCreationEvent extends Equatable {}

class QuestionCreationTextEntered extends QuestionCreationEvent {
  final String text;

  QuestionCreationTextEntered(this.text);

  @override
  List<Object?> get props => [text];
}

class QuestionCreationAnswerAdded extends QuestionCreationEvent {
  @override
  List<Object?> get props => [];
}

class QuestionCreationTextAnswerChanged extends QuestionCreationEvent {
  final String answerId;
  final String newText;

  QuestionCreationTextAnswerChanged({required this.answerId, required this.newText});

  @override
  List<Object?> get props => [newText];
}

class QuestionCreationAnswerChanged extends QuestionCreationEvent {
  final String answerId;
  final bool isCorrect;

  QuestionCreationAnswerChanged({required this.answerId, required this.isCorrect});

  @override
  List<Object?> get props => [isCorrect];
}

class QuestionCreationState extends Equatable {
  final Question question;

  const QuestionCreationState(this.question);

  @override
  List<Object?> get props => [question];
}
