import 'dart:developer';

import 'package:calculator_agen/core/database/db_hive.dart';
import 'package:calculator_agen/core/failures/failures.dart';
import 'package:calculator_agen/features/calculator/data/datasource/local/premi_data_source.dart';
import 'package:calculator_agen/features/calculator/data/models/premi_user_result_model.dart';
import 'package:calculator_agen/features/calculator/domain/entities/premi_user_result.dart';
import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:calculator_agen/features/calculator/domain/repositories/premi_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PremiRepoImpl implements PremiRepository {
  final PremiDataSource _localDatasource;

  PremiRepoImpl({required PremiDataSource localDatasource})
      : _localDatasource = localDatasource;

  @override
  Future<Either<Failure, List<Datum>>> getProductList() async {
    try {
      final result = await _localDatasource.getProductList();

      final data = result.data;

      log('manggil data ${data.first}');

      return Right(data);
    } on Failure catch (e) {
      log('manggil data  error ${e.message}');
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, PremiUserResult?>> getPremiUserLast() async {
    try {
      final result = _localDatasource.getListPremiUserResult();

      return Right(result);
    } on Failure catch (e) {
      log('manggil data  error ${e.message}');
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> setPremiUserLast(PremiUserResult result) async {
    log('masuk sini add lokal ');

    try {
      log('masuk sini add lokal try');
      final data = PremiUserResultModel(
          productId: result.productId,
          productName: result.productName,
          age: result.age,
          up: result.up,
          occupationalClass: result.occupationalClass,
          paymentFrequency: result.paymentFrequency,
          longitude: result.longitude,
          latitude: result.latitude,
          calculatedPremium: result.calculatedPremium,
          timestamp: result.timestamp);
      await _localDatasource.savePremiUserResult(data);
      final saved = Hive.box(DbHive.premiResult).get('list_result');
      print('Just saved → type = ${saved.runtimeType}, value = $saved');

      return const Right(unit);
    } on Failure catch (e) {
      log('manggil data  error ${e.message}');
      return Left(e);
    }
  }
}
