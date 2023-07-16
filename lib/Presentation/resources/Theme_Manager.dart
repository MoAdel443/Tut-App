import 'package:TutApp/Presentation/resources/Styles_Manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Color_Manager.dart';
import 'Font_Manager.dart';
import 'Values_Manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main color

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    //cardView

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    //app bar view

    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: true,
      color: ColorManager.white,
      elevation: 0.0,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),

    //button theme

    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary, //الخط الي بيظهر لما بندوس
    ),

    // elevated button theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: AppSize.s17,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    //text theme

    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      displayMedium:
          getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s22),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s14),
      headlineSmall:
          getRegularStyle(color: ColorManager.white, fontSize: AppSize.s16),
      titleMedium: getMediumStyle(
        color: ColorManager.ligthGrey,
        fontSize: FontSize.s14,
      ),
      displaySmall: getMediumStyle(color: ColorManager.grey,fontSize: AppSize.s14),
      titleSmall:
          getBoldStyle(color: ColorManager.primary, fontSize: AppSize.s16),
      bodyLarge: getRegularStyle(color: ColorManager.grey1,fontSize: AppSize.s14),
      bodyMedium:
          getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s12),
      bodySmall: getRegularStyle(color: ColorManager.grey),
      labelLarge: getRegularStyle(color: ColorManager.grey2, fontSize : AppSize.s12),
      labelSmall: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s12),
      
    ),

    //input decoration theme

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.ligthGrey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
