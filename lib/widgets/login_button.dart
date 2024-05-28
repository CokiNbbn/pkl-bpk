import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.login,
    required this.isLoading,
  });

  final void Function() login;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Colors.amber,
        ),
      ),
      onPressed: login,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: !isLoading
              ? const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
