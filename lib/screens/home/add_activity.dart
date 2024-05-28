import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pkl/models/activity.dart';
import 'package:test_pkl/utils/database_helper.dart';
import 'package:test_pkl/utils/date_formatter.dart';
import 'package:test_pkl/widgets/message_service.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 1),
      lastDate: DateTime(_selectedDate.year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveActivity() async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    String date = _selectedDate.toString();

    Activity activity = Activity(
      title: title,
      description: description,
      date: date,
    );

    await DatabaseHelper.getInstance(userId).insertActivity(activity);

    MessageService.showMySnackBar(context, 'Data successfully saved.');

    _titleController.clear();
    _descriptionController.clear();
    _selectedDate = DateTime.now();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveActivity,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title'),
            TextField(
              controller: _titleController,
              autofocus: true,
              maxLength: 100,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text('Description'),
            TextField(
              controller: _descriptionController,
              maxLength: 500,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text('Date'),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              child: TextButton(
                onPressed: _selectDate,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      DateFormatter.completeFormatDate(_selectedDate),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
