// ignore_for_file: unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
  const EmptyPalletStoreOutProcessScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        title: const Text('Empty Pallet Store Out Process'),
      ),
      // body: Padding(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number of Empty Pallet Stacks',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (numberOfPalletStacks != null) {
                  generatePalletDetails();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Please enter the pallet stacks number.'),
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
              },
              child: const Text('Accept'),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: selectAll,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      for (var detail in palletDetails) {
                        detail.selected = value;
                      }
                    });
                  },
                ),
                const Text('Select All'),
              ],
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  const DataColumn(label: Text('Select')),
                  const DataColumn(label: Text('Pallet ID')),
                  const DataColumn(label: Text('No of Pallets')),
                  const DataColumn(label: Text('Aisle')),
                  const DataColumn(label: Text('X')),
                  const DataColumn(label: Text('Y')),
                  const DataColumn(label: Text('Direction')),
                  const DataColumn(label: Text('Deep')),
                ],
                rows: palletDetails.map((detail) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Checkbox(
                          value: detail.selected,
                          onChanged: (value) {
                            setState(() {
                              detail.selected = value!;
                              if (!value) {
                                selectAll = false;
                              } else {
                                selectAll = palletDetails
                                    .every((detail) => detail.selected);
                              }
                            });
                          },
                        ),
                      ),
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
            const SizedBox(height: 16.0),
            const Divider(),
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
                            //     color: Color.fromARGB(255, 248, 243,
                            //         242)), //border width and color
                            //elevation: 3, //elevation of button
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
                          //code to execute when this button is pressed.
                        },
                        child: const Text("confirm"))),
                const Divider(),
                SizedBox(
                    height: 50, //height of button
                    width: 130, //width of button
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(
                                255, 232, 24, 9), //background color of button
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
                              // fontWeight: FontWeight
                              //     .bold
                            ) //content padding inside button
                            ),
                        onPressed: () {
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
