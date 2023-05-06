import 'package:flutter/material.dart';
import 'package:godrej_login_auth/screens/palletisation_window_screen.dart';
import 'package:godrej_login_auth/screens/setting_screen.dart';
import 'package:godrej_login_auth/screens/store_out_confirmation_screen.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'material_packing_window.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _profilePhoto = 'assets/profile.png';
  String _username = 'admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
        actions: <Widget>[],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(_profilePhoto),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    _username,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.pallet),
              title: Text('Palletisation Window'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PalletisationPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.trolley),
              title: Text('Material Picking Window'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MaterialwindowPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.confirmation_num_rounded),
              title: Text('Store Out Confirmation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        StoreoutconfirmationPage(),
                  ),
                );
              },
            ),

            Divider(
              color: Colors.indigoAccent,
            ),

            ListTile(
              leading: Icon(Icons.account_box), // Add the icon for logout
              title: Text('My Account'),
              onTap: () {
                // Implement My Account button press logic here
                print("My Account pressed");
                // Add your logic here for My Account
              },
            ),

            ListTile(
              leading: Icon(Icons.settings), // Add the icon for settings
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()),
                );
              },
            ),
            Divider(
              color: Colors.indigoAccent,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
