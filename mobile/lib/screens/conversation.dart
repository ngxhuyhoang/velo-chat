import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  State<StatefulWidget> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, index) {
        return ListTile(title: Text("Hello"));
      },
    );
  }
}
