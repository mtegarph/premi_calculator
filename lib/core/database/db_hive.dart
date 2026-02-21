import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract final class DbHive {
  static const String _securityKey = 'security_key';

  static const String premiResult = 'premi_result';

  static Future<void> init({FlutterSecureStorage? secureStorage}) async {
    await Hive.initFlutter();

    final hiveCipher = await _createHiveCipher(secureStorage);

    await Hive.openBox(premiResult, encryptionCipher: hiveCipher);
  }

  static Future<HiveCipher?> _createHiveCipher([
    FlutterSecureStorage? secureStorage,
  ]) async {
    if (secureStorage == null) return null;

    final key = await secureStorage.read(key: _securityKey);

    late final List<int> securitykey;
    if (key != null) {
      securitykey = base64Url.decode(key);
    } else {
      securitykey = Hive.generateSecureKey();

      await secureStorage.write(
        key: _securityKey,
        value: base64Url.encode(securitykey),
      );
    }

    return HiveAesCipher(securitykey);
  }
}
