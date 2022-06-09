import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:unotest/domain/model/answer.dart';

part 'question.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Question with _$Question {
  const factory Question({
    final String? id,
    final List<String>? userAnswersId,
    required final String statement,
    required final List<Answer> answers,
    required final List<String> correctAnswersId
  }) = _Question;

  factory Question.empty() => _Question(statement: '', answers: List.empty(growable: true), correctAnswersId: List.empty(growable: true));
}

// class Question {
//   final String? id;
//   final List<String>? userAnswersId;
//   final String statement;
//   final List<Answer> answers;
//   final List<String> correctAnswersId;
//
//   Question(
//       {this.id,
//       this.userAnswersId,
//       required this.statement,
//       required this.answers,
//       required this.correctAnswersId});
//
//   Question.empty()
//       : id = '',
//         userAnswersId = [],
//         statement = '',
//         correctAnswersId = [],
//         answers = [];
// }
//
// extension QuestionUtils on Question {
//   Question copyWith(
//           {String? id,
//           String? statement,
//           List<Answer>? answers,
//           List<String>? userAnswersId,
//           List<String>? correctAnswersId}) =>
//       Question(
//           id: id ?? this.id,
//           statement: statement ?? this.statement,
//           answers: answers ?? this.answers,
//           userAnswersId: userAnswersId ?? this.userAnswersId,
//           correctAnswersId: correctAnswersId ?? this.correctAnswersId);
// }
