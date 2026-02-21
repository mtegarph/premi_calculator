import 'package:freezed_annotation/freezed_annotation.dart';

import 'value_failures.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  String? get code => when(
        unexpectedValueException: (v) => '-1',
        serverException: (code, _) => code,
        storageException: (code, _) => code,
        unauthorized: (code, _) => code,
        forbidden: (code, _) => code,
        sessionEnded: (code, _) => code,
        serviceNotAvailable: (code, _) => code,
        permissionNotGranted: (code, _) => code,
        invalidArgs: (code, _) => code,
        invalidValue: (code, _) => code,
        undoLimitExceed: (code, _) => code,
        unknown: (code, _) => code,
      );

  String get message => when(
        unexpectedValueException: (v) => v.failureMessage ?? v.toString(),
        serverException: (_, message) => message,
        storageException: (_, message) => message,
        unauthorized: (_, message) => message,
        forbidden: (_, message) => message,
        sessionEnded: (_, message) => message,
        serviceNotAvailable: (_, message) => message,
        permissionNotGranted: (_, message) => message,
        invalidArgs: (_, message) => message,
        invalidValue: (_, message) => message,
        undoLimitExceed: (_, message) => message,
        unknown: (_, message) => message,
      );

  @Implements<Exception>()
  const factory Failure.unexpectedValueException(ValueFailure valueFailure) =
      FailureUnexpectedValueException;

  @Implements<Exception>()
  const factory Failure.serverException({
    String? code,
    required String message,
  }) = FailureServerException;

  @Implements<Exception>()
  const factory Failure.storageException({
    String? code,
    required String message,
  }) = FailureStorageException;

  @Implements<Exception>()
  const factory Failure.unauthorized({
    String? code,
    required String message,
  }) = FailureUnauthorized;

  @Implements<Exception>()
  const factory Failure.forbidden({
    String? code,
    required String message,
  }) = FailureForbidden;

  @Implements<Exception>()
  const factory Failure.sessionEnded({
    String? code,
    required String message,
  }) = FailureSessionEnded;

  @Implements<Exception>()
  const factory Failure.serviceNotAvailable({
    String? code,
    required String message,
  }) = FailureServiceNotAvailable;

  @Implements<Exception>()
  const factory Failure.permissionNotGranted({
    String? code,
    required String message,
  }) = FailurePermissionNotGranted;

  @Implements<Exception>()
  const factory Failure.invalidArgs({
    String? code,
    required String message,
  }) = FailureInvalidArgs;

  @Implements<Exception>()
  const factory Failure.invalidValue({
    String? code,
    required String message,
  }) = FailureInvalidValue;

  @Implements<Exception>()
  const factory Failure.undoLimitExceed({
    String? code,
    required String message,
  }) = FailureUndoLimitExceed;

  @Implements<Exception>()
  const factory Failure.unknown({
    String? code,
    required String message,
  }) = FailureUnknown;
}
