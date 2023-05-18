import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class EmptyPalletInScreen extends StatefulWidget {
  @override
  EmptyPalletInScreenState createState() => EmptyPalletInScreenState();
}

class EmptyPalletInScreenState extends State<EmptyPalletInScreen> {
  final TextEditingController _basePalletIdController = TextEditingController();
  final TextEditingController _numberOfPalletsController =
      TextEditingController();
  String _basePalletIdError = '';
  String _numberOfPalletsError = '';
  bool BasePalletIdMandatory = true;
  bool NumberOfPalletsMandatory = true;
  bool _isBasePalletIdUnique(String basePalletId) {
    return !enteredBasePalletIds.contains(basePalletId);
  }

  int minNumberOfPallets = 1;
  int maxNumberOfPallets = 7;
  List<String> enteredBasePalletIds = [];

  void _resetForm() {
    _basePalletIdController.clear();
    _numberOfPalletsController.clear();
    setState(() {
      _basePalletIdError = '';
      _numberOfPalletsError = '';
    });
  }

  void _confirmForm() async {
    String basePalletId = _basePalletIdController.text;
    String numberOfPallets = _numberOfPalletsController.text;

    // Validate base pallet ID and number of pallets
    if (_validateBasePalletId(basePalletId) &&
        _validateNumberOfPallets(numberOfPallets)) {
      if (!_isBasePalletIdUnique(basePalletId)) {
        setState(() {
          _basePalletIdError = 'Please enter a unique ID';
        });
        return;
      }

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
          print('Success');
          Navigator.of(context).pop();
        } else {
          setState(() {
            _basePalletIdError = 'Something went wrong, please try again';
          });
        }
      } else {
        setState(() {
          _basePalletIdError = 'Something went wrong, please try again';
        });
      }

      // Add the entered base pallet ID to the list
      enteredBasePalletIds.add(basePalletId);
    }
  }

  bool _validateBasePalletId(String basePalletId) {
    if (BasePalletIdMandatory && basePalletId.isEmpty) {
      setState(() {
        _basePalletIdError = 'Base Pallet ID is required';
      });
      return false;
    }

    setState(() {
      _basePalletIdError = '';
    });
    return true;
  }

  bool _validateNumberOfPallets(String numberOfPallets) {
    if (NumberOfPalletsMandatory && numberOfPallets.isEmpty) {
      setState(() {
        _numberOfPalletsError = 'Number of pallets is required';
      });
      return false;
    }

    int palletCount = int.tryParse(numberOfPallets) ?? 0;
    if (palletCount < minNumberOfPallets || palletCount > maxNumberOfPallets) {
      setState(() {
        _numberOfPalletsError =
            'Number of pallets should be between $minNumberOfPallets and $maxNumberOfPallets';
      });
      return false;
    }

    setState(() {
      _numberOfPalletsError = '';
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Pallet In Process'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            const Center(
              child: Text(
                'Empty Pallet Store In',
                style: TextStyle(
                  color: Colors.black54,
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
            const SizedBox(height: 15),
            TextFormField(
              controller: _basePalletIdController,
              onSaved: (value) {
                _basePalletIdController.text;
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ],
              decoration: InputDecoration(
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
                return null;
              },
            ),
            if (_basePalletIdError.isNotEmpty)
              Text(
                _basePalletIdError,
                style: const TextStyle(color: Colors.red),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Number of Pallets',
                suffix: NumberOfPalletsMandatory
                    ? const Text('*', style: TextStyle(color: Colors.red))
                    : null,
              ),
              validator: (value) {
                if (NumberOfPalletsMandatory && value!.isEmpty) {
                  return 'Number of pallets is required';
                }
                return null;
              },
            ),
            if (_numberOfPalletsError.isNotEmpty)
              Text(
                _numberOfPalletsError,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 30),
            Divider(),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 50, //height of button
                    width: 130, //width of button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .green.shade900, //background color of button
                            // side: const BorderSide(
                            //     width: 1,
                            //     color: Colors.brown), //border width and color
                            //elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(1)),
                            //padding: const EdgeInsets.all(20),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              //
                            ) //content padding inside button
                            ),
                        onPressed: () {
                          _confirmForm();
                          //code to execute when this button is pressed.
                        },
                        child: const Text("confirm"))),
                const Divider(),
                SizedBox(
                    height: 50, //height of button
                    width: 130, //width of button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 232, 24, 9), //background color of button
                            // side: const BorderSide(
                            //     width: 1,
                            //     color: Colors.brown), //border width and color
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(1)),
                            //padding: const EdgeInsets.all(20),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight
                              //     .bold
                            ) //content padding inside button
                            ),
                        onPressed: () {
                          _resetForm();
                          //code to execute when this button is pressed.
                        },
                        child: const Text("reset")))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//

// Add validation for unique base pallet ID if needed
// if (basePalletId != 'unique_id') {
//   setState(() {
//     _basePalletIdError = 'Please enter a unique ID';
//   });
//   return false;
// }
