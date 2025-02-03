import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoist/models/task.dart';
import 'package:todoist/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void _savetask() async {
    final newtask = Tasks(
      id:Uuid().v1(),
      title: _titleController.text,
      description: _descriptionController.text,
    );
    await _firestoreService.addTask(newtask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: GoogleFonts.sansita(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _savetask();
                Navigator.pop(context);
              },
              child: Text(
                "Add Task",
                style: GoogleFonts.sansita(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
