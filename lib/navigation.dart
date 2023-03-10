import 'package:checked/pages/goals.dart';
import 'package:checked/pages/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NavigationController {
  late void Function() onFABPressedTasks;
  late void Function() onFABPressedGoals;
  late void Function() onFABPressedAchievements;
  late void Function() onFABPressedStats;
}

class Navigation extends StatefulWidget {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Navigation({Key? key, required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final NavigationController navigationController = NavigationController();
  int selectedItem = 0;

  void onFABPressed() {
    switch (selectedItem) {
      case 0:
        navigationController.onFABPressedTasks();
        break;
      case 1:
        navigationController.onFABPressedGoals();
        break;
      case 2:
        navigationController.onFABPressedAchievements();
        break;
      case 3:
        navigationController.onFABPressedStats();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (selectedItem) {
      case 0:
        body = TasksPage(
          flutterLocalNotificationsPlugin:
              widget.flutterLocalNotificationsPlugin,
          navigationController: navigationController,
        );
        break;
      case 1:
        body = Goals(navigationController: navigationController,);
        break;
      default:
        body = Container();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checked"),
      ),
      body: SafeArea(child: body),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => onFABPressed(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor.withAlpha(255),
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black45,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: selectedItem,
          onTap: (int index) {
            setState(() {
              selectedItem = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.check),
                label: "Tasks",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.repeat),
                label: "Goals",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.military_tech),
                label: "Achievements",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.bar_chart),
                label: "Stats",
                backgroundColor: Theme.of(context).backgroundColor),
          ],
        ),
      ),
    );
  }
}
