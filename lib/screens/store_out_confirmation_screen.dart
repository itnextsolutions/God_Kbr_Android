import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StoreoutconfirmationPage extends StatefulWidget {
  const StoreoutconfirmationPage({Key? key}) : super(key: key);

  @override
  _StoreoutconfirmationPageState createState() =>
      _StoreoutconfirmationPageState();
}

class _StoreoutconfirmationPageState extends State<StoreoutconfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  Color tableColor = Colors.lightBlueAccent; // Define the desired color for the table
  Color outlineColor = Colors.blueAccent; // Define the desired color for the outline

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  final TextEditingController _field3Controller = TextEditingController();
  final TextEditingController _scanDipRollIdController = TextEditingController();

  // void _resetForm() {
  //   _field1Controller.clear();
  //   _field2Controller.clear();
  //   _field3Controller.clear();
  //   _scanDipRollIdController.clear();
  // }
  //
  // void _confirmForm() {
  //   if (_formKey.currentState!.validate()) {
  //     String field1Value = _field1Controller.text;
  //     String field2Value = _field2Controller.text;
  //     String field3Value = _field2Controller.text;
  //     String scanDipRollIdValue = _scanDipRollIdController.text;
  //
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Confirmation'),
  //           content: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Pallet Id: $field1Value'),
  //               Text('Document Number: $field2Value'),
  //               Text('Dip Roll Id: $field3Value'),
  //               Text('Scanned Dip Roll Id: $scanDipRollIdValue'),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> _scanBarcode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true, // Use true to enable flash
      ScanMode.DEFAULT, // Specify the scan mode
    );
    if (barcodeScanResult != '-1') {
      setState(() {
        _field1Controller.text = barcodeScanResult;
        _scanDipRollIdController.text = barcodeScanResult;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Out Confirmation'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(),

                const Text(
                  'Scan/Enter Pallet Id',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 1),
            Row(
              children: [
              Expanded(
              flex: 3,
              child: TextFormField(
                  controller: _field1Controller,
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Scan/Enter Pallet Id',
                      fillColor: Colors.white),
                ),
            ),
                const SizedBox(width: 16.0),
                IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: _scanBarcode,
                ),
              ],
            ),
                const SizedBox(height: 10),
                const Text(
                  'Document Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 1),
                TextFormField(
                  controller: _field2Controller,
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter Document Number',
                      fillColor: Colors.white),
                ),
                // const SizedBox(height: 10),
                // const Text(
                //   'Scan Dip Roll Id',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 10),
                // TextFormField(
                //   controller: _field3Controller,
                //   decoration: const InputDecoration(
                //     filled: true,
                //     border: OutlineInputBorder(),
                //     hintText: 'Enter Dip Roll Id',
                //     fillColor: Colors.white,
                //   ),
                // ),
                const Divider(),

                const SizedBox(height: 10),
                DataTable(
                  dataRowColor: MaterialStateColor.resolveWith((states) => tableColor),
                  headingRowColor: MaterialStateColor.resolveWith((states) => outlineColor),
                  columnSpacing: 10,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Dip Roll Id',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('DR001')),
                      DataCell(Text('10')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('DR002')),
                      DataCell(Text('5')),
                    ]),
                  ],
                ),
                Divider(),
                const SizedBox(height: 10),
                const Text(
                  'Scan/Enter Dip Roll Id',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 1),
            Row(
              children: [
              Expanded(
              flex: 3,
              child: TextFormField(
                  controller: _scanDipRollIdController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter Dip Roll Id',
                    fillColor: Colors.white,
                  ),
                ),
              ),
                const SizedBox(width: 16.0),
                IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: _scanBarcode,
                ),
              ],
            ),
                // const SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: _confirmForm,
                //   child: const Text('Confirm'),
                // ),
                // ElevatedButton(
                //   onPressed: _resetForm,
                //   child: const Text('Reset'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

































// MAIN

//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// class StoreoutconfirmationPage extends StatefulWidget {
//   const StoreoutconfirmationPage({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _StoreoutconfirmationPageState createState() =>
//       _StoreoutconfirmationPageState();
// }
//
// class _StoreoutconfirmationPageState extends State<StoreoutconfirmationPage> {
//   final _formKey = GlobalKey<FormState>();
//   //late String no;
//
//   // this.dataGridView.Material= null;
//   // this.dataGridView.Rows.Clear();
//   // this.dataGridView.DataSource = this.GetNewValues();
//
//   @override
//   void initState() {
//     super.initState();
//     // _Materials = getMaterialData();
//     // _MaterialDataSource = MaterialDataSource(_Materials);
//     // _dataGridController = DataGridController();
//   }
//
//   final TextEditingController _field1Controller = TextEditingController();
//   final TextEditingController _field2Controller = TextEditingController();
//   final TextEditingController _field3Controller = TextEditingController();
//
//   // ignore: non_constant_identifier_names
//   // List<Material> _Materials = getMaterialData();
//   // final DataGridController _dataGridController = DataGridController();
//
//   void _resetForm() {
//     _field1Controller.clear();
//     _field2Controller.clear();
//     _field3Controller.clear();
//   }
//
//   void _confirmForm() {
//     if (_formKey.currentState!.validate()) {
//       String field1Value = _field1Controller.text;
//       String field2Value = _field2Controller.text;
//       String field3Value = _field2Controller.text;
//
//       // _dataGridController.selectedRows = [
//       //   _materialDataSource.dataGridRows[0],
//       //   _materialDataSource.dataGridRows[1],
//       //   _materialDataSource.dataGridRows[2],
//       // ];
//
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Confirmation'),
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Pallet Id: $field1Value'),
//                 Text('Document Number: $field2Value'),
//                 // Text('No: $_dataGridController'),
//                 // Text('Dip Roll Id: $_dataGridController'),
//                 // Text('Quantity: $_dataGridController'),
//                 Text('Dip Roll Id: $field3Value'),
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Store Out Confirmation'),
//         centerTitle: true,
//         backgroundColor: Colors.indigoAccent,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: 400,
//           padding: const EdgeInsets.all(10),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Divider(),
//
//                 const Text(
//                   'Scan/Enter Pallet Id',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 1),
//                 TextFormField(
//                   controller: _field1Controller,
//                   decoration: const InputDecoration(
//                       filled: true,
//                       border: OutlineInputBorder(),
//                       hintText: 'Scan/Enter Pallet Id',
//                       fillColor: Colors.white),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Document Number',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 1),
//                 TextFormField(
//                   controller: _field2Controller,
//                   decoration: const InputDecoration(
//                       filled: true,
//                       border: OutlineInputBorder(),
//                       hintText: 'Enter Document Number',
//                       fillColor: Colors.white),
//                 ),
//                 const SizedBox(height: 10),
//                 const Divider(),
//                 // Center(
//                 //   child: SingleChildScrollView(
//                 //     child: SfDataGrid(
//                 //       source: _MaterialDataSource,
//                 //       allowEditing: true,
//                 //
//                 //       //selectionMode: SelectionMode.single,
//                 //       selectionMode: SelectionMode.multiple,
//                 //       // selectionMode: SelectionMode.none,
//                 //       navigationMode: GridNavigationMode.cell,
//                 //       columnWidthMode: ColumnWidthMode.fill,
//                 //       // controller: _dataGridController,
//                 //
//                 //       columns: [
//                 //         GridColumn(
//                 //           columnName: 'No',
//                 //           label: Container(
//                 //             padding: const EdgeInsets.symmetric(horizontal: 8),
//                 //             alignment: Alignment.center,
//                 //             child: const Text(
//                 //               'No',
//                 //               overflow: TextOverflow.ellipsis,
//                 //             ),
//                 //           ),
//                 //         ),
//                 //         GridColumn(
//                 //           columnName: 'Dip Roll Id',
//                 //           label: Container(
//                 //             padding: const EdgeInsets.symmetric(horizontal: 8),
//                 //             alignment: Alignment.center,
//                 //             child: const Text(
//                 //               'Dip Roll Id',
//                 //               overflow: TextOverflow.ellipsis,
//                 //             ),
//                 //           ),
//                 //         ),
//                 //         GridColumn(
//                 //             columnName: 'Quantity',
//                 //             label: Container(
//                 //               padding:
//                 //               const EdgeInsets.symmetric(horizontal: 8),
//                 //               alignment: Alignment.center,
//                 //               child: const Text(
//                 //                 'Quantity',
//                 //                 overflow: TextOverflow.ellipsis,
//                 //               ),
//                 //             ))
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 const Divider(),
//
//                 const Text(
//                   'Scan Dip Roll Id',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _field3Controller,
//                   decoration: const InputDecoration(
//                     filled: true,
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter Dip Roll Id',
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 const Divider(),
//                 // const SizedBox(),
//                 // ElevatedButton(
//                 //   onPressed: _confirmForm,
//                 //   child: const Text('Confirm'),
//                 // ),
//                 // ElevatedButton(
//                 //   onPressed: _resetForm,
//                 //   child: const Text('Reset'),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //
// // // ignore: non_constant_identifier_names
// // late MaterialDataSource _MaterialDataSource;
// // // ignore: non_constant_identifier_names
// // List<Material> _Materials = <Material>[];
// // // ignore: unused_element
// // late DataGridController _dataGridController;
// //
// // List<Material> getMaterialData() {
// //   return [
// //     Material(1, 2, 33),
// //     Material(2, 3, 44),
// //     Material(3, 4, 9),
// //     Material(4, 5, 29),
// //     Material(5, 6, 39),
// //   ];
// //  }
// //
// // class MaterialDataSource extends DataGridSource {
// //   MaterialDataSource(this._Materials) {
// //     dataGridRows = _Materials.map<DataGridRow>(
// //             (dataGridRow) => dataGridRow.getDataGridRow()).toList();
// //   }
// //
// //   // ignore: prefer_final_fields, non_constant_identifier_names
// //   List<Material> _Materials = [];
// //
// //   List<DataGridRow> dataGridRows = [];
// //
// //   /// Helps to hold the new value of all editable widget.
// //   /// Based on the new value we will commit the new value into the corresponding
// //   /// [DataGridCell] on [onSubmitCell] method.
// //   dynamic newCellValue;
// //
// //   /// Help to control the editable text in [TextField] widget.
// //   TextEditingController editingController = TextEditingController();
// //
// //   @override
// //   List<DataGridRow> get rows => dataGridRows;
// //
// //   @override
// //   DataGridRowAdapter? buildRow(DataGridRow row) {
// //     return DataGridRowAdapter(
// //         cells: row.getCells().map<Widget>((dataGridCell) {
// //           return Container(
// //               alignment: (dataGridCell.columnName == 'No' ||
// //                   dataGridCell.columnName == 'Dip Roll Id' ||
// //                   dataGridCell.columnName == 'Quantity')
// //                   ? Alignment.center
// //                   : Alignment.center,
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //               child: Text(
// //                 dataGridCell.value.toString(),
// //                 overflow: TextOverflow.ellipsis,
// //               ));
// //         }).toList());
// //   }
// //
// //   @override
// //   Future<void> onCellSubmit(DataGridRow dataGridRow,
// //       RowColumnIndex rowColumnIndex, GridColumn column) async {
// //     final dynamic oldValue = dataGridRow
// //         .getCells()
// //         .firstWhere((DataGridCell dataGridCell) =>
// //     dataGridCell.columnName == column.columnName)
// //         .value ??
// //         '';
// //
// //     final int dataRowIndex = dataGridRows.indexOf(dataGridRow);
// //
// //     if (newCellValue == null || oldValue == newCellValue) {
// //       return;
// //     }
// //
// //     if (column.columnName == 'No') {
// //       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
// //           DataGridCell<int>(columnName: 'No', value: newCellValue);
// //       _Materials[dataRowIndex].no = newCellValue();
// //     } else if (column.columnName == 'Dip Roll Id') {
// //       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
// //           DataGridCell<int>(columnName: 'Dip Roll Id', value: newCellValue);
// //       _Materials[dataRowIndex].id = newCellValue as int;
// //     } else if (column.columnName == 'Quantity') {
// //       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
// //           DataGridCell<int>(columnName: 'Quantity', value: newCellValue);
// //       _Materials[dataRowIndex].qty = newCellValue as int;
// //     }
// //   }
// //
// //   @override
// //   Future<bool> canSubmitCell(DataGridRow dataGridRow,
// //       RowColumnIndex rowColumnIndex, GridColumn column) async {
// //     return true;
// //   }
// //
// //   @override
// //   Widget? buildEditWidget(DataGridRow dataGridRow,
// //       RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
// //     // Text going to display on editable widget
// //     final String displayText = dataGridRow
// //         .getCells()
// //         .firstWhere((DataGridCell dataGridCell) =>
// //     dataGridCell.columnName == column.columnName)
// //         .value
// //         ?.toString() ??
// //         '';
// //
// //     // The new cell value must be reset.
// //     // To avoid committing the [DataGridCell] value that was previously edited
// //     // into the current non-modified [DataGridCell].
// //     newCellValue = null;
// //
// //     final bool isNumericType =
// //         column.columnName == 'Dip Roll Id' || column.columnName == 'Quantity';
// //
// //     // Holds regular expression pattern based on the column type.
// //     final RegExp regExp = _getRegExp(isNumericType, column.columnName);
// //
// //     return Container(
// //       padding: const EdgeInsets.all(8.0),
// //       alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
// //       child: TextField(
// //         autofocus: true,
// //         controller: editingController..text = displayText,
// //         textAlign: isNumericType ? TextAlign.right : TextAlign.left,
// //         autocorrect: false,
// //         decoration: const InputDecoration(
// //           contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
// //         ),
// //         inputFormatters: <TextInputFormatter>[
// //           FilteringTextInputFormatter.allow(regExp)
// //         ],
// //         keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
// //         onChanged: (String value) {
// //           if (value.isNotEmpty) {
// //             if (isNumericType) {
// //               newCellValue = int.parse(value);
// //             } else {
// //               newCellValue = value;
// //             }
// //           } else {
// //             newCellValue = null;
// //           }
// //         },
// //         onSubmitted: (String value) {
// //           /// Call [CellSubmit] callback to fire the canSubmitCell and
// //           /// onCellSubmit to commit the new value in single place.
// //           submitCell();
// //         },
// //       ),
// //     );
// //   }
// //
// //   RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
// //     return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
// //   }
// // }
// //
// // class Material {
// //   //Material(this.id, this.name, this.designation, this.salary);
// //   Material(this.no, this.id, this.qty);
// //
// //   int no;
// //   int id;
// //   int qty;
// //
// //   DataGridRow getDataGridRow() {
// //     return DataGridRow(cells: <DataGridCell>[
// //       DataGridCell<int>(columnName: 'No', value: no),
// //       DataGridCell<int>(columnName: 'Dip Roll Id', value: id),
// //       DataGridCell<int>(columnName: 'Quantity', value: qty),
// //     ]);
// //   }
// // }










// import 'package:flutter/material.dart';
//
// class StoreOutConfirmationPage extends StatefulWidget {
//   @override
//   _StoreOutConfirmationPageState createState() =>
//       _StoreOutConfirmationPageState();
// }
//
// class _StoreOutConfirmationPageState extends State<StoreOutConfirmationPage> {
//   List<Map<String, dynamic>> gridData = []; // List to store grid data
//   String scannedPalletId = '';
//   String scannedDocumentNo = '';
//   String scannedDipRollId = '';
//
//   void _addRowToGrid() {
//     // Function to add a row to the grid data
//     setState(() {
//       int rowCount = gridData.length;
//       Map<String, dynamic> newRow = {
//         'NO': rowCount + 1,
//         'Dip Roll ID': scannedDipRollId,
//         'Quantity': 1, // Replace with actual quantity
//       };
//       gridData.add(newRow);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Store Out Confirmation'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   scannedPalletId = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Scan Pallet ID',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   scannedDocumentNo = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Document No',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1.0,
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: DataTable(
//                     columns: [
//                       DataColumn(label: Text('NO')),
//                       DataColumn(label: Text('Dip Roll ID')),
//                       DataColumn(label: Text('Quantity')),
//                     ],
//                     rows: List.generate(
//                       gridData.length,
//                           (index) => DataRow(
//                         cells: [
//                           DataCell(Text('${gridData[index]['NO']}')),
//                           DataCell(Text('${gridData[index]['Dip Roll ID']}')),
//                           DataCell(Text('${gridData[index]['Quantity']}')),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   scannedDipRollId = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Scan Dip Roll ID',
//               ),
//             ),
//           ],
//         ),
//       ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Call the function to add a row to the grid data
      //     _addRowToGrid();
      //   },
      //   child: Icon(Icons.add),
      // ),
//     );
//   }
// }













// import 'package:flutter/material.dart';
//
// class StoreOutConfirmationPage extends StatefulWidget {
//   @override
//   _StoreOutConfirmationPageState createState() =>
//       _StoreOutConfirmationPageState();
// }
//
// class _StoreOutConfirmationPageState extends State<StoreOutConfirmationPage> {
//   List<Map<String, dynamic>> gridData = []; // List to store grid data
//   String scannedPalletId = '';
//   String scannedDocumentNo = '';
//   String scannedDipRollId = '';
//
//   void _addRowToGrid() {
//     // Function to add a row to the grid data
//     setState(() {
//       int rowCount = gridData.length;
//       Map<String, dynamic> newRow = {
//         'NO': rowCount + 1,
//         'Dip Roll ID': scannedDipRollId,
//         'Quantity': 1, // Replace with actual quantity
//       };
//       gridData.add(newRow);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Store Out Confirmation'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   scannedPalletId = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Scan Pallet ID',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   scannedDocumentNo = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Document No',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: DataTable(
//                   columns: [
//                     DataColumn(label: Text('NO')),
//                     DataColumn(label: Text('Dip Roll ID')),
//                     DataColumn(label: Text('Quantity')),
//                   ],
//                   rows: List.generate(
//                     gridData.length,
//                         (index) => DataRow(
//                       cells: [
//                         DataCell(Text('${gridData[index]['NO']}')),
//                         DataCell(Text('${gridData[index]['Dip Roll ID']}')),
//                         DataCell(Text('${gridData[index]['Quantity']}')),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   scannedDipRollId = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Scan Dip Roll ID',
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Call the function to add a row to the grid data
//           _addRowToGrid();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
//
// class StoreOutConfirmationPage extends StatefulWidget {
//   @override
//   _StoreOutConfirmationPageState createState() => _StoreOutConfirmationPageState();
// }
//
// class _StoreOutConfirmationPageState extends State<StoreOutConfirmationPage> {
//   String documentNo = '';
//   List<Map<String, dynamic>> dipRollsList = [];
//
//   void postScannedDipRoll(String dipRollId) async {
//     // Simulate API call delay
//     await Future.delayed(Duration(seconds: 2));
//
//     // Dummy API response data
//     Map<String, dynamic> dummyResponse = {
//       'status': 'success',
//       'message': 'Scanned dip roll stored out successfully',
//     };
//
//     // Remove scanned dip roll from dipRollsList
//     setState(() {
//       dipRollsList.removeWhere((dipRoll) => dipRoll['dipRollID'] == dipRollId);
//     });
//
//     // Call your API here to post scanned dip roll stored out acknowledgement
//     // ... Add your API call here ...
//
//     // You can handle the API response and update the UI accordingly
//     // For example, you can show a toast/snackbar with the response message
//     // or update a status variable to indicate the success/failure of the API call
//   }
//
//   void getDipRolls() {
//     // Call API to get dip rolls list based on pallet ID
//     // ... Add your API call here ...
//     // Once you get the response, populate the dipRollsList with dip rolls data
//     // Assuming the API response is a List of Map with keys 'no', 'dipRollID', and 'quantity'
//
//     Future<void> getDipRollsList(String palletId) async {
//       // Simulate API call delay
//       await Future.delayed(Duration(seconds: 2));
//
//       // Dummy API response data
//       List<Map<String, dynamic>> dummyResponse = [
//         {'no': 1, 'dipRollID': 'DR001', 'quantity': 10},
//         {'no': 2, 'dipRollID': 'DR002', 'quantity': 5},
//         {'no': 3, 'dipRollID': 'DR003', 'quantity': 8},
//       ];
//
//       // Update dipRollsList with dummy data
//       setState(() {
//         dipRollsList = dummyResponse;
//       });
//     }
//
//     setState(() {
//       dipRollsList = [
//         {'no': 1, 'dipRollID': 'DR001', 'quantity': 10},
//         {'no': 2, 'dipRollID': 'DR002', 'quantity': 5},
//         {'no': 3, 'dipRollID': 'DR003', 'quantity': 8},
//       ];
//     });
//
//     // Populate the document number based on the API response
//     setState(() {
//       documentNo = 'DOC12345'; // Replace with actual value from API response
//     });
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   // TODO: Implement build method
//   //   throw UnimplementedError();
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Implement build method
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan Dip Roll'),
//       ),
//       body: Container(
//         // Container widget properties and child widgets
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // TODO: Implement logic for FloatingActionButton onPressed event
//           // void _onFloatingActionButtonPressed() async {
//           //   // Show a camera screen to scan dip roll
//           //   String scannedDipRollId = await Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //       builder: (context) => ScanDipRollPage(), // Replace with your actual scan dip roll page
//           //     ),
//           //   );
//           //
//           //   // Check if scannedDipRollId is not null (i.e., a dip roll was scanned)
//           //   if (scannedDipRollId != null) {
//           //     // Call the API to post scanned dip roll
//           //     postScannedDipRoll(scannedDipRollId);
//           //   }
//           // }
//
//         },
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
// }