import 'dart:async';
import 'dart:ffi';

import 'package:TutApp/Domain/models/models.dart';
import 'package:TutApp/Domain/use_case/home_useCase.dart';
import 'package:TutApp/Presentation/base/base_viewModel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    implements  HomeViewModelInputs, HomeViewModelOutputs {
  final StreamController _homeDataStreamController =
      BehaviorSubject<HomeStreamController>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // -- inputs --
  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _homeDataStreamController.close();

    super.dispose();
  }

  _getHomeData() async {
    inputState.add(
        LoadingState(stateRendererT: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              //lest -> error
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.msg))
            }, (homeObject) {
      //right -> success
      //add content
      inputState.add(ContentState());
      inputHomeStreamController.add(HomeStreamController(
          homeObject.data.services,
          homeObject.data.stores,
          homeObject.data.banners));
    });
  }

  @override
  Sink get inputHomeStreamController => _homeDataStreamController.sink;

  //--outputs--
  @override
  Stream<HomeStreamController> get outputHomeStreamController =>
      _homeDataStreamController.stream
          .map((homeStreamController) => homeStreamController);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeStreamController;
}

abstract class HomeViewModelOutputs {
  Stream<HomeStreamController> get outputHomeStreamController;
}

class HomeStreamController {
  List<Service> services;
  List<Store> stores;
  List<BannerAd> banners;

  HomeStreamController(this.services, this.stores, this.banners);
}
