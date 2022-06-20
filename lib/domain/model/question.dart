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