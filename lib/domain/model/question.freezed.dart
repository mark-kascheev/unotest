// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Question {
  String? get id => throw _privateConstructorUsedError;
  List<String>? get userAnswersId => throw _privateConstructorUsedError;
  String get statement => throw _privateConstructorUsedError;
  List<Answer> get answers => throw _privateConstructorUsedError;
  List<String> get correctAnswersId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      List<String>? userAnswersId,
      String statement,
      List<Answer> answers,
      List<String> correctAnswersId});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res> implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  final Question _value;
  // ignore: unused_field
  final $Res Function(Question) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userAnswersId = freezed,
    Object? statement = freezed,
    Object? answers = freezed,
    Object? correctAnswersId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userAnswersId: userAnswersId == freezed
          ? _value.userAnswersId
          : userAnswersId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      statement: statement == freezed
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      answers: answers == freezed
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
      correctAnswersId: correctAnswersId == freezed
          ? _value.correctAnswersId
          : correctAnswersId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$$_QuestionCopyWith(
          _$_Question value, $Res Function(_$_Question) then) =
      __$$_QuestionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      List<String>? userAnswersId,
      String statement,
      List<Answer> answers,
      List<String> correctAnswersId});
}

/// @nodoc
class __$$_QuestionCopyWithImpl<$Res> extends _$QuestionCopyWithImpl<$Res>
    implements _$$_QuestionCopyWith<$Res> {
  __$$_QuestionCopyWithImpl(
      _$_Question _value, $Res Function(_$_Question) _then)
      : super(_value, (v) => _then(v as _$_Question));

  @override
  _$_Question get _value => super._value as _$_Question;

  @override
  $Res call({
    Object? id = freezed,
    Object? userAnswersId = freezed,
    Object? statement = freezed,
    Object? answers = freezed,
    Object? correctAnswersId = freezed,
  }) {
    return _then(_$_Question(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userAnswersId: userAnswersId == freezed
          ? _value.userAnswersId
          : userAnswersId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      statement: statement == freezed
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      answers: answers == freezed
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
      correctAnswersId: correctAnswersId == freezed
          ? _value.correctAnswersId
          : correctAnswersId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_Question with DiagnosticableTreeMixin implements _Question {
  const _$_Question(
      {this.id,
      this.userAnswersId,
      required this.statement,
      required this.answers,
      required this.correctAnswersId});

  @override
  final String? id;
  @override
  final List<String>? userAnswersId;
  @override
  final String statement;
  @override
  final List<Answer> answers;
  @override
  final List<String> correctAnswersId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Question(id: $id, userAnswersId: $userAnswersId, statement: $statement, answers: $answers, correctAnswersId: $correctAnswersId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Question'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userAnswersId', userAnswersId))
      ..add(DiagnosticsProperty('statement', statement))
      ..add(DiagnosticsProperty('answers', answers))
      ..add(DiagnosticsProperty('correctAnswersId', correctAnswersId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Question &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.userAnswersId, userAnswersId) &&
            const DeepCollectionEquality().equals(other.statement, statement) &&
            const DeepCollectionEquality().equals(other.answers, answers) &&
            const DeepCollectionEquality()
                .equals(other.correctAnswersId, correctAnswersId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userAnswersId),
      const DeepCollectionEquality().hash(statement),
      const DeepCollectionEquality().hash(answers),
      const DeepCollectionEquality().hash(correctAnswersId));

  @JsonKey(ignore: true)
  @override
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      __$$_QuestionCopyWithImpl<_$_Question>(this, _$identity);
}

abstract class _Question implements Question {
  const factory _Question(
      {final String? id,
      final List<String>? userAnswersId,
      required final String statement,
      required final List<Answer> answers,
      required final List<String> correctAnswersId}) = _$_Question;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  List<String>? get userAnswersId => throw _privateConstructorUsedError;
  @override
  String get statement => throw _privateConstructorUsedError;
  @override
  List<Answer> get answers => throw _privateConstructorUsedError;
  @override
  List<String> get correctAnswersId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      throw _privateConstructorUsedError;
}