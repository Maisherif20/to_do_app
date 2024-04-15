import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/database/tasks_dao.dart';
import 'package:untitled8/providers/auth_provider.dart';
import 'package:untitled8/providers/settings_providers.dart';
import 'package:untitled8/ui/home/edit_task_bottom_sheet.dart';
import 'package:untitled8/ui/utils/dialogUtils.dart';
import '../../database/task.dart';

class TaskItemWidget extends StatefulWidget {
  Task task;
  TaskItemWidget({required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var myAuthProvider = Provider.of<MyAuthProvider>(context);
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Slidable(
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        dragDismissible: false,
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            // borderRadius: BorderRadius.circular(22),
            onPressed: (context) {
              deleteTask();
            },
            backgroundColor: Color(0xFFFE4A49),
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            padding: EdgeInsets.all(8),
            // borderRadius: BorderRadius.circular(22),
            onPressed: (context) {
              showEditTaskBottomSheet();
            },
            backgroundColor:Theme.of(context).primaryColor,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 80,
              decoration: BoxDecoration(
                color: widget.task.isDone == true
                    ? Colors.green
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title ?? "",
                      style: TextStyle(
                          color: widget.task.isDone==true ? Colors.green :Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Text( widget.task.description ?? "" , style: TextStyle(color: settingProvider.currentTheme==ThemeMode.light?Colors.black:Colors.white ),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.date_range,
                              color: widget.task.isDone==true ? Colors.green:Theme.of(context).primaryColor, size: 15),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.task.datetime?.toDate().day} . ${widget.task.datetime?.toDate().month} . ${widget.task.datetime?.toDate().year} " ??
                                "",
                            style:
                                TextStyle(color: widget.task.isDone==true ? Colors.green:Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    widget.task.isDone = !widget.task.isDone!;
                    await TaskDao.update(myAuthProvider.databaseUserApp!.id!,
                        widget.task.id!, widget.task);
                  },
                  child: widget.task.isDone == true
                      ? Container(
                    margin: EdgeInsets.all(15),
                    padding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Text(
                            "Done",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                      )
                      : Container(
                          margin: EdgeInsets.all(15),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          width: 70,
                          decoration: BoxDecoration(
                            color: widget.task.isDone == true
                                ? Colors.green
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.check_sharp,
                            color: Colors.white,
                            weight: 30,
                            size: 30,
                          )),
                ),
                // IconButton(
                //     onPressed: () {
                //       showEditTaskBottomSheet();
                //     },
                //     icon: Icon(
                //       Icons.edit,
                //       color: Theme.of(context).primaryColor,
                //       size: 30,
                //     ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
    Dialogs.showMassege(
      context,
      "Are you sure to delete task",
      postiveActionTitle: "Ok",
      postiveAction: () async {
        // Dialogs.showLoadingDialogs(context, "Deleting task");
        await TaskDao.deleteTask(
            authProvider.databaseUserApp!.id!, widget.task.id!);
        // Dialogs.hideDialog(context);
        Dialogs.showMassege(
          context,
          "Task deleteed successfully",
          postiveActionTitle: "Ok",
        );
      },
      negativeActionTitle: "Cancel",
    );
  }

  void showEditTaskBottomSheet() {
    var settingProvider = Provider.of<SettingsProvider>(context , listen: false);
    showModalBottomSheet(
      backgroundColor: settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
        isScrollControlled: true,
        context: context,
        useRootNavigator: true,
        builder: (context) => EditTaskBottomSheet(
              task: widget.task,
            ));
  }
}
