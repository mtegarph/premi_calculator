import 'package:calculator_agen/app.dart';
import 'package:calculator_agen/injector.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocator();
  runApp(const App());
}
