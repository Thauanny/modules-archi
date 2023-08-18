import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/modules/home/data/repository/home_repository.dart';
import 'package:flutter_application_1/src/shared/core/network_settings/network_settings.dart';

import '../../datasources/impl/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkSettings settings;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepositoryImpl({
    required this.settings,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Exception, bool>> teste() async {
    return await settings.selectRepository(
      local: () {
        return homeLocalDataSource.teste();
      },
      remote: () {
        return homeLocalDataSource.teste();
      },
    );
  }
}
