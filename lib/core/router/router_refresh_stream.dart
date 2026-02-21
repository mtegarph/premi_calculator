import 'dart:async';

import 'package:flutter/foundation.dart';

class RouterRefreshStream extends ChangeNotifier {
  RouterRefreshStream(List<Stream> streams) {
    notifyListeners();
    for (final stream in streams) {
      _subscriptions.add(stream.asBroadcastStream().listen(
            (dynamic _) => notifyListeners(),
          ));
    }
  }

  final List<StreamSubscription> _subscriptions = [];

  @override
  void dispose() {
    for (final subs in _subscriptions) {
      subs.cancel();
    }
    super.dispose();
  }
}
