import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unotest/domain/model/question.dart';
import 'package:flutter/foundation.dart';

part 'quiz.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Quiz with _$Quiz{
  const factory Quiz(
      {required final String id,
        required final String title,
        required final String description,
        required final List<Question> questions
        }) = _Quiz;

  factory Quiz.empty() => _Quiz(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: '',
    description: '',
    questions: List.empty(growable: true));
}