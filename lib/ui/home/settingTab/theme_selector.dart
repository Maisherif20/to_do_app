import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_providers.dart';

class ThemeSelectorBottomsheet extends StatefulWidget {


  @override
  State<ThemeSelectorBottomsheet> createState() => _ThemeSelectorBottomsheetState();
}

class _ThemeSelectorBottomsheetState extends State<ThemeSelectorBottomsheet> {
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return  SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              settingProvider.changeTheme(ThemeMode.light);
            },
            child: settingProvider.currentTheme==ThemeMode.light?getSelectedItem("Light"):getUnSelectedItem("Light"),
          ),
          InkWell(
            onTap: (){
              settingProvider.changeTheme(ThemeMode.dark);
            },
            child: settingProvider.currentTheme==ThemeMode.dark?getSelectedItem("Dark"):getUnSelectedItem("Dark"),
          )
        ],
      ),
    );
  }

  getSelectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700 , color: Theme.of(context).primaryColor),
          ),
          Spacer(),
          Icon(Icons.check_box ,size: 30,color: Theme.of(context).primaryColor)
        ],
      ),
    );
  }

  Widget getUnSelectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Text(
            text,
            style:TextStyle(fontSize: 20 , fontWeight: FontWeight.w700 , color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}

