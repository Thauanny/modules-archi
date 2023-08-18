import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/modules/home/data/datasources/home_datasource.dart';

class HomeLocalDataSource implements HomeDataSource {
  @override
  Future<Either<Exception, bool>> teste() async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(Exception());
    }
  }
}
