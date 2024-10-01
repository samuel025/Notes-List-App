import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_api/screens/add_list.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List")
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator(),),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}'),),
                title: Text(item['title']),
                subtitle: Text(item['description']),
              );
            }
          ),
        ),
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
  Future<void> fetchTodo() async {
    // ignore: prefer_const_declarations
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await  http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } 
    setState(() {
      isLoading = false;
    });
  }

} 