import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/ui/home/settingTab/language_selector.dart';
import 'package:untitled8/ui/home/settingTab/theme_selector.dart';

import '../../../providers/settings_providers.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  List<String> languages = ["Light", "Dark"];
  String? selectedItem = 'Light';
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 20),
            child: Text("Language",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: settingProvider.currentTheme==ThemeMode.light?Theme.of(context).primaryColor:Colors.white)),
          ),
          InkWell(
            onTap: () {
              showLanguageSelectorBottomsheet();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              child: Container(
                decoration: BoxDecoration(
                    color:  settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Text(
                        "English",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 20),
            child: Text("Mode",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: settingProvider.currentTheme==ThemeMode.light?Theme.of(context).primaryColor:Colors.white)),
          ),
          InkWell(
            onTap: () {
              showThemeSelectorBottomsheet();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              child: Container(
                decoration: BoxDecoration(
                    color:  settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Text(
                        settingProvider.currentTheme==ThemeMode.light? "Light" : "Dark",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageSelectorBottomsheet() {
    var settingProvider = Provider.of<SettingsProvider>(context ,listen: false );
    showModalBottomSheet(
        backgroundColor: settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
        context: context, builder: (context) => LanguageSelectorBottomSheet());
  }

  void showThemeSelectorBottomsheet() {
    var settingProvider = Provider.of<SettingsProvider>(context ,listen: false );
    showModalBottomSheet(
        backgroundColor: settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
        context: context, builder: (context) => ThemeSelectorBottomsheet());
  }
}

// Padding(
// padding: const EdgeInsets.only(left: 18, top: 20),
// child: Text("Mode",
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 20 ,right: 20 , top: 5),
// child: Container(
// color: Colors.white,
// child: DropdownButtonFormField<String>(
// decoration:InputDecoration(
// focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2 , color: Theme.of(context).primaryColor)),
// enabledBorder: OutlineInputBorder(
// borderSide: BorderSide(width: 2 , color: Theme.of(context).primaryColor)   ,
//
// )
// ),
// value: selectedItem,
// items: languages
//     .map((e) => DropdownMenuItem(value: e, child: Text(e , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold ,color: Theme.of(context).primaryColor))),)
//     .toList(),
//
// onChanged: (e) => setState(() {
// selectedItem = e;
// e== "Light"?settingProvider.changeTheme(ThemeMode.light):settingProvider.changeTheme(ThemeMode.dark)  ;
// })),
// ),
// ),
