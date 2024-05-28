import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStatePropertyAll(
          BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      ),
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
