
import 'package:flutter/material.dart';

import '../../../App/constant.dart';
import '../../resources/Strings_Manager.dart';
import 'state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading state (popup - fullscreen)

class LoadingState extends FlowState {
  StateRendererType stateRendererT;
  String message;

  LoadingState(
      {required this.stateRendererT, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererT;
}

// error state (popup - fullscreen)

class ErrorState extends FlowState {
  StateRendererType stateRendererT;
  String message;

  ErrorState(this.stateRendererT, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererT;
}

//content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty; //empty String

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

//empty state

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message; //empty String

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message; //empty String

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtention on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            //show loading state
            showPopUp(context, getStateRendererType(), getMessage());
            //save the extent content
            return contentScreenWidget;
          }
          else {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            //show error state
            showPopUp(context, getStateRendererType(), getMessage());
            //save the extent content
            return contentScreenWidget;
          }
          else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ContentState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType()
              ,message: getMessage()
              ,retryActionFunction: (){},
            contentScreenWidget: contentScreenWidget,
          );
        }
      case SuccessState:
        {
          dismissDialog(context);
          showPopUp(context, StateRendererType.popupSuccess, getMessage()
          ,title:AppStrings.success);

          return contentScreenWidget;
        }
      case EmptyState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context){
    return ModalRoute.of(context)?.isCurrent !=true;
  }

  dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message,{String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            title: title,
            retryActionFunction: () {})));
  }
}
