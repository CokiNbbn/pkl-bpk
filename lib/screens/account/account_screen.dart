import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pkl/screens/account/edit_profile.dart';
import 'package:test_pkl/widgets/logout_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _authenticatedUser = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> _getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await _firestore.collection('users').doc(_authenticatedUser.uid).get();

    return userData.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text('Loading your data...'),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            var username = snapshot.data!['username'];
            var phoneNumber = snapshot.data!['phoneNumber'];
            var imageUrl = snapshot.data!['imageUrl'];

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                const Text(
                  'Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Card(
                  color: Colors.grey.shade50,
                  child: ListTile(
                    splashColor: Colors.transparent,
                    title: Text(username),
                    subtitle: Text(_authenticatedUser.email!),
                    leading: Hero(
                      tag: 'profilePicture',
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundImage:
                            imageUrl != null ? NetworkImage(imageUrl) : null,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => EditProfileScreen(
                            username: username,
                            phoneNumber: phoneNumber,
                            image: imageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                LogoutButton(),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: Colors.grey.shade50,
                  child: ListTile(
                    splashColor: Colors.transparent,
                    title: Text('Update your profile'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => EditProfileScreen(
                            username: '',
                            phoneNumber: '',
                            image: null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                LogoutButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
