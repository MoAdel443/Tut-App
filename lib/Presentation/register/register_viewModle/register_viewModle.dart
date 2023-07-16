

import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

import '../../../App/functions.dart';
import '../../../Domain/use_case/register_useCase.dart';
import '../../base/base_viewModel.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/Strings_Manager.dart';

class RegisterViewModel extends BaseViewModel implements  RegisterViewModelInputs,RegisterViewModelOutputs{

  final StreamController userNameStreamController = StreamController<String>.broadcast();
  final StreamController mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController emailStreamController = StreamController<String>.broadcast();
  final StreamController passwordStreamController = StreamController<String>.broadcast();
  final StreamController profilePictureStreamController = StreamController<File>.broadcast();
  final StreamController areAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isUserRegisteredSuccessfullyStreamController = StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("","","","","","");

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
    super.dispose();
  }

  // -- inputs --
  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;


  @override
  register() async{
    inputState.add(LoadingState(stateRendererT: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(
        RegisterUseCaseInputs(
            registerObject.userName,
            registerObject.email,
            registerObject.password,
            registerObject.countryCode,
            registerObject.mobileNumber,
            registerObject.profilePicture
        )
    )
    ).fold((failure) {
      //left -> error
      inputState.add(ErrorState(StateRendererType.popupErrorState, 'error !@!'));

      //todo navigate to main screen

    }, (data) {
      inputState.add(ContentState());
      isUserRegisteredSuccessfullyStreamController.add(true);
    });

  }


  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if(_isUserNameValid(userName)){
      // update userName view object
      registerObject = registerObject.copyWith(userName: userName);
    }
    else{
      //reset userName value in view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty){
      // update countryCode view object
      registerObject = registerObject.copyWith(countryCode: countryCode);
    }
    else{
      //reset countryCode value in view object
      registerObject = registerObject.copyWith(countryCode: "");
    }
    validate();

  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)){
      // update email view object
      registerObject = registerObject.copyWith(email: email);
    }
    else{
      //reset email value in view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();

  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)){
      // update mobileNumber view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    }
    else{
      //reset mobileNumber value in view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();

  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      // update password view object
      registerObject = registerObject.copyWith(password: password);
    }
    else{
      //reset password value in view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();

  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty){
      // update profilePicture view object
      registerObject = registerObject.copyWith(profilePicture: profilePicture.path);
    }
    else{
      //reset profilePicture value in view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();

  }



  // -- outputs --
  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserName) => isUserName ? null : AppStrings.userNameInvalid.tr());


  @override
  Stream<bool> get outputIsMobileNumberValid => mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid
      .map((isMobileNumber) => isMobileNumber ? null : AppStrings.mobileNumberInvalid.tr());


  @override
  Stream<bool> get outputIsEmailValid => emailStreamController.stream
      .map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail =>outputIsEmailValid
      .map((isEmail) => isEmail ? null : AppStrings.emailInvalid.tr());


  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPassword) => isPassword ? null : AppStrings.passwordInvalid.tr());


  @override
  Stream<File> get outputProfilePicture => profilePictureStreamController.stream
      .map((file) => file);


  @override
  Stream<bool> get outputAreAllOutputsValid => areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());


  // -- private functions --
  bool _isUserNameValid(String userName) => userName.length >=8;
  bool _isMobileNumberValid(String mobileNumber) => mobileNumber.isNotEmpty;
  bool _isPasswordValid(String password) => password.length >=6;
  bool _areAllInputsValid(){
    return registerObject.email.isNotEmpty &&
     registerObject.userName.isNotEmpty &&
     registerObject.password.isNotEmpty &&
     registerObject.profilePicture.isNotEmpty &&
     registerObject.mobileNumber.isNotEmpty ;
  }
  validate(){
    inputAllInputsValid.add(null);
  }

}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;

  register();

  setUserName(String userName);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllOutputsValid;
}