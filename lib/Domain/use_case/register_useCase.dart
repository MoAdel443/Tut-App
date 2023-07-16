
import 'package:TutApp/Domain/use_case/base_useCase.dart';
import 'package:dartz/dartz.dart';

import '../../Data/network/failure.dart';
import '../../Data/network/requests.dart';
import '../models/models.dart';
import '../repository/repository.dart';


class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInputs, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInputs input) async {
    return await _repository.register(RegisterRequests(
        input.userName,
        input.email,
        input.password,
        input.countryCode,
        input.mobileNumber,
        input.profilePicture));
  }
}

class RegisterUseCaseInputs {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInputs(this.userName, this.email, this.password,
      this.countryCode, this.mobileNumber, this.profilePicture);
}
