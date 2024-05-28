import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier{
  bool _isAttendanceIn = true;

  bool get isAttendanceIn => _isAttendanceIn;

  void toggleAttendance() {
    _isAttendanceIn = !_isAttendanceIn;
    notifyListeners();
  }
}