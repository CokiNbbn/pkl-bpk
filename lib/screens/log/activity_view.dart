import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pkl/utils/date_formatter.dart';
import 'package:test_pkl/widgets/message_service.dart';

import '../../utils/database_helper.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  List<Map<String, dynamic>> _activityList = [];
  late final _database;
  late final String _userId;

  @override
  void initState() {
    _getUserAndInitializeDatabase();
    super.initState();
  }

  void _getUserAndInitializeDatabase() async {
    final user = FirebaseAuth.instance.currentUser;
    _userId = user!.uid;
    _database = DatabaseHelper.getInstance(_userId);
    _loadActivityList();
  }

  void _loadActivityList() async {
    final activities = await _database.getActivities();
    final List<Map<String, dynamic>> sortedActivities = List.from(activities);
    sortedActivities.sort(
      (a, b) => DateTime.parse(b['date']).compareTo(
        DateTime.parse(a['date']),
      ),
    );
    setState(() {
      _activityList = sortedActivities;
    });
  }

  void _deleteActivity(int id) async {
    await _database.deleteActivity(id);
    _loadActivityList();

    MessageService.showMySnackBar(context, 'Successfully deleted.');
  }

  @override
  Widget build(BuildContext context) {
    if (_activityList.isEmpty) {
      return Center(
        child: Text('Nothing here yet.'),
      );
    }

    return ListView.builder(
      itemCount: _activityList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      children: [
                        Icon(Icons.calendar_month),
                        Text(
                          DateFormatter.completeFormatDate(
                            DateTime.parse(_activityList[index]['date']),
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteActivity(_activityList[index]['id']);
                      },
                      icon: Icon(Icons.cancel_outlined),
                      color: Colors.redAccent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  _activityList[index]['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(_activityList[index]['description']),
              ],
            ),
          ),
        );
      },
    );
  }
}
