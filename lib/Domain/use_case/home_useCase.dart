

import 'package:TutApp/Data/network/failure.dart';
import 'package:TutApp/Domain/models/models.dart';
import 'package:TutApp/Domain/repository/repository.dart';
import 'package:TutApp/Domain/use_case/base_useCase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(
      void input) async {
    return await _repository.getHomeData();
  }
}

