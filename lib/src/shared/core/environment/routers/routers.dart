import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/firebase/presentation/pages/firebase_page.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/home_page.dart';

final routers = {
  '/home': (context) => const MyHomePage(),
  '/createFirebase': (context) => const FirebasePage()
};

void backToHome({required BuildContext ctx, Object? args}) {
  Navigator.of(ctx).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(ctx, "/home", arguments: args);
}

Route<dynamic>? Function(RouteSettings)? onUnknownRoute() =>
    (RouteSettings settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: ((context) => const MyHomePage()),
        );

void handlerExpiredAcessToken() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  navigatorKey.currentState?.popUntil((route) => route.isFirst);
  navigatorKey.currentState?.pushReplacementNamed("/home");
}
