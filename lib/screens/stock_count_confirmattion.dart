// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StockCountConfirmationScreen extends StatefulWidget {
  const StockCountConfirmationScreen({super.key});

  @override
  _StockCountConfirmationScreenState createState() =>
      _StockCountConfirmationScreenState();
}

class _StockCountConfirmationScreenState
    extends State<StockCountConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool value = false;

  final  TextEditingController _ScanEnterPalletId = TextEditingController();
  final TextEditingController _PartNumberController = TextEditingController();
  final TextEditingController _PartDescriptionController =
      TextEditingController();
  final TextEditingController _PartQuantityController = TextEditingController();
  final TextEditingController _AvailableQuantityController =
      TextEditingController();
  final TextEditingController RemarkController = TextEditingController();

  final bool _ScanEnterPalletIdMandatory = true;
  final bool _PartNumberMandatory = true;
  final bool _PartQuantityMandatory = true;
  final bool RemarkMandatory = true;

  void _resetForm() {
    _ScanEnterPalletId.clear();
    _PartNumberController.clear();
    _PartDescriptionController.clear();
    _PartQuantityController.clear();
    _AvailableQuantityController.clear();
    RemarkController.clear();
  }

  void _confirmForm() {
    if (_formKey.currentState!.validate()) {
      String _ScanEnterPalletIdValue = _ScanEnterPalletId.text;
      String _PartNumberControllerValue = _PartNumberController.text;
      String _PartDescriptionControllerValue = _PartDescriptionController.text;
      String _PartQuantityControllerValue = _PartQuantityController.text;
      String _AvailableQuantityControllerValue =
          _AvailableQuantityController.text;
      String RemarkControllerValue = RemarkController.text;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scan/Enter Pallet Id : $_ScanEnterPalletIdValue'),
                Text('Part Number : $_PartNumberControllerValue'),
                Text('Part Description : $_PartDescriptionControllerValue'),
                Text('Part Quantity : $_PartQuantityControllerValue'),
                Text(' Available Quantity : $_AvailableQuantityControllerValue'),
                Text('Remark : $RemarkControllerValue'),
              ],
            ),
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

  Future<void> _scanBarcode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true, // Use true to enable flash
      ScanMode.DEFAULT, // Specify the scan mode
    );
    if (barcodeScanResult != '-1') {
      setState(() {
        _ScanEnterPalletId.text = barcodeScanResult;

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Count Confirmation'),
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
                  'Scan/Enter Pallet Id',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
            Row(
              children: [
              Expanded(
              flex: 3,
              child: TextFormField(
                  controller: _ScanEnterPalletId,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Scan/Enter Pallet Id',
                    suffix: _ScanEnterPalletIdMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_ScanEnterPalletIdMandatory && value!.isEmpty) {
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
                const SizedBox(height: 15),
                const Text(
                  'Part Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _PartNumberController,
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
                  ),
                ),
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
                  'Pallet Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _PartQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Pallet Quantity',
                    suffix: _PartQuantityMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_PartQuantityMandatory && value!.isEmpty) {
                      return 'Quantity is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  ' Available Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _AvailableQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    // filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter Available Quantity',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Remark',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: RemarkController,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Remark',
                    suffix: RemarkMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (RemarkMandatory && value!.isEmpty) {
                      return 'Pallet Id is required';
                    }
                    return null;
                  },
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
                   // const Divider(),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 232, 24, 9),
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
          ),
        ),
      ),
    );
  }
}
