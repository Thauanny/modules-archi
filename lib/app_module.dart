import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http_impl.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/impl/local_storage_impl.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/network_settings/network_settings.dart';
import 'package:flutter_application_1/src/shared/core/environment/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends StatefulWidget {
  final String env;
  final String baseUrl;
  final String prefixo;
  final SharedPreferences sharedPreferences;

  AppModule({
    super.key,
    required this.env,
    required this.baseUrl,
    required this.prefixo,
    required this.sharedPreferences,
  }) {
    GetIt.I.registerSingleton<NetworkSettings>(
      _networkSettings(env),
    );
    GetIt.I.registerSingleton<ClientHttp>(
      ClienteHttpImpl(
        clienteHttp: Dio(),
        baseUrl: baseUrl,
        prefixo: prefixo,
        localStorage: LocalStorageImpl(sharedPreferences),
      ),
    );
  }

  NetworkSettings _networkSettings(String? env) {
    switch (env) {
      case 'hml':
        return HmlSettingsNetwork();

      case 'prd':
        return PrdSettingsNetwork();

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
      onUnknownRoute: onUnknownRoute(),
      initialRoute: '/home',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<ClientHttp>();
    GetIt.I.unregister<NetworkSettings>();
    super.dispose();
  }
}
