import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/data/datasources/impl/home_local_datasource.dart';
import 'package:flutter_application_1/src/modules/home/data/repository/home_repository.dart';
import 'package:flutter_application_1/src/modules/home/data/repository/impl/home_repository_impl.dart';
import 'package:flutter_application_1/src/shared/core/network_settings/network_settings.dart';
import 'package:get_it/get_it.dart';

abstract class HomeModule<T extends StatefulWidget> extends State<T> {
  HomeModule() {
    //DATASOURCERS
    GetIt.I.registerSingleton<HomeLocalDataSource>(
      HomeLocalDataSource(),
    );
    //REPOSITORY
    GetIt.I.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(
        settings: GetIt.I.get<NetworkSettings>(),
        homeLocalDataSource: GetIt.I.get<HomeLocalDataSource>(),
      ),
    );
  }
  @override
  void dispose() {
    GetIt.I.unregister<HomeRepository>();
    GetIt.I.unregister<HomeLocalDataSource>();
    super.dispose();
  }
}
