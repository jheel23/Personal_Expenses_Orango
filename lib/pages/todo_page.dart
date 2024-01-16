import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Daily Tasks'),
            trailing: Checkbox(
              value: true,
              checkColor: Colors.orange,
              onChanged: (value) {},
            ),
          ),
        );
      },
    );
  }
}
