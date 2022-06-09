import 'package:unotest/domain/model/question.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;

  Quiz._(
      {required this.id,
      required this.title,
      this.description = '',
      required this.questions});

  Quiz.empty() :
    id = '',
    title = '',
    description = '',
    questions = [];

  // @override
  // List<Object?> get props => [title, description, questions];
}

extension QuizUtils on Quiz {
  Quiz copyWith({String? title, String? description, List<Question>? questions}) =>
    Quiz._(id: id, title: title ?? this.title, questions: questions ?? this.questions);
}