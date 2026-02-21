import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.unexpectedLength({
    required T failedValue,
    required int expectedLength,
    String? failureMessage,
  }) = UnexpectedLength<T>;
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
    String? failureMessage,
  }) = ExceedingLength<T>;
  const factory ValueFailure.empty({
    required T failedValue,
    String? failureMessage,
  }) = Empty<T>;
  const factory ValueFailure.invalidStringNumber({
    required T failedValue,
    String? failureMessage,
  }) = InvalidStringNumber<T>;
  const factory ValueFailure.stringMayNotOnlyNumber({
    required T failedValue,
    String? failureMessage,
  }) = StringMayNotOnlyNumber<T>;
  const factory ValueFailure.multiline({
    required T failedValue,
    String? failureMessage,
  }) = Multiline<T>;
  const factory ValueFailure.numberTooLarge({
    required T failedValue,
    required num max,
    String? failureMessage,
  }) = NumberTooLarge<T>;
  const factory ValueFailure.invalidFullname({
    required T failedValue,
    String? failureMessage,
  }) = InvalidFullname<T>;
  const factory ValueFailure.invalidPhoneNumber({
    required T failedValue,
    String? failureMessage,
  }) = InvalidPhoneNumber<T>;
  const factory ValueFailure.invalidEmail({
    required T failedValue,
    String? failureMessage,
  }) = InvalidEmail<T>;
  const factory ValueFailure.invalidOtpCode({
    required T failedValue,
    String? failureMessage,
  }) = InvalidOtpCode<T>;
  const factory ValueFailure.shortPassword({
    required T failedValue,
    String? failureMessage,
  }) = ShortPassword<T>;
  const factory ValueFailure.notMatchPassword({
    required T failedValue,
    String? failureMessage,
  }) = NotMatchPassword<T>;
  const factory ValueFailure.invalidPhotoUrl({
    required T failedValue,
    String? failureMessage,
  }) = InvalidPhotoUrl<T>;
  const factory ValueFailure.underAge({
    required T failedValue,
    String? failureMessage,
  }) = UnderAge<T>;
  const factory ValueFailure.overAge({
    required T failedValue,
    String? failureMessage,
  }) = OverAge<T>;
}
