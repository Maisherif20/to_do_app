import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/providers/auth_provider.dart';
import 'package:untitled8/providers/settings_providers.dart';
import 'package:untitled8/ui/RegisterForm/registerForm.dart';
import 'package:untitled8/ui/home/homeScreen.dart';
import 'package:untitled8/ui/home/splashScreen.dart';
import 'package:untitled8/ui/login/login.dart';
import 'package:untitled8/ui/myThemeData.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create:(context) => SettingsProvider()..getTheme()),
      ChangeNotifierProvider(create: (context)=>MyAuthProvider()),
    ],
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: settingProvider.currentTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        SplashScreen.routeName:(context)=>SplashScreen(),
        RegisterForm.routeName:(context)=>RegisterForm(),
        Login.routeName:(context)=>Login(),
      },
        initialRoute:SplashScreen.routeName ,
      title: 'Flutter Demo',
    );
  }
}
