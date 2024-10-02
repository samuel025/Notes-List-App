// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:js_interop_unsafe';

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
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item['_id'] as String;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}'),),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if(value == 'edit'){

                    }else if(value == 'delete'){
                       
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete')
                      ),
                    ];
                  },
                ),
              );
            }
          ),
        ),
        child: const  Center(child: CircularProgressIndicator(),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add'),
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
  Future<void> deleteby_id(String id) async{
    final url = 'https://api.nstack.in/v1/todos/$id'; 
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        
      });
   }
  

}}