import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pkl/widgets/login_button.dart';
import 'package:test_pkl/widgets/login_textfield.dart';
import 'package:test_pkl/widgets/message_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MessageService.showMySnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        MessageService.showMySnackBar(
            context, 'Wrong password provided for that user.');
      }
    } catch (e) {
      MessageService.showMySnackBar(context, 'Authentication failed.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
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
                  height: 60.0,
                ),
                LoginTextField(
                  hintText: 'Email',
                  icon: const Icon(Icons.email),
                  controller: _emailController,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                LoginTextField(
                  hintText: 'Password',
                  icon: const Icon(Icons.lock),
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 48.0,
                ),
                LoginButton(
                  login: _login,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
