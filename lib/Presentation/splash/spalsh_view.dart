import 'dart:async';
import 'package:flutter/material.dart';
import '../../App/app_prefs.dart';
import '../../App/dependancy_ingection.dart';
import '../resources/Assets_Manager.dart';
import '../resources/Color_Manager.dart';
import '../resources/Constants_Manager.dart';
import '../resources/Routes_Manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreference _appPreference = instance<AppPreference>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay), _goNext);
  }

  _goNext() {
    _appPreference.getUserLoggedIn().then((getUserLoggedIn) {
      if (getUserLoggedIn) {
        //navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreference
            .getOnBoardingScreenViewed()
            .then((getOnBoardingScreenViewed) {
          if (getOnBoardingScreenViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
