import 'package:flutter/material.dart';

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

  void _confirmForm() {
    if (_formKey.currentState!.validate()) {
      String _GRNumberControllerValue = _GRNumberController.text;
      String _PartNumberControllerValue = _PartNumberController.text;
      String _PartDescriptionControllerValue = _PartDescriptionController.text;
      String _Scan_EnterQuantityControllerValue =
          _Scan_EnterQuantityController.text;
      String _NotUsableControllerValue = _NotUsableController.text;
      String _EnterShelfLifeControllerValue = _EnterShelfLifeController.text;
      String _Scan_EnterPalletIdControllerValue =
          _Scan_EnterPalletIdController.text;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GR Number : $_GRNumberControllerValue'),
                Text('Part Number : $_PartNumberControllerValue'),
                Text('Part Description : $_PartDescriptionControllerValue'),
                Text(
                    'Scan/Enter Quantity : $_Scan_EnterQuantityControllerValue'),
                Text('Not Usable : $_NotUsableControllerValue'),
                Text('Enter Shelf Life : $_EnterShelfLifeControllerValue'),
                Text(
                    'Scan/Enter Pallet Id : $_Scan_EnterPalletIdControllerValue'),
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _GRNumberController,
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
                const SizedBox(height: 15),
                CheckboxListTile(
                    activeColor: Colors.indigoAccent,
                    title: const Text(
                      'Not Usable',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: value,
                    onChanged: ((value) =>
                        setState(() => this.value = value!))),

                const SizedBox(height: 15),
                const Text(
                  'Enter Shelf Life',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                TextFormField(
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _confirmForm,
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .green, // Change the color to accent green
                      ),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _resetForm,
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .redAccent, // Change the color to accent red
                      ),
                      child: const Text('Reset'),
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