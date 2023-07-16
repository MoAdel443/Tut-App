

// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../Presentation/resources/languageManager.dart';


const String PREFS_KEY_LANG="PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED="PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN="PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreference {
  final SharedPreferences _sharedPreferences;

  AppPreference(this._sharedPreferences);

  Future<String> getAppLang() async {
      String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

      if(language !=null && language.isNotEmpty)
        {
          return language;
        }
      else {
        return LanguageType.ENGILSH.getValue();
      }
  }
  Future<void> changeAppLanguage ()async {
    String currentLang = await getAppLang();
    if(currentLang == LanguageType.ARABIC.getValue()){
      //convert to en
      _sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.ENGILSH.getValue());
    }
    else{
      //convert to ar
      _sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.ARABIC.getValue());

    }
}

  Future<Locale> getLocale ()async {
    String currentLang = await getAppLang();
    if(currentLang == LanguageType.ARABIC.getValue()){
     return ARABIC_LOCAL;
    }
    else{
      return ENGLISH_LOCAL;

    }
  }


  //on Boarding
  Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true) ;
  }

  Future<bool> getOnBoardingScreenViewed()async{
    return  _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false;
  }

  //Login
  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true) ;
  }

  Future<bool> getUserLoggedIn()async{
    return  _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
  Future<void> logout()async{
     await _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}