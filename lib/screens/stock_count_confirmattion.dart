// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

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

  final TextEditingController _PalletId = TextEditingController();
  final TextEditingController _PartNumberController = TextEditingController();
  final TextEditingController _PartDescriptionController =
      TextEditingController();
  final TextEditingController _PartQuantityController = TextEditingController();
  //final TextEditingController _NotUsableController = TextEditingController();
  final TextEditingController _AvailableQuantityController =
      TextEditingController();
  final TextEditingController _Scan_RemarkController = TextEditingController();

  final bool _PalletIdMandatory = true;
  final bool _PartNumberMandatory = true;
  final bool _PartQuantityMandatory = true;
  final bool _RemarkMandatory = true;

  void _resetForm() {
    _PalletId.clear();
    _PartNumberController.clear();
    _PartDescriptionController.clear();
    _PartQuantityController.clear();
    // _NotUsableController.clear();
    _AvailableQuantityController.clear();
    _Scan_RemarkController.clear();
  }

  void _confirmForm() {
    if (_formKey.currentState!.validate()) {
      String _PalletIdValue = _PalletId.text;
      String _PartNumberControllerValue = _PartNumberController.text;
      String _PartDescriptionControllerValue = _PartDescriptionController.text;
      String _PartQuantityControllerValue = _PartQuantityController.text;
      //String _NotUsableControllerValue = _NotUsableController.text;
      String _AvailableQuantityControllerValue =
          _AvailableQuantityController.text;
      String _Scan_RemarkControllerValue = _Scan_RemarkController.text;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GR Number : $_PalletIdValue'),
                Text('Part Number : $_PartNumberControllerValue'),
                Text('Part Description : $_PartDescriptionControllerValue'),
                Text('Scan/Enter Quantity : $_PartQuantityControllerValue'),
                // Text('Not Usable : $_NotUsableControllerValue'),
                Text('Enter Shelf Life : $_AvailableQuantityControllerValue'),
                Text('Scan/Enter Pallet Id : $_Scan_RemarkControllerValue'),
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
                  'Pallet Id',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _PalletId,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Pallet Id',
                    suffix: _PalletIdMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_PalletIdMandatory && value!.isEmpty) {
                      return 'Pallet Id is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  'Part Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  'Scan/Enter Quantity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _PartQuantityController,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Quantity',
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
                // const SizedBox(height: 15),
                // CheckboxListTile(
                //     activeColor: Colors.indigoAccent,
                //     title: const Text(
                //       'Not Usable',
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     value: value,
                //     onChanged: ((value) =>
                //         setState(() => this.value = value!))),
                const SizedBox(height: 15),
                const Text(
                  'Enter Available Quantity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _AvailableQuantityController,
                  decoration: const InputDecoration(
                    // filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter Shelf Life',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Scan/Enter Pallet Id',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _Scan_RemarkController,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Remark',
                    suffix: _RemarkMandatory
                        ? const Text('*', style: TextStyle(color: Colors.red))
                        : null,
                  ),
                  validator: (value) {
                    if (_RemarkMandatory && value!.isEmpty) {
                      return 'Pallet Id is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _confirmForm(),
                  child: const Text('Confirm'),
                ),
                ElevatedButton(
                  onPressed: () => _resetForm(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
