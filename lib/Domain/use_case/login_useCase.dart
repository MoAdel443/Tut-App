
import 'package:dartz/dartz.dart';

import '../../Data/network/failure.dart';
import '../../Data/network/requests.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_useCase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInputs, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInputs input) async {
    return await _repository.login(LoginRequests(input.email, input.password));
  }
}

class LoginUseCaseInputs {
  String email;
  String password;

  LoginUseCaseInputs(this.email, this.password);
}
