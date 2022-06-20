import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/domain/model/question.dart';
import 'package:unotest/domain/model/quiz.dart';

class QuizCreationBloc extends Bloc<QuizCreationEvent, QuizCreationState> {
  QuizCreationBloc() : super(QuizCreationState(Quiz.empty())) {
    on<QuizCreationTitleEntered>(_updateTitle);
    on<QuizCreationDescriptionEntered>(_updateDescription);
    on<QuizCreationQuestionAdded>(_addQuestion);
    on<QuizCreationQuestionSaved>(_saveNewQuestion);
  }

  void _updateTitle(QuizCreationTitleEntered event, Emitter emit) {
    final newTitle = event.title.trim();
  }

  void _updateDescription(QuizCreationDescriptionEntered event, Emitter emit) {
    final newDescription = event.description.trim();
  }

  void _addQuestion(QuizCreationQuestionAdded event, Emitter emit) {
    emit(QuizCreationOpenNew(Quiz.empty()));
  }

  void _saveNewQuestion(QuizCreationQuestionSaved event, Emitter emit) {
    state.quiz.questions.add(event.question);
    emit(state);
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
  const QuizCreationOpenNew(Quiz quiz) : super(quiz);

  @override
  List<Object?> get props => [];
}
