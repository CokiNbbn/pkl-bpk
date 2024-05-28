import 'package:flutter/material.dart';

import '../../utils/date_formatter.dart';

class DisplayDate extends StatelessWidget {
  const DisplayDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${DateFormatter.getCurrentDayOfWeek()},',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            DateFormatter.getCurrentFormattedDate(),
          ),
        ],
      ),
    );
  }
}
