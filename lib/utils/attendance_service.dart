import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_pkl/models/attendance.dart';
import 'package:test_pkl/widgets/message_service.dart';

class AttendanceService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> uploadAttendance(
      BuildContext context, Attendance attendance, String uid) async {
    try {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('attendance')
          .where('dateTime', isGreaterThanOrEqualTo: today)
          .where('dateTime', isLessThan: today.add(Duration(days: 1)))
          .get();

      if (querySnapshot.size < 2) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('attendance')
            .add({
          'dateTime': attendance.dateTime,
          'action': attendance.action,
        });
        MessageService.showMySnackBar(
          context,
          'Attendance added successfully.',
        );
      } else {
        MessageService.showMySnackBar(
          context,
          'You\'ve taken attendance today',
        );
      }
    } catch (e) {
      MessageService.showMySnackBar(
        context,
        'Error uploading attendance. Please try again later.',
      );
    }
  }

  static Future<Map<DateTime, Map<String, String>>> getAttendanceHistory(
      BuildContext context, String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('attendance')
          .get();

      Map<DateTime, Map<String, String>> attendanceMap = {};

      querySnapshot.docs.forEach((doc) {
        DateTime date = DateTime(doc['dateTime'].toDate().year,
            doc['dateTime'].toDate().month, doc['dateTime'].toDate().day);

        if (attendanceMap.containsKey(date)) {
          Map<String, String> existingData = attendanceMap[date]!;
          existingData[doc['action']] = doc['dateTime'].toDate().toString();
          attendanceMap[date] = existingData;
        } else {
          attendanceMap[date] = {
            doc['action']: doc['dateTime'].toDate().toString()
          };
        }
      });
      return attendanceMap;
    } catch (e) {
      MessageService.showMySnackBar(
        context,
        'Error getting attendance. Please try again later.',
      );
      return {};
    }
  }

  static Future<Map<String, String>> getAttendanceToday(
      BuildContext context, String uid) async {
    try {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('attendance')
          .where('dateTime', isGreaterThanOrEqualTo: today)
          .where('dateTime', isLessThan: today.add(Duration(days: 1)))
          .get();

      Map<String, String> attendanceToday = {};

      querySnapshot.docs.forEach((doc) {
        String action = doc['action'];
        String dateTime = doc['dateTime'].toDate().toString();
        attendanceToday[action] = dateTime;
      });

      if (!attendanceToday.containsKey('Clock In')) {
        attendanceToday['Clock In'] = 'N/A';
      }
      if (!attendanceToday.containsKey('Clock Out')) {
        attendanceToday['Clock Out'] = 'N/A';
      }

      return attendanceToday;
    } catch (e) {
      MessageService.showMySnackBar(
        context,
        'Error getting attendance. Please try again later.',
      );
      return {};
    }
  }
}
