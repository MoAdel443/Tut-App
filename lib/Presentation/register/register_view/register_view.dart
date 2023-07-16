import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../App/app_prefs.dart';
import '../../../App/constant.dart';
import '../../../App/dependancy_ingection.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/Assets_Manager.dart';
import '../../resources/Color_Manager.dart';
import '../../resources/Routes_Manager.dart';
import '../../resources/Strings_Manager.dart';
import '../../resources/Values_Manager.dart';
import '../register_viewModle/register_viewModle.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreference _appPreference = instance<AppPreference>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameTextEditingController = TextEditingController();
  final TextEditingController _mobileNumberTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  _bind(){
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
    });
    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
    _viewModel.isUserRegisteredSuccessfullyStreamController.stream.listen((isRegistered) {
      if(isRegistered){
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
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) =>
          snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
            _viewModel.register();
          }) ??
              _getContentWidget()

      ),
    );
  }

  Widget _getContentWidget(){
    return Container(
      color: ColorManager.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Image(
                      image: AssetImage("assets/images/splash_logo.png")
                  ),
                ), //image
                SizedBox(
                  height: AppSize.s16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p40,right: AppPadding.p40),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _userNameTextEditingController,
                          decoration: InputDecoration(
                            labelText: AppStrings.username.tr(),
                            hintText: AppStrings.username.tr(),
                            errorText: snapshot.data
                          )

                        );
                      },),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country){
                              _viewModel.setCountryCode(country.dialCode ?? Constants.token);
                            },
                            initialSelection: "+20",
                            favorite: const ['+39','FR' , "+966"],
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            hideMainText: true,

                          ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p40,right: AppPadding.p40),
                          child: StreamBuilder<String?>(
                            stream: _viewModel.outputErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _mobileNumberTextEditingController,
                                  decoration: InputDecoration(
                                      labelText: AppStrings.mobileNumber.tr(),
                                      hintText: AppStrings.mobileNumber.tr(),
                                      errorText: snapshot.data
                                  )

                              );
                            },),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p40,right: AppPadding.p40),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextEditingController,
                          decoration: InputDecoration(
                              labelText: AppStrings.email.tr(),
                              hintText: AppStrings.email.tr(),
                              errorText: snapshot.data
                          )

                      );
                    },),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p40,right: AppPadding.p40),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordTextEditingController,
                          decoration: InputDecoration(
                              labelText: AppStrings.password.tr(),
                              hintText: AppStrings.password.tr(),
                              errorText: snapshot.data
                          )

                      );
                    },),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p40,right: AppPadding.p40),
                  child: Container(
                    height: AppSize.s50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      border: Border.all(color: ColorManager.ligthGrey),
                    ),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: (){
                        _showPicker(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p40, right: AppPadding.p40,top: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputAreAllOutputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: AppSize.s50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                              _viewModel.register();
                            }
                                : null,
                            child: Text(AppStrings.register.tr())),
                      );
                    },
                  ),
                ),
                Container(

                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.alreadyHaveAccount.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  Widget _getMediaWidget(){
    return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p8,right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(
            AppStrings.profilePicture.tr(),
            style: TextStyle(
              color: ColorManager.grey,
              fontWeight: FontWeight.w500,
              fontSize: AppSize.s14,
            ),
          )
          ),
          Flexible(child: StreamBuilder<File>(
            stream: _viewModel.outputProfilePicture,
            builder: (context, snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCamera)),
        ],
      ),
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return SafeArea(child:Wrap(
        children: [
          ListTile(
            trailing: const Icon(Icons.arrow_forward),
            leading: const Icon(Icons.camera),
            title:  Text(AppStrings.photoGallery.tr()),
            onTap: (){
              _imageFromGallery();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward),
            leading: const Icon(Icons.camera_alt_outlined),
            title:  Text(AppStrings.photoCamera.tr()),
            onTap: (){
              _imageFromCamera();
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
    },
    );
  }

  _imageFromGallery()async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }
  _imageFromCamera()async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _imagePickedByUser(File? image){
    if(image!=null && image.path.isNotEmpty){
      return Image.file(image);
    }
    else{
      return Container();
    }
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
