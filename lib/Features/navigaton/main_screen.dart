import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/Features/home/home_screen.dart' show HomeScreen;
import 'package:tasky/Features/profile/profile_screen.dart';
import 'package:tasky/Features/tasks/completed_tasks_screen.dart';
import 'package:tasky/Features/tasks/todoo_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    TodoTasks(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/home_icon.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/todo_icon.svg', 1),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/completed_icon.svg', 2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/profile_icon.svg', 3),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
