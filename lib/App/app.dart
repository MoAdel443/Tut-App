
import 'package:TutApp/App/app_prefs.dart';
import 'package:TutApp/App/dependancy_ingection.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Presentation/resources/Routes_Manager.dart';
import '../Presentation/resources/Theme_Manager.dart';

class MyApp extends StatefulWidget {

   MyApp.internal();  //named constructor اقدر اندهلو من داخل الكلاس بس

   static final MyApp _instance =  MyApp.internal();  // singleTon or Single inctance

   factory MyApp() => _instance;   //علشان اقدر انده للكلاس من اي حته

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppPreference _appPreference = instance<AppPreference>();
  @override
  void didChangeDependencies() {
    _appPreference.getLocale().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.spalshRoute,



    );
  }
}
