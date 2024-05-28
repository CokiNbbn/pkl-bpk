import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pkl/models/attendance.dart';
import 'package:test_pkl/provider/attendance_provider.dart';
import 'package:test_pkl/utils/attendance_service.dart';

class AddAttendance extends StatelessWidget {
  AddAttendance({super.key});

  final _userUid = FirebaseAuth.instance.currentUser!.uid;

  void _addAttendance(
      AttendanceProvider attendanceProvider, BuildContext context) {
    String action =
        attendanceProvider.isAttendanceIn ? 'Clock In' : 'Clock Out';
    Attendance attendance = Attendance(
      dateTime: DateTime.now(),
      action: action,
    );

    AttendanceService.uploadAttendance(
      context,
      attendance,
      _userUid,
    );

    attendanceProvider.toggleAttendance();

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var attendanceModel = Provider.of<AttendanceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Attendance'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPress: () {
                _addAttendance(attendanceModel, context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 24.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      attendanceModel.isAttendanceIn
                          ? Icons.login
                          : Icons.logout,
                      color: attendanceModel.isAttendanceIn
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      attendanceModel.isAttendanceIn ? 'Clock In' : 'Clock Out',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text.rich(
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
                children: [
                  TextSpan(
                    text: 'Long press to submit an attendance.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
