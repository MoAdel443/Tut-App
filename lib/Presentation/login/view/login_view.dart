
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../App/app_prefs.dart';
import '../../../App/dependancy_ingection.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/Color_Manager.dart';
import '../../resources/Routes_Manager.dart';
import '../../resources/Strings_Manager.dart';
import '../../resources/Values_Manager.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreference _appPreference = instance<AppPreference>();


  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.SetUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.SetPassword(_passwordController.text));
    _viewModel.isUserLoggedInStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn){
        //navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreference.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);

        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.login();
              }) ??
              _getContentWidget()),
    );
  }

  Widget _getContentWidget() {
    return Container(
      height: double.infinity,
      color: ColorManager.white,
      padding: EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/splash_logo.png"),
              ),
              SizedBox(
                height: AppPadding.p28,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.OutIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.username.tr(),
                        labelText: AppStrings.username.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.usernameError.tr(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppPadding.p14,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.OutIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError.tr(),
                      ),

                    );
                  },
                ),
              ),
              SizedBox(
                height: AppPadding.p28,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.OutAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: AppSize.s50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: Text(AppStrings.login).tr()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: AppPadding.p28),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.forgetPasswordRoute);
                      },
                      child: Text(
                        AppStrings.forgetPassword.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: AppPadding.p28),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.registerRoute);
                      },
                      child: Text(
                        AppStrings.registerText.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
