import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/firebase/firebase_module.dart';
import 'package:flutter_application_1/src/modules/home/home_module.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/shared/helpers/open_url/open_url.dart';

final routers = {
  '/home': (context) => HomeModule(),
  '/createFirebase': (context) => FirebaseModule()
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
  openUrl(
    Uri.parse(
      Uri.base.toString(),
    ),
    newTab: false,
  );
}
