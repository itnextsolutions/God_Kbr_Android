// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EditProfileScreen extends StatefulWidget {
  final String currentProfilePhoto;
  final String currentUsername;

  EditProfileScreen({
    required this.currentProfilePhoto,
    required this.currentUsername,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _profilePhoto = '';

  @override
  void initState() {
    super.initState();

    // Set initial values for username and profile photo
    _usernameController.text = widget.currentUsername;
    _profilePhoto = widget.currentProfilePhoto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(_profilePhoto),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get updated values from text field and image picker
                String updatedUsername = _usernameController.text;
                String updatedProfilePhoto = _profilePhoto;

                // Create a map of updated values to pass back to previous screen
                Map<String, dynamic> updatedData = {
                  'username': updatedUsername,
                  'profilePhoto': updatedProfilePhoto,
                };

                // Return updated data to previous screen
                Navigator.pop(context, updatedData);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
