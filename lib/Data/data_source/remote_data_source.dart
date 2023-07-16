
import 'package:TutApp/Data/network/app_API.dart';
import 'package:TutApp/Data/network/requests.dart';
import 'package:TutApp/Data/response/responses.dart';

abstract class RemoteDataSource {

  Future<AuthenticationResponse> login(LoginRequests loginRequests);
  Future<AuthenticationResponse> register(RegisterRequests registerRequests);
  Future<ForgetPasswordResponse> forgetPassword(String email);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();

}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImp(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServiceClient.login(loginRequests.email, loginRequests.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    return await _appServiceClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequests registerRequests) async {
    return await _appServiceClient.register(
        registerRequests.userName,
        registerRequests.countryCode,
        registerRequests.mobileNumber,
        registerRequests.email,
        registerRequests.password,
        ""
    );
  }

  @override
  Future<HomeResponse> getHomeData() async{
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
    return await _appServiceClient.getStoreDetails();
  }

}