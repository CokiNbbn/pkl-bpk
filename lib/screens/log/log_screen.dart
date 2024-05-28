import 'package:flutter/material.dart';

import 'activity_view.dart';
import 'attendance_view.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Log'),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.only(bottom: 8.0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4,
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            labelColor: Colors.amber,
            indicatorColor: Colors.amber,
            tabs: [
              Text('Attendance'),
              Text('Activity'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AttendanceView(),
            ActivityView(),
          ],
        ),
      ),
    );
  }
}
