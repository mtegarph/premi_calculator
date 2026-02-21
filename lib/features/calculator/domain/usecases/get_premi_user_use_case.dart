import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/core/use_case/use_cases.dart';
import 'package:calculator_agen/features/calculator/domain/entities/premi_user_result.dart';
import 'package:calculator_agen/features/calculator/domain/repositories/premi_repository.dart';
import 'package:dartz/dartz.dart';

final class GetPremiUser extends UseCase<PremiUserResult?, void> {
  final PremiRepository _repository;

  GetPremiUser(this._repository);

  @override
  Future<Either<Failure, PremiUserResult?>> processCall(void params) async {
    return _repository.getPremiUserLast();
  }
}
