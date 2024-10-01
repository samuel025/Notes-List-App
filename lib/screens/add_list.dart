import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: ListView( 
        padding: const EdgeInsets.all(20),
         children:  [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: descController,
            decoration: InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: submitData,
            child: const Text("submit")
          )
        ],
      ),
    );
  }
  Future<void> submitData () async {
    final title = titleController.text;
    final description = descController.text;

    final body = {
      "title": title,
      "description" : description,
      "is_completed" : false
    };

    // ignore: prefer_const_declarations
    final url = 'https://api.nstack.in/v1/todos';
    final uri =  Uri.parse(url);
    final response = await http.post(
      uri, body:jsonEncode(body), 
      headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 201) {
        titleController.text = '';
        descController.text = '';
        showSuccessMessage('Creation Success');
    }else {
        showFailureMessage('creation failed');
    }
  }

  void showSuccessMessage (String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFailureMessage (String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}