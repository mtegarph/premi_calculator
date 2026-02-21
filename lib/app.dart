import 'package:calculator_agen/core/router/router.dart';
import 'package:calculator_agen/features/calculator/presentation/bloc/premi_bloc.dart';
import 'package:calculator_agen/injector.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocProvider<PremiBloc>(
      create: (context) => sl()
        ..add(const PremiEvent.getProductListEvent())
        ..add(const PremiEvent.getPremiUserLocal()),
      child: MaterialApp.router(
        title: 'Kenalan',
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('id', 'ID'),
        ],
        locale: ui.PlatformDispatcher.instance.locale,
        themeMode: ThemeMode.light,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaler: mediaQuery.textScaler
                  .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0)),
          child: Stack(
            children: [
              child!,
              // BlocConsumer<LoadingBloc, LoadingState>(
              //   listener: (context, state) => unfocus(context),
              //   builder: (context, state) => state.when(
              //     running: (message) => LoadingScreen(
              //       message: message,
              //       backgroundColor: Colors.black54,
              //     ),
              //     stopped: () => const SizedBox(),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
