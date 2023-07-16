
import 'dart:async';
import '../../base/base_viewModel.dart';

import '../../../Domain/use_case/forgetPassword_useCase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel implements  ForgetPasswordViewModelInputs,ForgetPasswordViewModelOutputs {

  StreamController _emailStreamController = StreamController<String>.broadcast();
  StreamController _areAllInputsValidController = StreamController<void>.broadcast();


  final ForgetPasswordUseCase _forgetPasswordUseCase;

  ForgetPasswordViewModel(this._forgetPasswordUseCase);


  var email ="";




  //input



  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgetPassword() async{
    inputState.add(LoadingState(stateRendererT: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.execute(email)).fold((failure) {

        //lest -> error
      inputState.add(SuccessState("we have sent an email to you, if you need any help please contact us"));

    }, (supportMessage)  {
          //right -> success
        });
  }

  @override
  SetEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;


  //out
  @override
  void dispose() {
    // super.dispose();
    _emailStreamController.close();
    _areAllInputsValidController.close();
  }

  @override
  Stream<bool> get OutAreAllInputsValid => _areAllInputsValidController.stream.map((isAllInputVaild) => _areAllInputsValid());

  @override
  Stream<bool> get OutIsEmailValid => _emailStreamController.stream.map((email) => IsEmailValid(email));

  bool IsEmailValid(String email) => email.isNotEmpty;
  bool _areAllInputsValid() {
    return IsEmailValid(email) ;
  }
  _validate(){
    inputAreAllInputsValid.add(null);
  }




}

abstract class ForgetPasswordViewModelInputs {
  SetEmail(String email);
  forgetPassword();
  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}

abstract class ForgetPasswordViewModelOutputs {

  Stream<bool> get OutIsEmailValid;
  Stream<bool> get OutAreAllInputsValid;
}
