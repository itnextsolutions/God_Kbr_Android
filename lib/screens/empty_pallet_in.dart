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
  final TextEditingController _numberOfPalletsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _basePalletIdError = '';
  String _numberOfPalletsError = '';
  bool BasePalletIdMandatory = true;
  bool NumberOfPalletsMandatory = true;
  bool _isBasePalletIdUnique(String basePalletId) {
    return !enteredBasePalletIds.contains(basePalletId);
  }
  bool _validateBasePalletId(String basePalletId) {
    if (basePalletId.isEmpty) {
      setState(() {
        _basePalletIdError = 'Base Pallet ID is required';
      });
      return false;
    }

    int id = int.tryParse(basePalletId) ?? 0;
    if (id < 10001 || id > 99999) {
      setState(() {
        _basePalletIdError = 'Base Pallet ID should be between 10001 and 99999';
      });
      return false;
    }

    setState(() {
      _basePalletIdError = '';
    });
    return true;
  }

  int minNumberOfPallets = 1;
  int maxNumberOfPallets =99;
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
    bool isBasePalletIdValid = _validateBasePalletId(basePalletId);
    bool isNumberOfPalletsValid = _validateNumberOfPallets(numberOfPallets);

    if (isBasePalletIdValid && isNumberOfPalletsValid) {
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Data stored successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
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
        'Number of pallets should be between $minNumberOfPallets to $maxNumberOfPallets';
      });
      return false;
    }

    setState(() {
      _numberOfPalletsError = '';
    });
    return true;
  }


  Future<void> _scanBarcode() async {
    try {
      // Invoke the platform-specific scanner using method channels
      final result = await MethodChannel('your.channel.name').invokeMethod('scanBarcode');
      if (result != null) {
        setState(() {
          _basePalletIdController.text = result;
        });
      }
    } on PlatformException catch (e) {
      // Handle platform exceptions, if any
      print('PlatformException: ${e.message}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Pallet In Process'),
      ),
        body: SingleChildScrollView(
        child: Container(
        width: 400,
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(),
            const SizedBox(height: 15),
            const Text(
              'Base Pallet ID',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // Increase the font size
              ),
            ),
            // const SizedBox(height: 15),


        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
                flex: 3,
                child:
            TextFormField(
              autofocus: true,
              controller: _basePalletIdController,
              onSaved: (value) {
                _basePalletIdController.text;
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            )
        ),
            const SizedBox(width: 16.0),
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: _scanBarcode,
            ),
          ]
        ),
            if (_basePalletIdError.isNotEmpty)
              Text(
                _basePalletIdError,
                style: const TextStyle(color: Colors.red),
              ),


            const SizedBox(height: 15),
            const Text(
              'Number of Pallets',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // Increase the font size
              ),
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
            SizedBox(height: 30),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      _confirmForm();
                      // Code to execute when this button is pressed.
                    },
                    child: const Text("Confirm"),
                  ),
                ),
                //const Divider(),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      _resetForm();
                    },
                    child: const Text("Reset"),
                  ),
                ),
              ],
            ),
          ],

      ),
    ))));
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