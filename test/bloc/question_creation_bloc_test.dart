import 'package:test/test.dart';
import 'package:unotest/bloc/question_creation_bloc.dart';
import 'package:unotest/domain/model/question.dart';

void main() {
  late Question question;
  late QuestionCreationBloc bloc;

  setUp(() {
    question = Question.empty();
    bloc = QuestionCreationBloc(question);
  });

  tearDown(() async {
    await bloc.close();
  });

  test('Update question statement and emit state', () async {
    bloc.add(QuestionCreationStatementEntered('test_statement'));

    bloc.close();
    final lastState = await bloc.stream.last;
    expect(lastState.question.statement, 'test_statement');
  });

  test('Create several new answers and add its to list of the question',
      () async {
    bloc.add(QuestionCreationAnswerAdded());
    bloc.add(QuestionCreationAnswerAdded());

    bloc.close();
    final lastState = await bloc.stream.last;
    expect(lastState.question.answers.length, 2);
  });

  test('Check and uncheck correct answers', () async {
    bloc.add(QuestionCreationAnswerAdded());
    await Future.delayed(const Duration(milliseconds: 50));
    bloc.add(QuestionCreationAnswerAdded());
    await Future.delayed(const Duration(milliseconds: 50));

    final answers = bloc.state.question.answers;

    bloc.add(QuestionCreationAnswerChanged(
        answerId: answers[0].id, isCorrect: true));
    bloc.add(QuestionCreationAnswerChanged(
        answerId: answers[1].id, isCorrect: true));

    await Future.delayed(const Duration(milliseconds: 50));
    expect(bloc.state.question.correctAnswersId, [answers[0].id, answers[1].id]);

    bloc.add(QuestionCreationAnswerChanged(
            answerId: answers[1].id, isCorrect: false));

    await Future.delayed(const Duration(milliseconds: 50));

    final state = bloc.state;
    expect(state.question.correctAnswersId, [answers[0].id]);
  });

  test('Change answer text and emit state', () async {
    bloc.add(QuestionCreationAnswerAdded());
    await Future.delayed(const Duration(milliseconds: 50));
    final answer = bloc.state.question.answers[0];
    bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answer.id));

    bloc.close();
    final state = await bloc.stream.last;
    expect(state.question.answers[0].text, 'test_text');
  });

  group('Validation of the question creation', () {
    test('successful validation', () async {
      // No empty statement
      bloc.add(QuestionCreationStatementEntered('test_statement'));
      // At least two answers
      bloc.add(QuestionCreationAnswerAdded());
      bloc.add(QuestionCreationAnswerAdded());

      await Future.delayed(const Duration(milliseconds: 50));
      final answers = bloc.state.question.answers;

      // One correct answer
      bloc.add(QuestionCreationAnswerChanged(
          answerId: answers[1].id, isCorrect: true));

      // Filled in the answer fields
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[0].id));
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[1].id));

      await Future.delayed(const Duration(milliseconds: 50));

      // Validation
      bloc.add(QuestionCreationSaved());

      bloc.close();
      final state = await bloc.stream.last;

      expect(state.runtimeType, QuestionCreationSaveSuccess);
    });

    test('failure validation: the question with out statement', () async {
      // At least two answers
      bloc.add(QuestionCreationAnswerAdded());
      bloc.add(QuestionCreationAnswerAdded());

      await Future.delayed(const Duration(milliseconds: 50));
      final answers = bloc.state.question.answers;

      // One correct answer
      bloc.add(QuestionCreationAnswerChanged(
          answerId: answers[1].id, isCorrect: true));

      // Filled in the answer fields
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[0].id));
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[1].id));

      await Future.delayed(const Duration(milliseconds: 50));

      // Validation
      bloc.add(QuestionCreationSaved());

      bloc.close();
      final state = await bloc.stream.last;

      expect(state.runtimeType, QuestionCreationSaveFailure);
      expect((state as QuestionCreationSaveFailure).errors, [QuestionError.missingStatement]);
    });

    test('failure validation: the question with out answers', () async {
      // No empty statement
      bloc.add(QuestionCreationStatementEntered('test_statement'));
      // Only one answer
      bloc.add(QuestionCreationAnswerAdded());

      await Future.delayed(const Duration(milliseconds: 50));
      final answers = bloc.state.question.answers;

      // One correct answer
      bloc.add(QuestionCreationAnswerChanged(
          answerId: answers[0].id, isCorrect: true));

      // Filled in the answer fields
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[0].id));

      await Future.delayed(const Duration(milliseconds: 50));

      // Validation
      bloc.add(QuestionCreationSaved());

      bloc.close();
      final state = await bloc.stream.last;

      expect(state.runtimeType, QuestionCreationSaveFailure);
      expect((state as QuestionCreationSaveFailure).errors, [QuestionError.emptyAnswers]);
    });

    test('failure validation: the question with out correct answers', () async {
      // No empty statement
      bloc.add(QuestionCreationStatementEntered('test_statement'));
      // At least two answers
      bloc.add(QuestionCreationAnswerAdded());
      bloc.add(QuestionCreationAnswerAdded());

      await Future.delayed(const Duration(milliseconds: 50));
      final answers = bloc.state.question.answers;

      // Filled in the answer fields
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[0].id));
      bloc.add(QuestionCreationTextAnswerChanged(newText: 'test_text', answerId: answers[1].id));

      await Future.delayed(const Duration(milliseconds: 50));

      // Validation
      bloc.add(QuestionCreationSaved());

      bloc.close();
      final state = await bloc.stream.last;

      expect(state.runtimeType, QuestionCreationSaveFailure);
      expect((state as QuestionCreationSaveFailure).errors, [QuestionError.noOneCorrectAnswer]);
    });

    test('failure validation: empty question', () async {
      // Validation
      bloc.add(QuestionCreationSaved());

      bloc.close();
      final state = await bloc.stream.last;

      expect(state.runtimeType, QuestionCreationSaveFailure);
      expect((state as QuestionCreationSaveFailure).errors, [QuestionError.missingStatement, QuestionError.emptyAnswers]);
    });

    test('failure validation: the question with out filled answers', () async {
      // No empty statement
      bloc.add(QuestionCreationStatementEntered('test_statement'));
      // At least two answers
      bloc.add(QuestionCreationAnswerAdded());
      bloc.add(QuestionCreationAnswerAdded());

      await Future.delayed(const Duration(milliseconds: 50));
      final answers = bloc.state.question.answers;

      // One correct answer
      bloc.add(QuestionCreationAnswerChanged(
          answerId: answers[0].id, isCorrect: true));

      await Future.delayed(const Duration(milliseconds: 50));

      // Validation
      bloc.add(QuestionCreationSaved());

      bloc.close();
      final state = await bloc.stream.last;

      expect(state.runtimeType, QuestionCreationSaveFailure);
      expect((state as QuestionCreationSaveFailure).errors, [QuestionError.someAnswerWithOutContent]);
    });
  });
}
