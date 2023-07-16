import 'package:dartz/dartz.dart';

import '../../Data/network/failure.dart';
import '../../Data/network/requests.dart';
import '../models/models.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequests loginRequests);
  Future<Either<Failure,String>> forgetPassword(String email);
  Future<Either<Failure,Authentication>> register(RegisterRequests registerRequests);
  Future<Either<Failure,HomeObject>> getHomeData();
  Future<Either<Failure,StoreDetails>> getStoreDetails();
}