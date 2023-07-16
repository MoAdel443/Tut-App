

import 'package:TutApp/Data/network/failure.dart';
import 'package:TutApp/Domain/models/models.dart';
import 'package:TutApp/Domain/repository/repository.dart';
import 'package:TutApp/Domain/use_case/base_useCase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  final Repository _repository;
  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return _repository.getStoreDetails();
  }
}

