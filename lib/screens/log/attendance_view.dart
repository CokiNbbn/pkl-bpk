import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pkl/utils/attendance_service.dart';
import 'package:test_pkl/utils/date_formatter.dart';

class AttendanceView extends StatelessWidget {
  AttendanceView({super.key});

  final _user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AttendanceService.getAttendanceHistory(context, _user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            Map<DateTime, Map<String, String>> attendanceMap = snapshot.data!;
            return ListView.builder(
              itemCount: attendanceMap.length,
              itemBuilder: (context, index) {
                DateTime date = attendanceMap.keys.elementAt(index);
                Map<String, String> attendanceData = attendanceMap[date]!;

                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormatter.completeFormatDate(date),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.green,
                            ),
                            Text('Attendance In at'),
                            Text(
                              attendanceData['Clock In'] ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            Text('Attendance Out at'),
                            Text(
                              attendanceData['Clock Out'] ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('Nothing here yet.'),
          );
        },
      ),
    );
  }
}
