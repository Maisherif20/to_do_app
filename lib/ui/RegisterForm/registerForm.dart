import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/providers/settings_providers.dart';
import 'package:untitled8/ui/firebaseErrorCode/fireBaseErrorCode.dart';
import 'package:untitled8/ui/login/login.dart';
import 'package:untitled8/ui/myThemeData.dart';
import 'package:untitled8/ui/utils/emailformatvalid.dart';
import 'package:untitled8/ui/widgets/customTextFormFiled.dart';
import '../../providers/auth_provider.dart';
import '../utils/dialogUtils.dart';

class RegisterForm extends StatefulWidget {
  static String routeName = "Register Screen";

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfermationController =
      TextEditingController();
  bool obsecureText=false;
  bool obsecureTextPassConfirm=false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var settingProvider=Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assests/images/background.png")),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text("Register"),
        // ),
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
                  labelText: "Full Name",
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please Enter your Full name";
                    }
                    return null;
                  },
                  textcontroller: fullNameController,
                ),
                CustomTextFormField(
                  labelText: "User Name",
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "please Enter your User Name";
                    }
                    return null;
                  },
                  textcontroller: userNameController,
                ),
                CustomTextFormField(
                  labelText: "Email",
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "please Enter your Email";
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
                    style: TextStyle(color: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.grey),
                    obscureText: !obsecureText ,
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      suffixIcon:  InkWell(
                        onTap: ()
                        {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: obsecureText == true ?Icon(Icons.visibility):Icon(Icons.visibility_off)
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return "Plaese enter your Password";
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    style: TextStyle(color: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.grey),
                    obscureText: !obsecureTextPassConfirm ,
                    controller: passwordConfermationController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      suffixIcon:  InkWell(
                        onTap: ()
                        {
                          setState(() {
                            obsecureTextPassConfirm = !obsecureTextPassConfirm;
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: obsecureText == true ?Icon(Icons.visibility):Icon(Icons.visibility_off)
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      labelText: "Password Confirmation",
                      labelStyle: TextStyle(color: Colors.black),
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
                //   labelText: "Password Confirmation",
                //   validator: (input) {
                //     if (input == null || input.isEmpty) {
                //       return "Please Enter Passowrd";
                //     } else if (input.length < 8) {
                //       return "Password must be at laest 6 characters";
                //     } else if (input != passwordController.text) {
                //       return "Passwords must match each other";
                //     }
                //     return null;
                //   },
                //   textcontroller: passwordConfermationController,
                // ),
                ElevatedButton(
                    onPressed: () {
                      createAccount();
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: lightPrimaryColor, fontSize: 20),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Login.routeName);
                    },
                    child: Text(
                      "Already Have Account.",
                      style: TextStyle(color: lightPrimaryColor, fontSize: 15),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      Dialogs.showLoadingDialogs(context, "Loading");
      authProvider.register(fullNameController.text, passwordController.text,
          userNameController.text, emailController.text);
      Dialogs.hideDialog(context);
      Dialogs.showMassege(context, "Registered Successfully",
          postiveActionTitle: "Ok", postiveAction: () {
        Navigator.pushReplacementNamed(context, Login.routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrorCore.weakPassword) {
        Dialogs.showMassege(context, 'The password provided is too weak.',
            postiveActionTitle: "Ok", postiveAction: () {
          Navigator.pop(context);
        });
        // print('The password provided is too weak.');
      } else if (e.code == FireBaseErrorCore.weakPassword) {
        Dialogs.showMassege(
            context, "The account already exists for that email.",
            postiveActionTitle: "Ok", postiveAction: () {
          Navigator.pop(context);
        });
        // print('The account already exists for that email.');
      }
    } catch (e) {
      Dialogs.showMassege(context, "Something Went Wrong",
          postiveActionTitle: "Ok", postiveAction: () {
        Navigator.pop(context);
      });
    }
  }
}
