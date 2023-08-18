import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/modules/home/domain/repository/home_repository.dart';
import 'package:flutter_application_1/src/shared/core/usecase/usecase.dart';

class ExampleUseCase implements UseCase<bool, NoParams> {
  final HomeRepository homeRepository;
  ExampleUseCase({
    required this.homeRepository,
  });
  @override
  Future<Either<Exception, bool>> call([NoParams? params]) async {
    return await homeRepository.example();
  }
}
