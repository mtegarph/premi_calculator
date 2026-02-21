import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/core/use_case/use_cases.dart';
import 'package:calculator_agen/features/calculator/domain/entities/premi_user_result.dart';
import 'package:calculator_agen/features/calculator/domain/repositories/premi_repository.dart';
import 'package:dartz/dartz.dart';

final class SetPremiUser extends UseCase<Unit, PremiUserResult> {
  final PremiRepository _repository;

  SetPremiUser(this._repository);

  @override
  Future<Either<Failure, Unit>> processCall(PremiUserResult params) async {
    return _repository.setPremiUserLast(params);
  }
}
