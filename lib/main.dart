import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final String env = Env.get("ENV").toString().toLowerCase();

  //todo incluir packageInfo
  //todo plataformChannel
  //todo SQLITe
  //todo firebase

  runApp(
    AppModule(
      env: env,
      baseUrl: Env.get("BASE_URL"),
      prefixo: Env.get("BASE_URL_SUFIXO"),
      sharedPreferences: await SharedPreferences.getInstance(),
    ),
  );
}
