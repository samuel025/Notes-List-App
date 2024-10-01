import 'package:flutter/material.dart';
import 'package:flutter_crud_api/screens/add_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List")
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add Todo'),
      ),
    );
  }
  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddList(),
    );
    Navigator.push(context, route);
  }
} 