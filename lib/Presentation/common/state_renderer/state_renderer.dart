// ignore: camel_case_types
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/Assets_Manager.dart';
import '../../resources/Color_Manager.dart';
import '../../resources/Strings_Manager.dart';
import '../../resources/Styles_Manager.dart';
import '../../resources/Values_Manager.dart';

enum StateRendererType {
  //popup
  popupLoadingState,
  popupErrorState,
  popupSuccess,

  //fullScreen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //general
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
  Widget? contentScreenWidget;

  StateRenderer({
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryActionFunction,
    this. contentScreenWidget,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.popupSuccess:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getButton(AppStrings.retryAgain.tr(), context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return this.contentScreenWidget??Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s14),
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animatedName) {
    return SizedBox(
      width: AppSize.s100,
      height: AppPadding.p100,
      child: Lottie.asset(animatedName),
    );
  }

  Widget _getMessage(String Message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          Message,
          style:
              getRegularStyle(color: ColorManager.black, fontSize: AppSize.s16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getButton(String titleMessage, context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (StateRendererType ==
                      StateRendererType.fullScreenErrorState) {
                    //call retry function
                    retryActionFunction.call();
                  } else {
                    //popup state
                    Navigator.of(context).pop();
                  }
                },
                child: Text(titleMessage))),
      ),
    );
  }
}
