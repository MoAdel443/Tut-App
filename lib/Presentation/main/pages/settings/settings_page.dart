import 'package:TutApp/App/app_prefs.dart';
import 'package:TutApp/App/dependancy_ingection.dart';
import 'package:TutApp/Data/data_source/local_data_source.dart';
import 'package:TutApp/Presentation/resources/Routes_Manager.dart';
import 'package:TutApp/Presentation/resources/Values_Manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/Strings_Manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreference _appPreference = instance<AppPreference>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  final Uri _whatsapp = Uri.parse('https://m.link/4md4iq');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(AppPadding.p12),
        children: [
          ListTile(
            leading: SvgPicture.asset("assets/images/settings.svg"),
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset("assets/images/RightArrowSettings.svg"),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/images/contact us.svg"),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset("assets/images/RightArrowSettings.svg"),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/images/invite friends.svg"),
            title: Text(
              AppStrings.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset("assets/images/RightArrowSettings.svg"),
            onTap: () {
              _shareAppWithFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/images/logout.svg"),
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  _changeLanguage(){
    _appPreference.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs()async{
    launchUrl(_whatsapp);
  }

  _shareAppWithFriends(){
    // in the future
  }

  _logout(){
    //shared preference
    _appPreference.logout();
    //local data source
    _localDataSource.clearCache();
    //navigate to login screen
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }


}
