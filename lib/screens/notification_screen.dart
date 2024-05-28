import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'How News',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Lorem ipsum dolor sit amet'),
            leading: Icon(
              Icons.notifications_active,
              color: Colors.amber,
            ),
            trailing: Text('09.09 WIB'),
            shape: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          );
        },
      ),
    );
  }
}
