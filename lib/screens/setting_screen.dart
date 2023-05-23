// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   String _apiUrl = '';
//   bool _isApiUrlSet = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Load the saved API URL from shared preferences when the settings page is initialized
//     _loadApiUrl();
//   }
//   void _loadApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiUrl = prefs.getString('apiUrl') ?? '';
//     setState(() {
//       _apiUrl = apiUrl;
//       _isApiUrlSet = apiUrl.isNotEmpty;
//     });
//   }
//
//   void _saveApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('apiUrl', _apiUrl);
//     setState(() {
//       _isApiUrlSet = true;
//     });
//   }
//
//   void _cancelApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('apiUrl');
//     setState(() {
//       _apiUrl = '';
//       _isApiUrlSet = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop(); // Navigate back to previous screen
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: 400,
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'API URL:',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 enabled: !_isApiUrlSet,
//                 onChanged: (value) {
//                   setState(() {
//                     _apiUrl = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: _isApiUrlSet ? _apiUrl : 'Enter API URL',
//                   border: OutlineInputBorder(),
//                   enabledBorder: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveApiUrl,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16.0),
//                   ),
//                   child: Text('Save'),
//                 ),
//               ),
//               SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _cancelApiUrl,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16.0),
//                   ),
//                   child: Text('Cancel'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// neww  main    code      ahe


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _apiUrl = '';
  bool _isApiUrlSet = false;
  late TextEditingController _apiUrlController;

  // Add the fixed API URL
  static const String _fixedApiUrl = 'https://test.vastraindia.com/api';

  @override
  void initState() {
    super.initState();
    // Load the API URL from configuration when the settings page is initialized
    _loadApiUrl();
  }

  void _loadApiUrl() async {
    // Fetch the API URL from configuration
    String apiUrl = await fetchApiUrlFromConfiguration();

    setState(() {
      _apiUrl = apiUrl;
      _isApiUrlSet = apiUrl.isNotEmpty;
      _apiUrlController = TextEditingController(text: apiUrl);
    });
  }

  Future<String> fetchApiUrlFromConfiguration() async {
    // Perform your logic to retrieve the API URL from configuration
    // For example, you can read from a file or make an API request to get the URL
    // Return the retrieved API URL
    return 'https://test.vastraindia.com/api'; // Replace with your actual logic
  }

  void _saveApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String enteredUrl = _apiUrlController.text;

    // Check if the entered URL already contains the fixed API URL
    if (!enteredUrl.startsWith(_fixedApiUrl)) {
      // Concatenate the fixed URL with the entered URL
      enteredUrl = _fixedApiUrl + enteredUrl;
    }

    await prefs.setString('apiUrl', enteredUrl);

    setState(() {
      _apiUrl = enteredUrl;
      _isApiUrlSet = true;
    });
  }

  void _cancelApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedApiUrl = prefs.getString('apiUrl') ?? '';

    setState(() {
      _apiUrlController.text = storedApiUrl;
      _isApiUrlSet = false;
    });
  }

  @override
  void dispose() {
    _apiUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'API URL:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextField(
                enabled: !_isApiUrlSet,
                // Make the TextField editable if API URL is not set
                controller: _apiUrlController,
                decoration: InputDecoration(
                  hintText: 'Enter API URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _saveApiUrl,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Save'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _cancelApiUrl,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   String _apiUrl = '';
//   bool _isApiUrlSet = false;
//   late TextEditingController _apiUrlController;
//
//   // Add the fixed API URL
//   static const String _fixedApiUrl = 'https://test.vastraindia.com/api';
//
//   @override
//   void initState() {
//     super.initState();
//     // Load the API URL from configuration when the settings page is initialized
//     _loadApiUrl();
//   }
//
//   void _loadApiUrl() async {
//     // Fetch the API URL from the login API
//     String apiUrl = await fetchApiUrlFromLogin();
//
//     setState(() {
//       _apiUrl = apiUrl;
//       _isApiUrlSet = apiUrl.isNotEmpty;
//       _apiUrlController = TextEditingController(text: apiUrl); // Initialize the controller with the fetched URL
//     });
//   }
//
//
//
//   Future<String> fetchApiUrlFromLogin() async {
//     // Perform your logic to retrieve the API URL from the login API
//     // For example, you can make an HTTP request to the login API and extract the URL from the response
//     // Return the retrieved API URL
//     // Make sure to handle any errors that may occur during the request
//
//     // Example implementation using http package
//     final response = await http.get(Uri.parse('https://test.vastraindia.com/api/login/login'));
//
//     if (response.statusCode == 200) {
//       // Parse the response and extract the API URL
//       final apiUrl = jsonDecode(response.body)['apiUrl'];
//       return apiUrl;
//     } else {
//       // Handle the error case, such as returning a default URL or showing an error message
//       return 'https://test.vastraindia.com/api';
//     }
//   }
//
//
//   void _saveApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String enteredUrl = _apiUrlController.text;
//
//     // Check if the entered URL already contains the fixed API URL
//     if (!enteredUrl.startsWith(_fixedApiUrl)) {
//       // Concatenate the fixed URL with the entered URL
//       enteredUrl = _fixedApiUrl + enteredUrl;
//     }
//
//     await prefs.setString('apiUrl', enteredUrl);
//
//     setState(() {
//       _apiUrl = enteredUrl;
//       _isApiUrlSet = true;
//     });
//   }
//
//   void _cancelApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String storedApiUrl = prefs.getString('apiUrl') ?? '';
//
//     setState(() {
//       _apiUrlController.text = storedApiUrl;
//       _isApiUrlSet = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     _apiUrlController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'API URL:',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 enabled: !_isApiUrlSet,
//                 // Make the TextField editable if API URL is not set
//                 controller: _apiUrlController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter API URL',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 30.0),
//               ElevatedButton(
//                 onPressed: _saveApiUrl,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: Text('Save'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _cancelApiUrl,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: Text('Cancel'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }








//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
//
// class _SettingsPageState extends State<SettingsPage> {
//   String _apiUrl = '';
//   String _userEnteredApiUrl = '';
//   bool _isApiUrlSet = false;
//   TextEditingController _apiUrlController = TextEditingController();
//
//   // Add the fixed API URL
//   static const String _fixedApiUrl = 'https://test.vastraindia.com/api';
//
//   @override
//   void initState() {
//     super.initState();
//     // Load the API URL from configuration when the settings page is initialized
//     _loadApiUrl();
//   }
//
//   void _loadApiUrl() async {
//     // Fetch the API URL from configuration
//     String apiUrl = await fetchApiUrlFromConfiguration();
//
//     setState(() {
//       _apiUrl = apiUrl;
//       _isApiUrlSet = apiUrl.isNotEmpty;
//       _userEnteredApiUrl = apiUrl;
//       _apiUrlController.text = apiUrl;
//     });
//   }
//
//   Future<String> fetchApiUrlFromConfiguration() async {
//     // Perform your logic to retrieve the API URL from configuration
//     // For example, you can read from a file or make an API request to get the URL
//     // Return the retrieved API URL
//     return 'https://test.vastraindia.com/api'; // Replace with your actual logic
//   }
//
//   void _saveApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiUrl = _fixedApiUrl + _userEnteredApiUrl; // Concatenate the fixed URL and user-entered URL
//     await prefs.setString('apiUrl', apiUrl);
//     setState(() {
//       _apiUrl = apiUrl;
//       _isApiUrlSet = true;
//     });
//   }
//
//   void _cancelApiUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String storedApiUrl = prefs.getString('apiUrl') ?? '';
//     setState(() {
//       _userEnteredApiUrl = storedApiUrl;
//       _apiUrlController.text = storedApiUrl;
//       _isApiUrlSet = storedApiUrl.isNotEmpty;
//     });
//   }
//
//   @override
//   void dispose() {
//     _apiUrlController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop(); // Navigate back to the previous screen
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: 400,
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'API URL:',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 16.0),
//               TextField(
//                 controller: _apiUrlController,
//                 onChanged: (value) {
//                   setState(() {
//                     _userEnteredApiUrl = value;
//                   });
//                 },
//                 enabled: !_isApiUrlSet,
//                 decoration: InputDecoration(
//                   hintText: _isApiUrlSet ? _apiUrl : 'Enter API URL',
//                   border: OutlineInputBorder(),
//                   enabledBorder: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 30.0),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveApiUrl,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16.0),
//                   ),
//                   child: Text('Save'),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _cancelApiUrl,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16.0),
//                   ),
//                   child: Text('Cancel'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
