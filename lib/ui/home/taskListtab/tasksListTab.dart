import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/database/tasks_dao.dart';
import 'package:untitled8/providers/settings_providers.dart';
import 'package:untitled8/ui/home/homeScreen.dart';
import 'package:untitled8/ui/home/settingTab/settingsTab.dart';
import 'package:untitled8/ui/widgets/task_item_widget.dart';
import '../../../providers/auth_provider.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var myauthProvider = Provider.of<MyAuthProvider>(context);
    var settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
            // activeColor: Theme.of(context).primaryColor,
            headerProps:  EasyHeaderProps(
              monthStyle: TextStyle(color: settingProvider.currentTheme==ThemeMode.light ? Colors.black:Theme.of(context).primaryColor),
              selectedDateStyle: TextStyle(color:settingProvider.currentTheme==ThemeMode.light ? Colors.black:Colors.white),
              dateFormatter: DateFormatter.monthOnly(),
            ),
            dayProps:  EasyDayProps(
              activeDayDecoration: BoxDecoration(color: settingProvider.currentTheme==ThemeMode.light ? Theme.of(context).primaryColor:Colors.white),
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              todayHighlightColor:settingProvider.currentTheme==ThemeMode.light ? Colors.transparent:Colors.white,
              borderColor: settingProvider.currentTheme==ThemeMode.light ? Colors.black:Colors.white,
              height: 80.0,
              width: 60.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(

                monthStrStyle: TextStyle(color:settingProvider.currentTheme==ThemeMode.light ? Colors.black:Colors.white , fontWeight: FontWeight.w700),
                dayStrStyle: TextStyle(color:settingProvider.currentTheme==ThemeMode.light ? Colors.black:Colors.white , fontWeight: FontWeight.w700 ),
                borderRadius: 48.0,
                dayNumStyle: TextStyle(
                  color:settingProvider.currentTheme==ThemeMode.light ? Colors.black:Colors.white,
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: DayStyle(
                dayStrStyle: TextStyle(  fontWeight: FontWeight.w700),
                monthStrStyle: TextStyle(color: settingProvider.currentTheme==ThemeMode.light ? Colors.black:Colors.white, fontWeight: FontWeight.w700),
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: TaskDao.listenForNewTask(
                  myauthProvider.databaseUserApp!.id!, selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text("Something went wrong"),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          },
                          child: Text("Try again"))
                    ],
                  );
                }
                var tasksList = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      TaskItemWidget(task: tasksList![index]),
                  itemCount: tasksList!.length ?? 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
