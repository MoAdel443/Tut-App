import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInput implements  BaseViewModelOutput{
  //will contain any shared var or function in view
  final StreamController _inputStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.
  map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInput {
  void start();   //start view model jop

  void dispose(); // when view model dies

  Sink get inputState;
}


abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;
}