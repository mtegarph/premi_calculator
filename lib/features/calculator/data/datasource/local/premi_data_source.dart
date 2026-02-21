import 'dart:convert';
import 'dart:developer';

import 'package:calculator_agen/core/database/db_hive.dart';
import 'package:calculator_agen/features/calculator/data/models/premi_user_result_model.dart';
import 'package:calculator_agen/features/calculator/data/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PremiDataSource {
  Future<void> savePremiUserResult(PremiUserResultModel result) {
    throw UnimplementedError(
        'savePremiUserReuslt function not yet been implemented');
  }

  PremiUserResultModel? getListPremiUserResult() {
    throw UnimplementedError('getListPremiUserResult not yet implemented');
  }

  Future<ProductModel> getProductList() {
    throw UnimplementedError('getProductList not yet implemented');
  }
}

class PremiDataSoureImpl implements PremiDataSource {
  static const String _listResult = 'list_result';
  @override
  PremiUserResultModel? getListPremiUserResult() {
    final box = Hive.box(DbHive.premiResult);
    final jsonString = box.get(_listResult);
    log('data save lokal jsonString: $jsonString');

    if (jsonString == null || jsonString is! String || jsonString.isEmpty) {
      return null;
    }

    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return PremiUserResultModel.fromJson(jsonMap);
    } catch (e) {
      log('Gagal decode json: $e');
      return null;
    }
  }

  @override
  Future<void> savePremiUserResult(PremiUserResultModel result) async {
    final box = Hive.box(DbHive.premiResult);
    ////need to be encode so the data can be save as encryption
    final jsonString = jsonEncode(result.toJson());
    log('masuk save sini dengan json string: $jsonString');
    await box.put(_listResult, jsonString);
  }

  @override
  Future<ProductModel> getProductList() async {
    try {
      final response = await rootBundle.loadString('assets/product.json');

      final data = json.decode(response);

      log('Raw JSON type: ${data.runtimeType}');
      log('Keys in root: ${data.keys.toList()}');
      if (data["data"] is List) {
        log('data length: ${(data["data"] as List).length}');
      } else {
        log('Warning: "data" field is not a List → ${data["data"]?.runtimeType}');
      }

      // Create model
      final model = ProductModel.fromJson(data);

      log('Successfully parsed ${model.data.length} products');

      return model;
    } catch (e, stackTrace) {
      log('Error loading/parsing product list: $e');
      log('Stack trace: $stackTrace');

      throw Exception(e.toString());
    }
  }
}
