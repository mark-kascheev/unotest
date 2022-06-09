import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/domain/model/quiz.dart';

class QuizCreationBloc extends Bloc<QuizCreationEvent, QuizCreationState> {
  QuizCreationBloc() : super(QuizCreationState(Quiz.empty())) {
    on<QuizCreationTitleEntered>(_updateTitle);
    on<QuizCreationDescriptionEntered>(_updateDescription);
    on<QuizCreationQuestionAdded>(_addQuestion);
  }

  void _updateTitle(QuizCreationTitleEntered event, Emitter emit) {
    final newDescription = event.title.trim();
  }

  void _updateDescription(QuizCreationDescriptionEntered event, Emitter emit) {
    final newDescription = event.description.trim();
  }

  void _addQuestion(QuizCreationQuestionAdded event, Emitter emit) {
    emit(QuizCreationOpenNew(Quiz.empty()));
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
