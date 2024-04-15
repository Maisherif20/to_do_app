import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled8/providers/auth_provider.dart';
import 'package:untitled8/providers/settings_providers.dart';
import 'package:untitled8/ui/RegisterForm/registerForm.dart';
import 'package:untitled8/ui/firebaseErrorCode/fireBaseErrorCode.dart';
import 'package:untitled8/ui/home/homeScreen.dart';
import 'package:untitled8/ui/widgets/customTextFormFiled.dart';
import '../myThemeData.dart';
import '../utils/dialogUtils.dart';
import '../utils/emailformatvalid.dart';

class Login extends StatefulWidget {
  static String routeName = "Login Screen";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  bool obsecureText = false;
  bool obsecure = true;
  bool isLogin = false;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assests/images/background.png"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                CustomTextFormField(
                  labelText: "Email",
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter your Email";
                    }
                    if (isEmailFormated(input) == false) {
                      return "Please Enter a Valid Email";
                    }
                    return null;
                  },
                  textcontroller: emailController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: settingProvider.currentTheme == ThemeMode.light
                            ? Colors.black
                            : Colors.grey),
                    obscureText: !obsecureText,
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: obsecureText == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: "Password",
                      // labelStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return "Plaese enter your Password";
                      }
                      return null;
                    },
                  ),
                ),
                // CustomTextFormField(
                //   icon: Icons.visibility,
                //   obscuretext: true,
                //   labelText: "Password",
                //   validator: (input) {
                //     if (input == null || input.isEmpty) {
                //       return "Plaese enter your Password";
                //     }
                //     return null;
                //   },
                //   textcontroller: passwordController,
                // ),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: lightPrimaryColor, fontSize: 20),
                    )),

                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterForm.routeName);
                    },
                    child: Text(
                      "Don't have Account.",
                      style: TextStyle(color: lightPrimaryColor, fontSize: 17),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> checkLogin()async{
  //
  // }
  void login() async {
    var myAuthProvider = Provider.of<MyAuthProvider>(context, listen: false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isLogged = prefs.getBool("isLogin")?? false;
    // print(isLogged);
    // if(isLogged){
    //   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    //   return;
    // }
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      Dialogs.showLoadingDialogs(context, "Loading");
      await myAuthProvider.login(emailController.text, passwordController.text);
      // isLogin =true;
      // prefs.setBool("isLogin", true);
      // var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailController.text, password: passwordController.text);
      // UserDao.getUserApp(credential.user!.uid);
      // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      Dialogs.hideDialog(context);
      Dialogs.showMassege(
        context,
        "Logged Successfully",
        isbarrierDismissible: false,
        postiveActionTitle: "Ok",
        postiveAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      Dialogs.hideDialog(context);
      if (e.code == FireBaseErrorCore.userNotFound ||
          e.code == FireBaseErrorCore.wrongPassword) {
        Dialogs.showMassege(context, "Wrong email or password",
            postiveActionTitle: "Ok");
      }
    }
  }
}
