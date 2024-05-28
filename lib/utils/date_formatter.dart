import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String completeFormatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy').format(date);
  }

  static String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  static String getCurrentFormattedDate() {
    DateTime now = DateTime.now();
    return formatDate(now);
  }

  static String getCurrentDayOfWeek() {
    DateTime now = DateTime.now();
    return getDayOfWeek(now.weekday);
  }
}