import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/data/datasources/impl/home_local_datasource.dart';
import 'package:flutter_application_1/src/modules/home/data/datasources/impl/home_remote_datasource.dart';
import 'package:flutter_application_1/src/modules/home/domain/repository/home_repository.dart';
import 'package:flutter_application_1/src/modules/home/data/repository/home_repository_impl.dart';
import 'package:flutter_application_1/src/modules/home/domain/usecases/example_use_case.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/bloc/home_bloc.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/network_settings/network_settings.dart';
import 'package:get_it/get_it.dart';

class HomeModule extends StatefulWidget {
  HomeModule({super.key}) {
    //DATASOURCERS
    //local
    GetIt.I.registerSingleton<HomeLocalDataSource>(
      HomeLocalDataSource(),
    );
    //remote
    GetIt.I.registerSingleton<HomeRemoteDataSource>(
      HomeRemoteDataSource(),
    );

    //REPOSITORY
    GetIt.I.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(
        settings: GetIt.I.get<NetworkSettings>(),
        homeLocalDataSource: GetIt.I.get<HomeLocalDataSource>(),
        homeRemoteDataSource: GetIt.I.get<HomeRemoteDataSource>(),
      ),
    );

    //USECASE
    GetIt.I.registerSingleton<ExampleUseCase>(
      ExampleUseCase(
        homeRepository: GetIt.I.get<HomeRepository>(),
      ),
    );
    //BlOC
    GetIt.I.registerSingleton<HomeBloc>(
      HomeBloc(
        exampleUseCase: GetIt.I.get<ExampleUseCase>(),
      ),
    );
  }

  @override
  State<HomeModule> createState() => _HomeModuleState();
}

class _HomeModuleState extends State<HomeModule> {
  @override
  void dispose() {
    GetIt.I.unregister<HomeLocalDataSource>();
    GetIt.I.unregister<HomeRemoteDataSource>();
    GetIt.I.unregister<HomeRepository>();
    GetIt.I.unregister<ExampleUseCase>();
    GetIt.I.unregister<HomeBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}
