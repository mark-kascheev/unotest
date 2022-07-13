import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unotest/domain/model/question.dart';
import 'package:unotest/domain/model/quiz.dart';

class QuizzesManagerBloc
    extends Bloc<QuizzesManagerEvent, QuizzesManagerState> {
  QuizzesManagerBloc() : super(QuizzesManagerInitial(_mockQuizzes())) {
    on<QuizzesManagerQuizOpened>(_openQuiz);
  }

  void _openQuiz(QuizzesManagerQuizOpened event, Emitter emit) {
    emit(QuizzesManagerOpenQuiz(event.quiz));
  }

  static List<Quiz> _mockQuizzes() {
    final quiz1 = const Quiz(
        id: 'mock_1',
        title: 'test_title_1',
        description: 'test_description_1',
        questions: [Question(id: '', statement: 'question_test_1', correctAnswersId: [], answers: [])]);
    final quiz2 = Quiz(
        id: 'mock_2',
        title: 'test_title_2',
        description: 'test_description_2',
        questions: [Question.empty()]);
    final quiz3 = Quiz(
        id: 'mock_3',
        title: 'test_title_3',
        description: 'test_description_3',
        questions: [Question.empty()]);
    return [quiz1, quiz2, quiz3];
  }
}

class QuizzesManagerEvent {}

class QuizzesManagerQuizOpened extends QuizzesManagerEvent {
  final Quiz quiz;

  QuizzesManagerQuizOpened(this.quiz);
}

class QuizzesManagerState {}

class QuizzesManagerInitial extends QuizzesManagerState {
  final List<Quiz> quizzes;

  QuizzesManagerInitial(this.quizzes);
}

class QuizzesManagerOpenQuiz extends QuizzesManagerState {
  final Quiz quiz;

  QuizzesManagerOpenQuiz(this.quiz);
}
