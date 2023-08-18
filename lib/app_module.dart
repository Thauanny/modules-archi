import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/network_settings/network_settings.dart';
import 'package:flutter_application_1/src/shared/core/routers/routers.dart';
import 'package:get_it/get_it.dart';

class AppModule extends StatefulWidget {
  final String env;
  final String envLaunch;

  AppModule({
    super.key,
    required this.env,
    required this.envLaunch,
  }) {
    GetIt.I.registerSingleton<NetworkSettings>(
      _networkSettings(envLaunch.isEmpty ? env : envLaunch),
    );
  }

  NetworkSettings _networkSettings(String? env) {
    switch (env) {
      case 'hml':
        return HmlSettingsNetwork();

      default:
        return DevSettingsNetwork();
    }
  }

  @override
  State<AppModule> createState() => _AppModuleState();
}

class _AppModuleState extends State<AppModule> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teste",
      routes: routers,
      initialRoute: '/home',
    );
  }
}
