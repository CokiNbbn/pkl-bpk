import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_pkl/widgets/message_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.username,
    required this.phoneNumber,
    required this.image,
  });

  final String username;
  final String phoneNumber;
  final dynamic image;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final authenticatedUser = FirebaseAuth.instance.currentUser!;
  File? _pickedImageFile;
  var _enteredUsername = '';
  var _enteredPhoneNumber = '';
  var _isLoading = false;

  void _save() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || _pickedImageFile == null) {
      return;
    }
    _formKey.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });

      final storage = FirebaseStorage.instance;
      final storageRef = await storage
          .ref()
          .child('profile-picture')
          .child('${authenticatedUser.uid}.jpg');

      await storageRef.putFile(_pickedImageFile!);
      final imageUrl = await storageRef.getDownloadURL();

      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(authenticatedUser.uid).set({
        'username': _enteredUsername,
        'phoneNumber': _enteredPhoneNumber,
        'imageUrl': imageUrl,
      });

      MessageService.showMySnackBar(context, 'Updating profile succeed.');
      Navigator.of(context).pop();
    } catch (e) {
      MessageService.showMySnackBar(context, 'Updating profile failed. Try again later.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    _pickedImageFile = File(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        actions: [
          !_isLoading
              ? IconButton(
                  onPressed: _save,
                  icon: Icon(Icons.done_all),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: 180.0,
                    height: 180.0,
                    child: Hero(
                      tag: 'profilePicture',
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundImage: widget.image != null
                            ? NetworkImage(widget.image)
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.amber,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(4.0),
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                24.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                      ),
                      initialValue: authenticatedUser.email,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Username',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextFormField(
                      initialValue: widget.username.trim().isEmpty
                          ? null
                          : widget.username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_rounded),
                      ),
                      onSaved: (newValue) {
                        _enteredUsername = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please input a valid value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Phone Number',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextFormField(
                      initialValue: widget.phoneNumber.trim().isEmpty
                          ? null
                          : widget.phoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                      ),
                      onSaved: (newValue) {
                        _enteredPhoneNumber = newValue!;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please input a valid value';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
