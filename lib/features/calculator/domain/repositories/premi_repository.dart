import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/features/calculator/domain/entities/premi_user_result.dart';
import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PremiRepository {
  Future<Either<Failure, List<Datum>>> getProductList() {
    throw UnimplementedError('getProductList not yet implemented');
  }

  Future<Either<Failure, PremiUserResult?>> getPremiUserLast() {
    throw UnimplementedError('getPremiUserLast not yet implemented');
  }

  Future<Either<Failure, Unit>> setPremiUserLast(PremiUserResult result) {
    throw UnimplementedError('setPremiUserLast not yet implemented ');
  }
}
