// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:godrej_login_auth/screens/palletisation_window_screen.dart';
import 'package:godrej_login_auth/screens/setting_screen.dart';
import 'package:godrej_login_auth/screens/stock_count_confirmattion.dart';
import 'package:godrej_login_auth/screens/store_out_confirmation_screen.dart';
import 'empty_pallet_in.dart';
import 'empty_pallet_out.dart';
import 'login_screen.dart';
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
              decoration: const BoxDecoration(
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
                  const SizedBox(height: 10),
                  Text(
                    _username,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pallet),
              title: const Text('Palletisation Window'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                         PalletisationPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trolley),
              title: const Text('Material Picking Window'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MaterialwindowPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_num_rounded),
              title: const Text('Store Out Confirmation'),
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
            ListTile(
              leading: const Icon(Icons.confirmation_num_rounded),
              title: const Text('Empty Pallet In Process'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EmptyPalletInScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_num_rounded),
              title: const Text('Empty Pallet Out Process'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        EmptyPalletStoreOutProcessScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_num_rounded),
              title: const Text('Stock Count Confirmation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                         StockCountConfirmationScreen(),
                  ),
                );
              },
            ),
            const Divider(
              color: Colors.indigoAccent,
            ),
            ListTile(
              leading: const Icon(Icons.account_box), // Add the icon for logout
              title: const Text('My Account'),
              onTap: () {
                // Implement My Account button press logic here
                print("My Account pressed");
                // Add your logic here for My Account
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings), // Add the icon for settings
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings), // Add the icon for settings
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StockCountConfirmationScreen()),
                );
              },
            ),
            const Divider(
              color: Colors.indigoAccent,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.pallet),
                    title: const Text('Palletisation Window'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                               PalletisationPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.trolley),
                    title: const Text('Material Picking Window'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                               MaterialwindowPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_num_rounded),
                    title: const Text('Store Out Confirmation'),
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
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_num_rounded),
                    title: const Text('Empty Pallet In Process'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                             EmptyPalletInScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_num_rounded),
                    title: const Text('Empty Pallet Out Process'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                               EmptyPalletStoreOutProcessScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_num_rounded),
                    title: const Text('Stock Count Confirmation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              StockCountConfirmationScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ));
  }
}




// TO CHANGE THE STYLE




//
// body: SingleChildScrollView(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const SizedBox(height: 20),
// const Center(
// child: Text(
// 'Welcome',
// style: TextStyle(fontSize: 30),
// ),
// ),
// const SizedBox(height: 20),
// Container(
// padding: const EdgeInsets.all(8),
// child: Column(
// children: [
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// PalletisationPage(),
// ),
// );
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: ListTile(
// leading: const Icon(Icons.pallet),
// title: const Text(
// 'Palletisation Window',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// const SizedBox(height: 8),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// MaterialwindowPage(),
// ),
// );
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: ListTile(
// leading: const Icon(Icons.trolley),
// title: const Text(
// 'Material Picking Window',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// const SizedBox(height: 8),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// StoreoutconfirmationPage(),
// ),
// );
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: ListTile(
// leading: const Icon(Icons.confirmation_num_rounded),
// title: const Text(
// 'Store Out Confirmation',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// const SizedBox(height: 8),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// EmptyPalletInScreen(),
// ),
// );
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: ListTile(
// leading: const Icon(Icons.confirmation_num_rounded),
// title: const Text(
// 'Empty Pallet In Process',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// const SizedBox(height: 8),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// EmptyPalletStoreOutProcessScreen(),
// ),
// );
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: ListTile(
// leading: const Icon(Icons.confirmation_num_rounded),
// title: const Text(
// 'Empty Pallet Out Process',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// const SizedBox(height: 8),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// StockCountConfirmationScreen(),
// ),
// );
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.blue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: ListTile(
// leading: const Icon(Icons.confirmation_num_rounded),
// title: const Text(
// 'Stock Count Confirmation',
// style: TextStyle(fontSize: 18),
// ),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ));
// }
// }
//
