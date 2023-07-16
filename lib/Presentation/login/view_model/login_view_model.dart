import 'dart:async';



import '../../../Domain/use_case/login_useCase.dart';
import '../../base/base_viewModel.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements  LoginViewModelInputs, LoginViewModelOutputs {
  //stream controller
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _areAllInputsValidController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInStreamController = StreamController<bool>();

  LoginUseCase _loginUseCase;

   var loginObject = LoginObject("","");

  LoginViewModel(this._loginUseCase);

  //input data

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidController.close();
    isUserLoggedInStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  SetPassword(String password) {
   inputPassword.add(password);
   loginObject=loginObject.copyWith(password: password);
   _areAllInputsValidController.add(null);
  }

  @override
  SetUserName(String userName) {
    inputUserName.add(userName);
    loginObject=loginObject.copyWith(userName: userName);
    _areAllInputsValidController.add(null);

  }

  @override
  login() async{
    inputState.add(LoadingState(stateRendererT: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(LoginUseCaseInputs(loginObject.userName, loginObject.password)))
        .fold((faliure) => {
          //lest -> error
          inputState.add(ErrorState(StateRendererType.popupErrorState, faliure.msg))
        },
         (data)  {
            //right -> success
            //add content
            inputState.add(ContentState());
            //navigate to main screen
            isUserLoggedInStreamController.add(true);

        });
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;


  // output data
  @override
  Stream<bool> get OutIsPasswordValid => _passwordStreamController.stream
      .map((password) => IsPasswordValid(password));

  @override
  Stream<bool> get OutIsUserNameValid => _userNameStreamController.stream
      .map((userName) => IsUserNameValid(userName));

  @override
  Stream<bool> get OutAreAllInputsValid => _areAllInputsValidController.stream.map((_) => _areAllInputsValid());


  bool IsUserNameValid(String userName) => userName.isNotEmpty;
  bool IsPasswordValid(String password) => password.isNotEmpty;
  bool _areAllInputsValid() {
    return IsUserNameValid(loginObject.userName) && IsPasswordValid(loginObject.password);
  }





}

abstract class LoginViewModelInputs {
  SetUserName(String userName);
  SetPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get OutIsUserNameValid;
  Stream<bool> get OutIsPasswordValid;
  Stream<bool> get OutAreAllInputsValid;
}
