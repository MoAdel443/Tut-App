import 'package:TutApp/Presentation/resources/languageManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'App/app.dart';
import 'App/dependancy_ingection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp( EasyLocalization(
      child: Phoenix(child:MyApp()),
      supportedLocales: [
        ARABIC_LOCAL,
        ENGLISH_LOCAL
      ],
      path: LANG_PATH));
}



