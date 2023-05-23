import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MaterialwindowPage extends StatefulWidget {
  @override
  _MaterialwindowPageState createState() => _MaterialwindowPageState();
}

class _MaterialwindowPageState extends State<MaterialwindowPage> {
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   _employees = getEmployeeData();
  //   _employeeDataSource = EmployeeDataSource(_employees);
  //   _dataGridController = DataGridController();

  // }
  //Color tableColor = Colors.lightBlue.shade50; // Define the desired color for the table
  //Color outlineColor = Colors.blue.shade50; // Define the desired color for the outline
  Color tableColor = Colors.grey.shade50;
  Color outlineColor = Colors.grey.shade300;

  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  final TextEditingController _field3Controller = TextEditingController();
  final TextEditingController _field4Controller = TextEditingController();

  // List<Map<String, dynamic>> items = [
  //   {'picklist': 'pick1', 'quantity': ''},
  //   {'picklist': 'pick2', 'quantity': ''},
  //   {'picklist': 'pick3', 'quantity': ''},
  // ];

  void _resetForm() {
    // setState(() {
    //   // Reset the quantity for each item in the items list to 0
    //   for (var item in items) {
    //     item['quantity'] = "";
    //   }
    _field1Controller.clear();
    _field2Controller.clear();
    _field3Controller.clear();
    _field4Controller.clear();
    //});
  }

  void _confirmForm() {
    if (_formKey.currentState!.validate()) {
      String field1Value = _field1Controller.text;
      String field2Value = _field2Controller.text;
      String field3Value = _field3Controller.text;
      String field4Value = _field4Controller.text;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pallet Id: $field1Value'),
                Text('Part Number: $field2Value'),
                Text('Part Description: $field3Value'),
                Text('Pallet Quality: $field4Value'),
              ],
            ),
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
        _field1Controller.text = barcodeScanResult;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Picking Window'),
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
                  controller: _field1Controller,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Pallet Id',
                    //fillColor: Colors.yellow[100],
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
                 SizedBox(height: 15),
                const Text(
                  'Part Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _field2Controller,

                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Part Number',
                    //fillColor: Colors.yellow[100],
                  ),
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
                  controller: _field3Controller,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Part Description',
                   // fillColor: Colors.yellow[100],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Pallet Quality',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increase the font size
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _field4Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // filled: true,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Pallet Quality',
                    //fillColor: Colors.yellow[100],
                  ),
                ),
                const SizedBox(height: 10),
                DataTable(
                  border: TableBorder.all(width: 1, style: BorderStyle.solid),
                 //  border: const TableBorder(
                 //      top: BorderSide(width: 1),
                 //      right: BorderSide(width:1),
                 //      bottom: BorderSide(width: 1),
                 //      left: BorderSide(width: 1),
                 //      verticalInside: BorderSide(width: 1)
                 //  ),
                  dataRowColor: MaterialStateColor.resolveWith((states) => tableColor),
                  headingRowColor: MaterialStateColor.resolveWith((states) => outlineColor),
                  columnSpacing: 10,
                  columns: const [
                    // DataColumn(
                    //   label: Text(
                    //     'No',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    DataColumn(

                      label: Text(
                        'Pick List',textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,

                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Picked Quantity',textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(cells: [
                     // DataCell(Text('1')),
                      DataCell(Text('Pick1',textAlign: TextAlign.center)),
                      DataCell(Text('10',textAlign: TextAlign.center)),
                    ]),
                    DataRow(cells: [
                     // DataCell(Text('2')),
                      DataCell(Text('Pick2',textAlign: TextAlign.center)),
                      DataCell(Text('5',textAlign: TextAlign.center)),
                    ]),
                    DataRow(cells: [
                      // DataCell(Text('2')),
                      DataCell(Text('Pick3',textAlign: TextAlign.center)),
                      DataCell(Text('55',textAlign: TextAlign.center)),
                    ]),
                  ],
                ),
                // Center(
                //   child: SingleChildScrollView(
                //     child: SfDataGrid(
                //       source: _employeeDataSource,
                //       allowEditing: true,
                //       selectionMode: SelectionMode.single,
                //       navigationMode: GridNavigationMode.cell,
                //       columnWidthMode: ColumnWidthMode.fill,
                //       controller: _dataGridController,
                //       columns: [
                //         GridColumn(
                //           columnName: 'Pick List',
                //           label: Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 8),
                //             alignment: Alignment.center,
                //             child: const Text(
                //               'Pick List',
                //               overflow: TextOverflow.ellipsis,
                //               // style: TextStyle(
                //               //   fontSize: 15, // Increase the font size as desired
                //               // ),
                //
                //             ),
                //           ),
                //         ),
                //         GridColumn(
                //
                //           columnName: 'Picked Quantity',
                //
                //           label: Container(
                //               //backgroundColor: Colors.indigoAccent,
                //             padding: const EdgeInsets.symmetric(horizontal: 8),
                //             alignment: Alignment.center,
                //             child: const Text(
                //               'Picked Quantity',
                //               overflow: TextOverflow.ellipsis,
                //
                //               // style: TextStyle(
                //               //   fontSize: 15, // Increase the font size as desired
                //               // ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

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
         ] ),
        ),
      ),
    ));
  }
}

// late EmployeeDataSource _employeeDataSource;
// List<Employee> _employees = <Employee>[];
// late DataGridController _dataGridController;
//
// List<Employee> getEmployeeData() {
//   return [
//     Employee('Pick1', 55),
//     Employee('Pick2', 54),
//     Employee('Pick3', 3),
//   ];
// }
//
// class EmployeeDataSource extends DataGridSource {
//   EmployeeDataSource(this._employees) {
//     dataGridRows = _employees
//         .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
//         .toList();
//   }
//
//   // ignore: prefer_final_fields
//   List<Employee> _employees = [];
//
//   List<DataGridRow> dataGridRows = [];
//
//   /// Helps to hold the new value of all editable widget.
//   /// Based on the new value we will commit the new value into the corresponding
//   /// [DataGridCell] on [onSubmitCell] method.
//   dynamic newCellValue;
//
//   /// Help to control the editable text in [TextField] widget.
//   TextEditingController editingController = TextEditingController();
//
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//           return Container(
//               alignment: (dataGridCell.columnName == 'Pick List' ||
//                   dataGridCell.columnName == 'Picked Quantity')
//                   ? Alignment.center
//                   : Alignment.center,
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 dataGridCell.value.toString(),
//                 overflow: TextOverflow.ellipsis,
//                 // style: TextStyle(
//                 //   fontSize: 30, // Increase the font size as desired
//                 // ),
//               ),
//           );
//         }).toList());
//   }
//
//   @override
//   Future<void> onCellSubmit(DataGridRow dataGridRow,
//       RowColumnIndex rowColumnIndex, GridColumn column) async {
//     final dynamic oldValue = dataGridRow
//         .getCells()
//         .firstWhere((DataGridCell dataGridCell) =>
//     dataGridCell.columnName == column.columnName)
//         .value ??
//         '';
//
//     final int dataRowIndex = dataGridRows.indexOf(dataGridRow);
//
//     if (newCellValue == null || oldValue == newCellValue) {
//       return;
//     }
//
//     if (column.columnName == 'Pick List') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'Pick List', value: newCellValue);
//       _employees[dataRowIndex].picklist = newCellValue.toString();
//     } else if (column.columnName == 'Picked Quantity') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<int>(columnName: 'Picked Quantity', value: newCellValue);
//       _employees[dataRowIndex].qty = newCellValue as int;
//     }
//   }
//
//   @override
//   Future<bool> canSubmitCell(DataGridRow dataGridRow,
//       RowColumnIndex rowColumnIndex, GridColumn column) async {
//     return true;
//   }
//
//   @override
//   Widget? buildEditWidget(DataGridRow dataGridRow,
//       RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
//     // Text going to display on editable widget
//     final String displayText = dataGridRow
//         .getCells()
//         .firstWhere((DataGridCell dataGridCell) =>
//     dataGridCell.columnName == column.columnName)
//         .value
//         ?.toString() ??
//         '';
//
//     // The new cell value must be reset.
//     // To avoid committing the [DataGridCell] value that was previously edited
//     // into the current non-modified [DataGridCell].
//     newCellValue = null;
//
//     final bool isNumericType = column.columnName ==
//         'Picked Quantity'; //|| column.columnName == 'salary';
//
//     // Holds regular expression pattern based on the column type.
//     final RegExp regExp = _getRegExp(isNumericType, column.columnName);
//
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
//       child: TextField(
//         autofocus: true,
//         controller: editingController..text = displayText,
//         textAlign: isNumericType ? TextAlign.right : TextAlign.left,
//         autocorrect: false,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
//         ),
//         inputFormatters: <TextInputFormatter>[
//           FilteringTextInputFormatter.allow(regExp)
//         ],
//         keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
//         onChanged: (String value) {
//           if (value.isNotEmpty) {
//             if (isNumericType) {
//               newCellValue = int.parse(value);
//             } else {
//               newCellValue = value;
//             }
//           } else {
//             newCellValue = null;
//           }
//         },
//         onSubmitted: (String value) {
//           /// Call [CellSubmit] callback to fire the canSubmitCell and
//           /// onCellSubmit to commit the new value in single place.
//           submitCell();
//         },
//       ),
//     );
//   }
//
//   RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
//     return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
//   }
// }
//
// class Employee {
//   //Employee(this.id, this.name, this.designation, this.salary);
//   Employee(this.picklist, this.qty);
//
//   String picklist;
//   int qty;
//
//   DataGridRow getDataGridRow() {
//     return DataGridRow(cells: <DataGridCell>[
//       DataGridCell<String>(columnName: 'Pick List', value: picklist),
//       DataGridCell<int>(columnName: 'Picked Quantity', value: qty),
//     ]);
//   }
// }