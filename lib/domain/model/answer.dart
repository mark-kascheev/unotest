import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer.freezed.dart';

@freezed
class Answer with _$Answer {
  const factory Answer({required String id, required String text}) = _Answer;

  factory Answer.empty() =>
      _Answer(id: DateTime.now().millisecondsSinceEpoch.toString(), text: '');
}
