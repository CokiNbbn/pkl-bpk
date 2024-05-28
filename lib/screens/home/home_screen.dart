import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pkl/screens/home/add_activity.dart';
import 'package:test_pkl/screens/home/add_attendance.dart';
import 'package:test_pkl/widgets/home/attendance_time.dart';
import 'package:test_pkl/widgets/home/date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authenticatedUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.amberAccent,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      _authenticatedUser.email!,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DisplayDate(),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => AddActivity(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.assignment_add,
                                        size: 36.0,
                                      ),
                                    ),
                                    Text('Activity')
                                  ],
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => AddAttendance(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add_location_alt,
                                        size: 36.0,
                                      ),
                                    ),
                                    Text('Attendance')
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AttendanceTime(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
