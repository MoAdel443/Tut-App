import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../App/dependancy_ingection.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/Color_Manager.dart';
import '../../resources/Strings_Manager.dart';
import '../../resources/Values_Manager.dart';
import '../forgetPassword_viewModel/forgetPassword_viewModel.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final ForgetPasswordViewModel _viewModel = instance<ForgetPasswordViewModel>();

  final TextEditingController _userNameController = TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.SetEmail(_userNameController.text));
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
      return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){
        _viewModel.forgetPassword();
      }) ?? _getContentWidget();
    },
    )
    );
  }

  Widget _getContentWidget(){
    return Container(
          padding: EdgeInsets.only(top: AppPadding.p100),
          height: double.infinity,
          color: ColorManager.white,

          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                      image: AssetImage("assets/images/splash_logo.png")
                  ),
                  SizedBox(
                    height: AppSize.s60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p50, right: AppPadding.p50),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.OutIsEmailValid,
                      builder: (context, snapshot) {
                        return TextFormField(

                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: AppStrings.email.tr(),
                            labelText: AppStrings.email.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError.tr(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p50, right: AppPadding.p50),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.OutAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          height: AppSize.s50,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () => _viewModel.forgetPassword()
                                  : null,
                              child: const Text(AppStrings.resetPass).tr()),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  TextButton(onPressed: (){
                    _viewModel.forgetPassword();
                  }, child: Text(
                      AppStrings.didntRecieveEmailResesnd.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ))


                ],
              ),
            ),
          ),
        );


  }
}
