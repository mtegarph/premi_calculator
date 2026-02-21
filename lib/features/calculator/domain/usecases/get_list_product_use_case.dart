import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/core/use_case/use_cases.dart';
import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:calculator_agen/features/calculator/domain/repositories/premi_repository.dart';
import 'package:dartz/dartz.dart';

final class GetProductList extends UseCase<List<Datum>, void> {
  final PremiRepository _repository;

  GetProductList(this._repository);

  @override
  Future<Either<Failure, List<Datum>>> processCall(void params) async {
    return _repository.getProductList();
  }
}
