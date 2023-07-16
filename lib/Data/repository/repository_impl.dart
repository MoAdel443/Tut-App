import 'package:TutApp/Data/data_source/local_data_source.dart';
import 'package:TutApp/Data/data_source/remote_data_source.dart';
import 'package:TutApp/Data/mapper/mapper.dart';
import 'package:TutApp/Data/network/error_handler.dart';
import 'package:TutApp/Data/network/failure.dart';
import 'package:TutApp/Data/network/network_info.dart';
import 'package:TutApp/Data/network/requests.dart';
import 'package:TutApp/Domain/models/models.dart';
import 'package:TutApp/Domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._networkInfo, this._remoteDataSource
      ,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests) async {
    if (await _networkInfo.isConnected) {
      //mobile is connect to internet safe to call api
      try{
        final response = await _remoteDataSource.login(loginRequests);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          return Right(response.toDomain());
        } else {
          // business error!!!!!!
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.massage ?? ResponseMassage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    } else {
      //mobile not connected
      return Left(DataSourse.NO_INTERNET_CONNECTION.getFailure());

    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      //mobile is connect to internet safe to call api
      try{
        final response = await _remoteDataSource.forgetPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          return Right(response.toDomain());
        } else {
          // business error!!!!!!
          return Left(Failure(response.status ?? ResponseCode.DEFAULT, response.massage
              ?? ResponseMassage.DEFAULT));
        }
      }
      catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      //mobile not connected
      return Left(DataSourse.NO_INTERNET_CONNECTION.getFailure());

    }

  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequests registerRequests) async {
    if (await _networkInfo.isConnected) {
      //mobile is connect to internet safe to call api
      try{
        final response = await _remoteDataSource.register(registerRequests);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          return Right(response.toDomain());
        } else {
          // business error!!!!!!
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.massage ?? ResponseMassage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    } else {
      //mobile not connected
      return Left(DataSourse.NO_INTERNET_CONNECTION.getFailure());

    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{

    try{
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    }catch(cacheError){
      if (await _networkInfo.isConnected) {
        //mobile is connect to internet safe to call api
        try{
          final response = await _remoteDataSource.getHomeData();

          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());

          } else {
            // business error!!!!!!
            return Left(Failure(ApiInternalStatus.FAILURE,
                response.massage ?? ResponseMassage.DEFAULT));


          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }

      } else {
        //mobile not connected
        return Left(DataSourse.NO_INTERNET_CONNECTION.getFailure());
      }
    }


  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async{
    try{
      //get data from cache
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    }catch(cacheError){
      if (await _networkInfo.isConnected) {
        //mobile is connect to internet safe to call api
        try{
          final response = await _remoteDataSource.getStoreDetails();

          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            _localDataSource.saveStoreDetailsToCache(response);
            return Right(response.toDomain());

          } else {
            // business error!!!!!!
            return Left(Failure(response.status ?? ResponseCode.DEFAULT,
                response.massage ?? ResponseMassage.DEFAULT));


          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }

      } else {
        //mobile not connected
        return Left(DataSourse.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
