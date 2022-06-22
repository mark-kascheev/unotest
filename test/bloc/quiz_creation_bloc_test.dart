import 'package:flutter_test/flutter_test.dart';
import 'package:unotest/bloc/quiz_creation_bloc.dart';
import 'package:unotest/domain/model/question.dart';

void main() {
  late QuizCreationBloc bloc;

  setUp(() {
    bloc = QuizCreationBloc();
  });

  tearDown(() async {
    await bloc.close();
  });

  test('Update quiz title and emit state', () async {
    bloc.add(QuizCreationTitleEntered('test_title'));

    bloc.close();
    final lastState = await bloc.stream.last;
    expect(lastState.quiz.title, 'test_title');
  });

  test('Update quiz description and emit state', () async {
    bloc.add(QuizCreationDescriptionEntered('test_description'));

    bloc.close();
    final lastState = await bloc.stream.last;
    expect(lastState.quiz.description, 'test_description');
  });

  test('Intention to create new question so emit QuizCreationOpenNew state', () async {
    bloc.add(QuizCreationQuestionAdded());

    bloc.close();
    final lastState = await bloc.stream.last;
    expect(lastState.runtimeType, QuizCreationOpenNew);
  });

  test('Intention to edit existing question so emit QuizCreationEditQuestion state', () async {
    final question = Question.empty();
    bloc.add(QuizCreationQuestionEdited(question));

    bloc.close();
    final lastState = await bloc.stream.last as QuizCreationEditQuestion;
    expect(lastState.question, question);
  });

  test('Receive several questions and add it to question list of the quiz', () async {
    final newQuestion = Question.empty();
    bloc.add(QuizCreationQuestionSaved(newQuestion));
    await Future.delayed(const Duration(milliseconds: 50));

    final anotherNewQuestion = Question.empty();
    bloc.add(QuizCreationQuestionSaved(anotherNewQuestion));

    bloc.close();
    final lastState = await bloc.stream.last;
    expect(lastState.quiz.questions, [newQuestion, anotherNewQuestion]);
  });
}