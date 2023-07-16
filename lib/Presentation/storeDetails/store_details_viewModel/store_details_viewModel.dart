
import 'dart:async';
import 'dart:ffi';

import 'package:TutApp/Domain/models/models.dart';
import 'package:TutApp/Domain/use_case/store_details_useCase.dart';
import 'package:TutApp/Presentation/base/base_viewModel.dart';
import 'package:TutApp/Presentation/common/state_renderer/state_renderer.dart';
import 'package:TutApp/Presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel implements  StoreDetailsViewModelInputs,StoreDetailsViewModelOutputs{

  final _storeDetailsStreamController =
  BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoreDetailsData();
  }
  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  _getStoreDetailsData() async {
    inputState.add(
        LoadingState(stateRendererT: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(Void)).fold(
            (failure) {
          //lest -> error
          inputState.add(ErrorState(
              StateRendererType.fullScreenErrorState, failure.msg));
        }, (storeDetailsObj) async {
      //right -> success
      //add content
      inputState.add(ContentState());
      inputStoreDetails.add(StoreDetails(
        storeDetailsObj.image,
        storeDetailsObj.id,
        storeDetailsObj.title,
        storeDetailsObj.details,
        storeDetailsObj.services,
        storeDetailsObj.about,

      ));


    });
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreData =>_storeDetailsStreamController.stream.map((data) => data);

}

abstract class StoreDetailsViewModelInputs{
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs{
  Stream<StoreDetails> get outputStoreData;
}

