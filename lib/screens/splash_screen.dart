import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 24.0,
              ),
              Image.asset(
                'images/logo-bpk.png',
                width: 160,
              ),
              const Text(
                'BPK RI',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              const CircularProgressIndicator(
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
