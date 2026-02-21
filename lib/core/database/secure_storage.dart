import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract final class SecureStorage {
  static Future<FlutterSecureStorage> createInstance() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return FlutterSecureStorage(
      aOptions: const AndroidOptions(),
      iOptions: IOSOptions(accountName: packageInfo.packageName),
    );
  }
}
