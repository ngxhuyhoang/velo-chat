import 'package:flutter/material.dart';
import 'package:velo_chat/screens/conversation.dart';
import 'package:velo_chat/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [Conversation(), Profile()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (value) {
          setState(() {
            _currentTabIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Conversations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Conversations",
          ),
        ],
      ),
    );
  }
}
