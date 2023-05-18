import 'package:flutter/material.dart';

class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
  @override
  _EmptyPalletStoreOutProcessScreenState createState() =>
      _EmptyPalletStoreOutProcessScreenState();
}

class _EmptyPalletStoreOutProcessScreenState
    extends State<EmptyPalletStoreOutProcessScreen> {
  bool selectAll = false;
  late int numberOfPalletStacks;
  List<PalletDetails> palletDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Pallet Store Out Process'),
      ),
      // body: Padding(
    body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Number of Empty Pallet Stacks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              onChanged: (value) {
                setState(() {
                  numberOfPalletStacks = int.tryParse(value)!;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Number of Empty Pallet Stacks',
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (numberOfPalletStacks != null) {
                  generatePalletDetails();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter the pallet stacks number.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Accept'),
            ),
            // SizedBox(height: 16.0),
            // Row(
            //   children: [
            //     Checkbox(
            //       value: selectAll,
            //       onChanged: (value) {
            //         setState(() {
            //           selectAll = value!;
            //           palletDetails.forEach((detail) {
            //             detail.selected = value;
            //           });
            //         });
            //       },
            //     ),
            //     Text('Select All'),
            //   ],
            // ),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  // DataColumn(label: Text('Select')),
                  DataColumn(label: Text('Pallet ID')),
                  DataColumn(label: Text('No of Pallets')),
                  DataColumn(label: Text('Aisle')),
                  DataColumn(label: Text('X')),
                  DataColumn(label: Text('Y')),
                  DataColumn(label: Text('Direction')),
                  DataColumn(label: Text('Deep')),
                ],
                rows: palletDetails.map((detail) {
                  return DataRow(
                    cells: [
                      // DataCell(
                      //   Checkbox(
                      //     value: detail.selected,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         detail.selected = value!;
                      //         if (!value) {
                      //           selectAll = false;
                      //         } else {
                      //           selectAll = palletDetails.every(
                      //                   (detail) => detail.selected);
                      //         }
                      //       });
                      //     },
                      //   ),
                      // ),
                      DataCell(Text(detail.palletId)),
                      DataCell(Text(detail.noOfPallets)),
                      DataCell(Text(detail.aisle)),
                      DataCell(Text(detail.x)),
                      DataCell(Text(detail.y)),
                      DataCell(Text(detail.direction)),
                      DataCell(Text(detail.deep)),
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change the color to accent green
                    ),
                    // Perform confirm action

                  child: Text('Confirm'),
                ),
                ElevatedButton(
                  onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent, // Change the color to accent red
                    ),
                    // Perform reset action

                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void generatePalletDetails() {
    palletDetails.clear();
    // Generate pallet details based on the number of pallet stacks
    // You can replace this with your own logic to fetch data from an API or database

    setState(() {
      for (int i = 1; i <= numberOfPalletStacks; i++) {
        palletDetails.add(
          PalletDetails(
            palletId: 'Pallet $i',
            noOfPallets: '10',
            aisle: 'Aisle $i',
            x: 'X $i',
            y: 'Y $i',
            direction: 'Direction $i',
            deep: 'Deep $i',
            selected: true, // Set the selected property to true
          ),
        );
      }
    });
  }
}

class PalletDetails {
  String palletId;
  String noOfPallets;
  String aisle;
  String x;
  String y;
  String direction;
  String deep;
  bool selected;

  PalletDetails({
    required this.palletId,
    required this.noOfPallets,
    required this.aisle,
    required this.x,
    required this.y,
    required this.direction,
    required this.deep,
    this.selected = false,
  });
}
