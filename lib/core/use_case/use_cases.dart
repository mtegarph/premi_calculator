import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/core/use_case/utils.dart';
import 'package:dartz/dartz.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

abstract base class UseCase<Type, Params> {
  const UseCase();

  @visibleForTesting
  Future<Either<Failure, Type>> call(Params params) async {
    try {
      final result = await processCall(params);
      return result;
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unknown(
        message: ensureErrorMessage(e.toString()),
      ));
    }
  }

  Future<Either<Failure, Type>> processCall(Params params);
}

abstract base class UseCaseSync<Type, Params> {
  const UseCaseSync();

  @visibleForTesting
  Either<Failure, Type> call(Params params) {
    try {
      return processCall(params);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unknown(
        message: ensureErrorMessage(e.toString()),
      ));
    }
  }

  Either<Failure, Type> processCall(Params params);
}
