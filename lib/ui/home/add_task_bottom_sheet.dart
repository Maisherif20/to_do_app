import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/providers/auth_provider.dart';
import 'package:untitled8/ui/utils/dialogUtils.dart';
import 'package:untitled8/ui/widgets/customTextFormFiled.dart';

import '../../database/task.dart';
import '../../database/tasks_dao.dart';
import '../../providers/settings_providers.dart';

class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var desriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Card(
      color: settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Add new task",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700 , color: settingProvider.currentTheme==ThemeMode.light?Theme.of(context).primaryColor:Colors.white)),
              CustomTextFormField(
                labelColor: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.grey,
                textcontroller: titleController,
                labelText: "Task Title",
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return "Please Enter Task Title ";
                  }
                },
              ),
              CustomTextFormField(
                labelColor: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.grey,
                textcontroller: desriptionController,
                labelText: "Task Description",
                maxLine: 4,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return "Please Enter Description";
                  }
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
                        ? "Select Time"
                        : '${finalSelecteedDate?.day} . ${finalSelecteedDate?.month} . ${finalSelecteedDate?.year}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Visibility(
                  visible: showDateError,
                  child: Text(
                    "Please Select Time",
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  )),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  onPressed: () {
                    addTask();
                  },
                  child: Text("Add Task",
                      style: TextStyle(
                        fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)))
            ],
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
    setState(() {});
  }

  void addTask() async {
    var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
    if (!isFormValid()) {
      return;
    }
    Task task = Task(
      title: titleController.text,
      description: desriptionController.text,
      datetime: Timestamp.fromDate(finalSelecteedDate!),
    );
    Dialogs.showLoadingDialogs(context, "Creating Task");
    await TaskDao.addTask(task, authProvider.databaseUserApp!.id!);
    Dialogs.hideDialog(context);
    Dialogs.showMassege(context, "Task Created Sucessfully",
        postiveActionTitle: "Ok", postiveAction: () {
      Navigator.pop(context);
    });
  }

  bool isFormValid() {
    bool isvalid = true;
    if (formKey.currentState?.validate() == false) {
      isvalid = false;
    }
    if (finalSelecteedDate == null) {
      setState(() {
        showDateError = true;
        isvalid = false;
      });
    } else {
      showDateError = false;
      if (mounted) {
        setState(() => {});
      }
    }
    return isvalid;
  }
}
