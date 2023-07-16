
import 'package:TutApp/Presentation/onBoarding/view/OnBoarding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../App/dependancy_ingection.dart';
import '../forgetPassword/forgetPassword_view/forgetPassword_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';
import '../register/register_view/register_view.dart';
import '../splash/spalsh_view.dart';
import '../storeDetails/store_details_view/store_details_view.dart';
import 'Strings_Manager.dart';

class Routes {
  static const String spalshRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings)
  {
    switch(settings.name) {
      case Routes.spalshRoute:
        return MaterialPageRoute(builder: (_)=> const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_)=> const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_)=> const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_)=> const ForgetPasswordView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_)=> const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_)=> const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute()
  {
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.unDefinedRoute).tr(),
      ),
      body:  Center(child: Text(AppStrings.unDefinedRoute.tr())),
    ),
    );
  }
}
