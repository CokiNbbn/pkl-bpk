import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_pkl/utils/attendance_service.dart';

class AttendanceTime extends StatefulWidget {
  AttendanceTime({super.key});

  @override
  State<AttendanceTime> createState() => _AttendanceTimeState();
}

class _AttendanceTimeState extends State<AttendanceTime> {
  late Future<Map<String, String>> _attendanceToday;
  final _user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _attendanceToday = AttendanceService.getAttendanceToday(context, _user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _attendanceToday,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, String> attendanceToday =
              snapshot.data as Map<String, String>;
          final clockIn = attendanceToday['Clock In'] ?? 'N/A';
          final clockOut = attendanceToday['Clock Out'] ?? 'N/A';

          DateTime clockInDateTime =
              clockIn != 'N/A' ? DateTime.parse(clockIn) : DateTime(0);
          DateTime clockOutDateTime =
              clockOut != 'N/A' ? DateTime.parse(clockOut) : DateTime(0);

          String formattedClockIn = clockInDateTime != DateTime(0)
              ? DateFormat('HH:mm').format(clockInDateTime)
              : 'N/A';
          String formattedClockOut = clockOutDateTime != DateTime(0)
              ? DateFormat('HH:mm').format(clockOutDateTime)
              : 'N/A';

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      formattedClockIn,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.login,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'In',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      formattedClockOut,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Out',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
