import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/ui/home/settingTab/settingsTab.dart';
import 'package:untitled8/ui/home/taskListtab/tasksListTab.dart';
import 'package:untitled8/ui/myThemeData.dart';

import '../../providers/settings_providers.dart';
import 'add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selecteedIndex = 0;

  List<Widget> tabs = [TasksListTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: tabs[selecteedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
        backgroundColor: lightPrimaryColor,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: ListView(
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: selecteedIndex,
              onTap: (index) {
                selecteedIndex = index;
                if (mounted) {
                  setState(() {

                  });
                }
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: ""),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() {
    var settingProvider = Provider.of<SettingsProvider>(context ,listen: false );
    showModalBottomSheet(
      backgroundColor: settingProvider.currentTheme==ThemeMode.light?Colors.white:Color.fromRGBO(20, 25, 34, 1),
      isScrollControlled: true,
        context: context,useRootNavigator: true, builder: (context) => AddTaskBottomSheet());
  }
}


// BottomNavigationBar(
// items: [
// BottomNavigationBarItem(icon: Icon(Icons.list), label:""),
// BottomNavigationBarItem(
// icon: Icon(Icons.settings_outlined), label:""),
// ],
// IconButton(onPressed: () {}, icon: Icon(Icons.list) , padding: EdgeInsets.only(left: 50),),
// Spacer(),
// IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined) , padding: EdgeInsets.only(right: 50),,),
