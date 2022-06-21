import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/domain/model/question.dart';
import 'package:unotest/domain/model/quiz.dart';

class QuizCreationBloc extends Bloc<QuizCreationEvent, QuizCreationState> {
  QuizCreationBloc() : super(QuizCreationState(Quiz.empty())) {
    on<QuizCreationTitleEntered>(_updateTitle);
    on<QuizCreationDescriptionEntered>(_updateDescription);
    on<QuizCreationQuestionAdded>(_addQuestion);
    on<QuizCreationQuestionSaved>(_saveQuestion);
    on<QuizCreationQuestionEdited>(_editQuestion);
  }

  void _updateTitle(QuizCreationTitleEntered event, Emitter emit) {
    final newTitle = event.title.trim();
  }

  void _updateDescription(QuizCreationDescriptionEntered event, Emitter emit) {
    final newDescription = event.description.trim();
  }

  void _addQuestion(QuizCreationQuestionAdded event, Emitter emit) {
    emit(QuizCreationOpenNew(state.quiz));
  }

  void _saveQuestion(QuizCreationQuestionSaved event, Emitter emit) {
    final questions = state.quiz.questions;
    final editedQuestion = event.question;

    if (questions.contains(editedQuestion)) {
      final index = questions.indexOf(editedQuestion);
      questions[index] = editedQuestion;
    } else {
      questions.add(event.question);
    }
    emit(QuizCreationState(state.quiz));
  }

  void _editQuestion(QuizCreationQuestionEdited event, Emitter emit) {
    emit(QuizCreationEditQuestion(
        quiz: state.quiz, question: event.editableQuestion));
  }
}

abstract class QuizCreationEvent extends Equatable {}

class QuizCreationTitleEntered extends QuizCreationEvent {
  final String title;

  QuizCreationTitleEntered(this.title);

  @override
  List<Object?> get props => [title];
}

class QuizCreationDescriptionEntered extends QuizCreationEvent {
  final String description;

  QuizCreationDescriptionEntered(this.description);

  @override
  List<Object?> get props => [description];
}

class QuizCreationQuestionAdded extends QuizCreationEvent {
  @override
  List<Object?> get props => [];
}

class QuizCreationQuestionEdited extends QuizCreationEvent {
  final Question editableQuestion;

  QuizCreationQuestionEdited(this.editableQuestion);

  @override
  List<Object?> get props => [editableQuestion];
}

class QuizCreationQuestionSaved extends QuizCreationEvent {
  final Question question;

  QuizCreationQuestionSaved(this.question);

  @override
  List<Object?> get props => [question];
}

class QuizCreationState extends Equatable {
  final Quiz quiz;

  const QuizCreationState(this.quiz);

  @override
  List<Object?> get props => [quiz];
}

class QuizCreationOpenNew extends QuizCreationState {
  const QuizCreationOpenNew(super.quiz);

  @override
  List<Object?> get props => [quiz];
}

class QuizCreationEditQuestion extends QuizCreationState {
  final Question question;

  const QuizCreationEditQuestion({required this.question, required Quiz quiz})
      : super(quiz);

  @override
  List<Object?> get props => [quiz];
}
