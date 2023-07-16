



import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../App/constant.dart';
import '../response/responses.dart';

part 'app_API.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio , {String baseUrl}) = _AppServiceClient;

  @POST('/Customers/login')
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      );

  @POST('/Customers/forgetPassword')
  Future<ForgetPasswordResponse> forgetPassword(
      @Field("email") String email,
      );

  @POST("/Customers/register")
  Future<AuthenticationResponse> register(
      @Field("userName") String userName,
      @Field("countryCode") String countryCode,
      @Field("mobileNumber") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profilePicture") String profilePicture,
      );

  @GET('/home')
  Future<HomeResponse> getHomeData();

  @GET('/storeDetails/1')
  Future<StoreDetailsResponse> getStoreDetails();
}
