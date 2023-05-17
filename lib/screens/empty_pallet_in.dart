import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class EmptyPalletInScreen extends StatefulWidget {
  @override
  _EmptyPalletInScreenState createState() => _EmptyPalletInScreenState();
}

class _EmptyPalletInScreenState extends State<EmptyPalletInScreen> {
  final TextEditingController _basePalletIdController = TextEditingController();
  final TextEditingController _numberOfPalletsController =
  TextEditingController();
  //final bool isNumericType =  "Base Pallet ID";
  String _dataError = '';
  bool BasePalletIdMandatory = true;
  bool NumberOfPlletsMandatory = true;
  // RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
  //   return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  // }
  // RegExp _getRegExp(bool isNumericKeyBoard) {
  //   return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  // }



  void _resetForm() {
    _basePalletIdController.clear();
    _numberOfPalletsController.clear();
  }

  void _confirmForm() {
    String basePalletId = _basePalletIdController.text;
    String numberOfPallets = _numberOfPalletsController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Confirmation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Base Pallet ID: $basePalletId'),
                Text('Number of Pallets: $numberOfPallets'),
              ],
            ),
          actions: [
            // TextButton(


            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () async {
                // Reset data error before making a login request
                setState(() {
                  _dataError = ''; // Reset error message
                });

                http.Response response = await http.post(
                  Uri.parse('https://10.0.2.2:7058/api/pallet/InsertPalletIn'),
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    "HU_ID": _basePalletIdController.text,
                    "HU_VOL": _numberOfPalletsController.text,

                  }),
                );

                if (response.statusCode == 200) {
                  var responseData = json.decode(response.body);
                  if (responseData == "Success") {
                    // ignore: avoid_print
                    print('success');
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    //ignore: use_build_context_synchronously
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //       // builder: (context) => const HomeScreen(),
                    //       builder: (context) => PalletisationPage()),
                    // );
                  } else {
                    setState(() {
                      _dataError = 'Invalid data ';
                      //'Something went wrong, please try again'; // Update error message
                    });
                  }
                } else {
                  setState(() {
                    _dataError =
                    'Something went wrong, please try again'; // Update error message
                  });
                }
              },

              // onPressed: () {
              //   Navigator.of(context).pop();
              // }
              child: const Text('ok'),
            ),
            const SizedBox(height: 4),
            Text(
              _dataError, // Display the login error message
              style: const TextStyle(color: Colors.red),
            ),

            // pallatizationwindowErrorWidget = Visibility(
            //   visible: _dataError.isNotEmpty,
            //   child: Text(
            //     _dataError,
            //     style: const TextStyle(
            //       color: Colors.red,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),

            //),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Pallet In Process'),
      ),
      body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: const Text(
                  'Empty Pallet Store In',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Base Pallet ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const  SizedBox(height: 15),

              TextFormField(
                controller: _basePalletIdController,
                onSaved: (value){
                  _basePalletIdController.text;
                },
                //keyboardType: TextInputType.number,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                decoration: InputDecoration(
                  // filled: true,
                  border: const OutlineInputBorder(),
                  hintText: 'Base Pallet ID',
                  suffix: BasePalletIdMandatory
                      ? const Text('*', style: TextStyle(color: Colors.red))
                      : null,
                ),
                validator: (value) {
                  if (BasePalletIdMandatory && value!.isEmpty) {
                    return 'Number of pallets is required';
                  }
                  // if () {
                  //   return 'Number of pallets is required';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Number of Pallets',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),
              TextFormField(
                controller: _numberOfPalletsController,
                onSaved: (value) {
                  _numberOfPalletsController.text = value!;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                decoration: InputDecoration(
                  // filled: true,
                  border: const OutlineInputBorder(),
                  hintText: 'Number of Pallets',
                  suffix: NumberOfPlletsMandatory
                      ? const Text('*', style: TextStyle(color: Colors.red))
                      : null,
                ),
                validator: (value) {
                  if (NumberOfPlletsMandatory && value!.isEmpty) {
                    return 'Number of pallets is required';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _confirmForm,
                    child: Text('Confirm'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetForm,
                    child: Text('Reset'),
                  ),
                ],
              ),

            ],
          ),
        ),

    );
  }
}

