import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/src/shared/core/env/env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppModule(
      env: Env.get("ENV"),
      envLaunch: Env.get("ENV_LAUNCH"),
    ),
  );
}