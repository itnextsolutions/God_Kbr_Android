import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;



class PalletisationPage extends StatefulWidget {
  @override
  _PalletisationPageState createState() => _PalletisationPageState();
}

class _PalletisationPageState extends State<PalletisationPage> {
  final _formKey = GlobalKey<FormState>();
  bool value = false;

  TextEditingController _GRNumberController = TextEditingController();
  TextEditingController _PartNumberController = TextEditingController();
  TextEditingController _PartDescriptionController = TextEditingController();
  TextEditingController _Scan_EnterQuantityController = TextEditingController();
  TextEditingController _NotUsableController = TextEditingController();
  TextEditingController _EnterShelfLifeController = TextEditingController();
  TextEditingController _Scan_EnterPalletIdController = TextEditingController();

  bool _GRNumberMandatory = true;
  bool _PartNumberMandatory = true;
  bool _Scan_EnterQuantityMandatory = true;
  bool _Scan_EnterPalletIdMandatory = true;

  void _resetForm() {
    _GRNumberController.clear();
    _PartNumberController.clear();
    _PartDescriptionController.clear();
    _Scan_EnterQuantityController.clear();
    _NotUsableController.clear();
    _EnterShelfLifeController.clear();
    _Scan_EnterPalletIdController.clear();
  }

  void _confirmForm() async {
    if (_formKey.currentState!.validate()) {
      // Retrieve the values from the form fields
      String _GRNumberControllerValue = _GRNumberController.text;
      String _PartNumberControllerValue = _PartNumberController.text;
      String _PartDescriptionControllerValue = _PartDescriptionController.text;
      String _Scan_EnterQuantityControllerValue =
          _Scan_EnterQuantityController.text;
      // String _NotUsableControllerValue = _NotUsableController.text;
      String _EnterShelfLifeControllerValue = _EnterShelfLifeController.text;
      String _Scan_EnterPalletIdControllerValue =
          _Scan_EnterPalletIdController.text;

      // Create a map with the data to be sent in the request body
      Map<String, dynamic> requestData = {
        'grNumber': _GRNumberControllerValue,
        'partNumber': _PartNumberControllerValue,
        'partDescription': _PartDescriptionControllerValue,
        'quantity': _Scan_EnterQuantityControllerValue,
        'notusable': value,
        'shelfLife': _EnterShelfLifeControllerValue,
        'palletId': _Scan_EnterPalletIdControllerValue,
      };
      String requestBody = json.encode(requestData);
      // Make the API request
      try {
        final response = await http.post(
          Uri.parse('https://10.0.2.2:7058/api/palletization/insert'),
          body: requestBody,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          // Request successful, show confirmation dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                // content: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text('GR Number: $_GRNumberControllerValue'),
                //     Text('Part Number: $_PartNumberControllerValue'),
                //     Text('Part Description: $_PartDescriptionControllerValue'),
                //     Text('Scan/Enter Quantity: $_Scan_EnterQuantityControllerValue'),
                //     Text('Not Usable: $_NotUsableControllerValue'),
                //     Text('Enter Shelf Life: $_EnterShelfLifeControllerValue'),
                //     Text('Scan/Enter Pallet Id: $_Scan_EnterPalletIdControllerValue'),
                //   ],
                // ),
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
          // Request failed, show error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Failed to store data.'),
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
        }
      } catch (e) {
        // Exception occurred, show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An error occurred while api calling'),
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
      }
    }
  }

Future<void> _scanBarcode() async {
  String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
    '#FF0000',
    'Cancel',
    true, // Use true to enable flash
    ScanMode.DEFAULT, // Specify the scan mode
  );
  if (barcodeScanResult != '-1') {
    setState(() {
      _Scan_EnterPalletIdController.text = barcodeScanResult;
      _Scan_EnterQuantityController.text= barcodeScanResult;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palletisation Window'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'GR Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _GRNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter GR Number',
                    suffix: _GRNumberMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_GRNumberMandatory && value!.isEmpty) {
                      return 'GR Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  'Part Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _PartNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Part Number',
                    suffix: _PartNumberMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_PartNumberMandatory && value!.isEmpty) {
                      return 'Part Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  'Part Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _PartDescriptionController,
                  decoration: const InputDecoration(
                    // filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter Part Description',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Scan/Enter Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),                ),
                const SizedBox(height: 4),
                 Row(
                     children: [
                          Expanded(
                          flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                  controller: _Scan_EnterQuantityController,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Quantity',
                    suffix: _Scan_EnterQuantityMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_Scan_EnterQuantityMandatory && value!.isEmpty) {
                      return 'Quantity is required';
                    }
                    return null;
                  },
                ),
              ),
                const SizedBox(width: 16.0),
                   IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                      onPressed: _scanBarcode,
           ),
        ],
      ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align the checkbox and text to the start
                  crossAxisAlignment: CrossAxisAlignment.center, // Center the checkbox vertically with the text
                  children: [
                    const Text(
                      'Not Usable',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Increase the font size
                      ),                    ),
                    const SizedBox(width: 8), // Add some spacing between the text and checkbox
                    Checkbox(
                      activeColor: Colors.indigoAccent,
                      value: value,
                      onChanged: (value) => setState(() => this.value = value!),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                const Text(
                  'Enter Shelf Life',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Increase the font size
                    ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _EnterShelfLifeController,
                  decoration: const InputDecoration(
                    // filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter Shelf Life',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Scan/Enter Pallet Id',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),                ),
                const SizedBox(height: 4),
                    Row(
                     children: [
                          Expanded(
                          flex: 3,
                  child: TextFormField(
                  controller: _Scan_EnterPalletIdController,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Pallet Id',
                    suffix: _Scan_EnterPalletIdMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_Scan_EnterPalletIdMandatory && value!.isEmpty) {
                      return 'Pallet Id is required';
                    }
                    return null;
                  },
                ),
              ),
                 const SizedBox(width: 16.0),
                   IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                     onPressed: _scanBarcode,
             ),
           ],
         ),
                const SizedBox(height: 30),
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
                    const Divider(),
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
                          setState(() {
                            value = false; // Reset the value of the checkbox
                          });
                        },
                        child: const Text("Reset"),
                      ),
                    ),
                  ],
                ),],
            ),
          ),
        ),
      ),
    );
  }
}


