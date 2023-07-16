import 'package:TutApp/Domain/models/models.dart';
import 'package:TutApp/Presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:TutApp/Presentation/resources/Color_Manager.dart';
import 'package:TutApp/Presentation/resources/Values_Manager.dart';
import 'package:TutApp/Presentation/storeDetails/store_details_viewModel/store_details_viewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../App/dependancy_ingection.dart';
import '../../resources/Strings_Manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return Container(
              child: snapshot.data?.getScreenWidget(
                      context, _getContentWidget(context), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget(context),
            );
          }),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.primary
          ),
          title: Text(AppStrings.storeDetails.tr()),
          elevation: AppSize.s0,
          iconTheme: IconThemeData(
            //back button
            color: ColorManager.white,
          ),
          backgroundColor: ColorManager.primary,
          centerTitle: true,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: StreamBuilder<StoreDetails>(
              stream: _viewModel.outputStoreData,
              builder: (context, snapshot) {
                return _getItems(snapshot.data);
              },
            ),
          ),
        ));
  }

  Widget _getItems(StoreDetails? data) {
    if (data != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getImageWidget(data.image),
          _getSection(AppStrings.details.tr(), context),
          _getText(data.details, context),
          _getSection(AppStrings.services.tr(), context),
          _getText(data.services, context),
          _getSection(AppStrings.aboutStore.tr(), context),
          _getText(data.about, context),
        ],
      );
    } else {
      return Container();
    }
  }
}

Widget _getImageWidget(String image) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8)
          ),
          height: AppSize.s180,
          width: double.infinity,

            child: Image.network(image,fit: BoxFit.cover,)
        ),
      ),
    );

}

Widget _getSection(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        left: AppPadding.p12,
        right: AppPadding.p12,
        top: AppPadding.p12,
        bottom: AppPadding.p8),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleSmall,
    ),
  );
}

Widget _getText(String details, BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12, right: AppPadding.p12, bottom: AppPadding.p12),
      child: Text(
        details,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );

}
