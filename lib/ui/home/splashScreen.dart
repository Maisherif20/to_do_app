import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/ui/home/homeScreen.dart';
import 'package:untitled8/ui/login/login.dart';
import 'package:untitled8/ui/myThemeData.dart';

import '../../providers/settings_providers.dart';

class SplashScreen  extends StatefulWidget {
  static String routeName = "Splash Screen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context,   Login.routeName);
    });

  }
  @override
  Widget build(BuildContext context) {
    var settingProvider =  Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor:settingProvider.currentTheme==ThemeMode.light?lightScaffoldColor:darkScaffoldColor,
      body: Center(
        child: Image.asset("assests/images/logo.png"),
      ),
    );
  }
}
