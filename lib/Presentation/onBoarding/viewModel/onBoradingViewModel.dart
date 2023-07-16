// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

import '../../../Domain/models/models.dart';
import '/Presentation/base/base_viewModel.dart';

import '../../resources/Assets_Manager.dart';
import '../../resources/Strings_Manager.dart';


class onBoardingViewModel extends BaseViewModel implements  onBoardingViewModelInputs,onBoardingViewModelOutputs {

  //stream controllers output

  final StreamController _streamController = StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;


  // onBoarding viewModel inputs

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;


  // onBoarding viewModel outputs

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SliderViewObject) => SliderViewObject);


  //onBoarding Private function

  _postDataToView(){
    inputSliderViewObject.add(
        SliderViewObject(
            _list[_currentIndex],
            _currentIndex,
            _list.length,
        )
    );
  }

  _getSliderData() => [
        SliderObject(
          ImageAssets.onBoardingLogo1,
          AppStrings.onBoardingSubTitle1.tr(),
          AppStrings.onBoardingTitle1.tr(),
        ),
        SliderObject(
          ImageAssets.onBoardingLogo2,
          AppStrings.onBoardingSubTitle2.tr(),
          AppStrings.onBoardingTitle2.tr(),
        ),
        SliderObject(
          ImageAssets.onBoardingLogo3,
          AppStrings.onBoardingSubTitle3.tr(),
          AppStrings.onBoardingTitle3.tr(),
        ),
        SliderObject(
          ImageAssets.onBoardingLogo4,
          AppStrings.onBoardingSubTitle4.tr(),
          AppStrings.onBoardingTitle4.tr(),
        ),
      ];
}

// inputs mean that "order" that out view model will receive from view
abstract class onBoardingViewModelInputs {
  int goNext(); //when user clicks right arrow
  int goPrevious(); //when user clicks left arrow
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class onBoardingViewModelOutputs {

  Stream<SliderViewObject> get outputSliderViewObject;
}
