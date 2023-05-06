import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _apiUrl = '';
  bool _isApiUrlSet = false;

  @override
  void initState() {
    super.initState();
    // Load the saved API URL from shared preferences when the settings page is initialized
    _loadApiUrl();
  }

  void _loadApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = prefs.getString('apiUrl') ?? '';
    setState(() {
      _apiUrl = apiUrl;
      _isApiUrlSet = apiUrl.isNotEmpty;
    });
  }

  void _saveApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiUrl', _apiUrl);
    setState(() {
      _isApiUrlSet = true;
    });
  }

  void _cancelApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('apiUrl');
    setState(() {
      _apiUrl = '';
      _isApiUrlSet = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'API URL:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextField(
                enabled: !_isApiUrlSet,
                onChanged: (value) {
                  setState(() {
                    _apiUrl = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: _isApiUrlSet ? _apiUrl : 'Enter API URL',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveApiUrl,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text('Save'),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _cancelApiUrl,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
