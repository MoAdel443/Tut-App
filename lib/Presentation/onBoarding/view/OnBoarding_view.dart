
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../App/app_prefs.dart';
import '../../../App/dependancy_ingection.dart';
import '../../../Domain/models/models.dart';
import '../../resources/Assets_Manager.dart';
import '../../resources/Color_Manager.dart';
import '../../resources/Constants_Manager.dart';
import '../../resources/Routes_Manager.dart';
import '../../resources/Strings_Manager.dart';
import '../../resources/Values_Manager.dart';
import '../viewModel/onBoradingViewModel.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final onBoardingViewModel _viewModel = onBoardingViewModel();
  final AppPreference _appPreference = instance<AppPreference>();

  _bind() {
    _appPreference.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    }
    else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return onBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip.tr(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ],
              ),
              _getBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //left arrow
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.LeftArrow),
              ),
              onTap: () {
                _pageController.animateToPage(
                  _viewModel.goPrevious(),
                  duration: Duration(milliseconds: AppConstant.onboardingDely),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
          // circles
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                ),
            ],
          ),
          //right arrow
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.RightArrow),
              ),
              onTap: () {
                _pageController.animateToPage(
                  _viewModel.goNext(),
                  duration: Duration(milliseconds: AppConstant.onboardingDely),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex)
      return SvgPicture.asset(ImageAssets.hollow);
    else
      return SvgPicture.asset(ImageAssets.circle);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class onBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const onBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
