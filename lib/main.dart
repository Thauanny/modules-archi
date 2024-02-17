import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/impl/local_storage_impl.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
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
