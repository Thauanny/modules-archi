import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/home_page.dart';

final routers = {'/home': (context) => const MyHomePage()};

void backToHome({required BuildContext ctx, Object? args}) {
  Navigator.of(ctx).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(ctx, "/home", arguments: args);
}

Route<dynamic>? Function(RouteSettings)? onUnknownRoute() =>
    (RouteSettings settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: ((context) => const MyHomePage()),
        );
