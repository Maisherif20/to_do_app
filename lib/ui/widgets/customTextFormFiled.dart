import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/ui/myThemeData.dart';

import '../../providers/settings_providers.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatefulWidget {

  String labelText;
  Validator? validator;
  TextEditingController? textcontroller;
  bool obscuretext;
  IconData? icon;
  int? maxLine;
  String? initial_Value;
  Color? labelColor;
  CustomTextFormField(
      {required this.labelText, this.validator, this.textcontroller ,this.obscuretext=false , this.icon , this.maxLine , this.initial_Value , this.labelColor});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.grey),
        initialValue: widget.initial_Value,
        maxLines: widget.maxLine,
        cursorColor: Theme.of(context).primaryColor,
        // obscureText: widget.obscuretext,
        validator: widget.validator,
        controller: widget.textcontroller,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.blue),
          suffixIcon:  InkWell(
            onTap: ()
            {
              setState(() {
                widget.obscuretext =!widget.obscuretext;
              });
            },
            child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(widget.icon)
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
          labelText: widget.labelText,
          labelStyle: TextStyle(color: widget.labelColor),
        ),
      ),
    );
  }
}
