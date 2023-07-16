import 'package:TutApp/Data/data_source/local_data_source.dart';
import 'package:TutApp/Domain/use_case/home_useCase.dart';
import 'package:TutApp/Domain/use_case/store_details_useCase.dart';
import 'package:TutApp/Presentation/main/pages/home/home_viewModel/home_viewModel.dart';
import 'package:TutApp/Presentation/storeDetails/store_details_viewModel/store_details_viewModel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/data_source/remote_data_source.dart';
import '../Data/network/app_API.dart';
import '../Data/network/dioFactory.dart';
import '../Data/network/network_info.dart';
import '../Data/repository/repository_impl.dart';
import '../Domain/repository/repository.dart';
import '../Domain/use_case/forgetPassword_useCase.dart';
import '../Domain/use_case/login_useCase.dart';
import '../Domain/use_case/register_useCase.dart';
import '../Presentation/forgetPassword/forgetPassword_viewModel/forgetPassword_viewModel.dart';
import '../Presentation/login/view_model/login_view_model.dart';
import '../Presentation/register/register_viewModle/register_viewModle.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module, its module where we but all generic dependencies

  //shared preference instance
  final sharedPreference = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  //app prefs instance
  instance
      .registerLazySingleton<AppPreference>(() => AppPreference(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service client
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance<AppServiceClient>()));

  //local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //repository
  instance.registerFactory<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() =>
        LoginUseCase(instance<Repository>())); //factory bcz one use not to much
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(() =>
        ForgetPasswordUseCase(instance())); //factory bcz one use not to much
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(instance())); //factory bcz one use not to much
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
        () => HomeUseCase(instance())); //factory bcz one use not to much

    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(() =>
        StoreDetailsUseCase(instance())); //factory bcz one use not to much

    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}
