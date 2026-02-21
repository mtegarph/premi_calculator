// ignore_for_file: depend_on_referenced_packages

import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:calculator_agen/features/calculator/presentation/pages/premi_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:calculator_agen/features/calculator/presentation/pages/product_list_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

late bool appStatingUp;
final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: '/premi-calculator',
        builder: (context, state) => PremiCalculator(
          data: state.extra as Datum,
        ),
      ),
    ]);
