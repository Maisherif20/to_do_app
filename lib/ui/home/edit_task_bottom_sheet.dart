import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/database/tasks_dao.dart';
import 'package:untitled8/ui/utils/dialogUtils.dart';
import 'package:untitled8/ui/widgets/customTextFormFiled.dart';

import '../../database/task.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_providers.dart';

class EditTaskBottomSheet extends StatefulWidget {
  Task task;
  EditTaskBottomSheet({
    required this.task,
  });

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var desriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<MyAuthProvider>(context);
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Edit Task",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700 , color: settingProvider.currentTheme==ThemeMode.light?Theme.of(context).primaryColor:Colors.white)),
                TextFormField(
                  style: TextStyle(color: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.white),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                  ),
                  initialValue: widget.task.title,
                  onChanged: (value){
                    widget.task.title= value;
                    // await TaskDao.update(authProvider.databaseUserApp!.id!, widget.task.id!, widget.task);
                  },
                ),
                // CustomTextFormField(
                //   labelText: "Enter new title",
                //   textcontroller: titleController ,
                //   validator: (input) {
                //     if (input == null || input.isEmpty) {
                //       return "Please enter edited title";
                //     }
                //   },
                // ),
                // CustomTextFormField(
                //   maxLine: 4,
                //   labelText: "Enter new desription",
                //   textcontroller: desriptionController,
                //   validator: (input) {
                //     if (input == null || input.isEmpty) {
                //       return "Please enter edited desription";
                //     }
                //   },
                // ),
                SizedBox(height: 10,),
                TextFormField(
                  style: TextStyle(color: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.white),
                  maxLines: 4,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                  ),
                  initialValue: widget.task.description,
                  onChanged: (value){
                    widget.task.description= value;
                    // await TaskDao.update(authProvider.databaseUserApp!.id!, widget.task.id!, widget.task);
                  },
                ),
                InkWell(
                  onTap: () {
                    showTaskDatePicker();

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      finalSelecteedDate == null
                          ? "${widget.task.datetime!.toDate().day} . ${widget.task.datetime!.toDate().month} . ${widget.task.datetime!.toDate().year}"
                          : '${finalSelecteedDate?.day} . ${finalSelecteedDate?.month} . ${finalSelecteedDate?.year}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Visibility(
                    visible: showDateError,
                    child: Text(
                      "Please Select Time",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    )),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                  ),
                    onPressed: () {
                      updateRecord();
                    },
                    child: Text("Edit Task",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? finalSelecteedDate;
  bool showDateError = false;
  void showTaskDatePicker() async {
    var selecteedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blueAccent,
                onPrimary: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime.now().add(
          Duration(days: 365),
        ));
    finalSelecteedDate = selecteedDate;
    widget.task.datetime=Timestamp.fromDate(finalSelecteedDate!);
    if (mounted) {
      setState(() {});
    }
  }

  updateRecord() async {
    var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
    Dialogs.showMassege(context, "Are you sure to edit task?",
        postiveActionTitle: "Ok", postiveAction: () async {
      Dialogs.showLoadingDialogs(context, "Editing Task");
      // await TaskDao.updateTask(
      //     authProvider.databaseUserApp!.id!,
      //     widget.task.id!,
      //     titleController.text,
      //     desriptionController.text,
      //     finalSelecteedDate!);
      await TaskDao.update(authProvider.databaseUserApp!.id!, widget.task.id!,  widget.task);
      Dialogs.hideDialog(context);
      Dialogs.showMassege(context, "Task edited Sucessfully",
          postiveActionTitle: "Ok",
          postiveAction: () => Navigator.pop(context));
    }, negativeActionTitle: "Cancel");
  }

//   bool isFormValid() {
//     bool isvalid = true;
//     if (formKey.currentState?.validate() == false) {
//       isvalid = false;
//     }
//     if (finalSelecteedDate == null) {
//       setState(() {
//         showDateError = true;
//         isvalid = false;
//       });
//     } else {
//       showDateError = false;
//       if (mounted) {
//         setState(() => {});
//       }
//     }
//     return isvalid;
//   }
 }
