
import 'dart:ui';

enum LanguageType {ENGILSH , ARABIC}

const String ARABIC = "ar";
const String ENGLISH = "en";
const String LANG_PATH = "assets/translation";

const Locale ARABIC_LOCAL = Locale("ar","SA");
const Locale ENGLISH_LOCAL = Locale("en","US");

extension LanguageTypeExtention on LanguageType{

  String getValue(){
    switch(this){
      case LanguageType.ENGILSH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}