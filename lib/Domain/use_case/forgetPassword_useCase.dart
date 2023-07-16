
import 'package:dartz/dartz.dart';

import '../../Data/network/failure.dart';
import '../repository/repository.dart';
import 'base_useCase.dart';

class ForgetPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(
      String email) async {
    return await _repository.forgetPassword(email);
  }
}
