//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
//   const EmptyPalletStoreOutProcessScreen({Key? key}) : super(key: key);
//
//   @override
//   _EmptyPalletStoreOutProcessScreenState createState() =>
//       _EmptyPalletStoreOutProcessScreenState();
// }
//
// class _EmptyPalletStoreOutProcessScreenState
//     extends State<EmptyPalletStoreOutProcessScreen> {
//   bool selectAll = false;
//   late int numberOfPalletStacks;
//   List<PalletDetails> palletDetails = [];
//   Color tableColor = Colors.lightBlueAccent; // Define the desired color for the table
//   Color outlineColor = Colors.blueAccent; // Define the desired color for the outline
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Empty Pallet Store Out Process'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             const Text(
//               'Number of Empty Pallet Stacks',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   numberOfPalletStacks = int.tryParse(value)!;
//                 });
//               },
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Number of Empty Pallet Stacks',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (numberOfPalletStacks != null) {
//                   generatePalletDetails();
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text(
//                             'Please enter the pallet stacks number.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: const Text('Accept'),
//             ),
//             const SizedBox(height: 16.0),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: DataTable(
//                 dataRowColor:
//                 MaterialStateColor.resolveWith((states) => tableColor),
//                 headingRowColor:
//                 MaterialStateColor.resolveWith((states) => outlineColor),
//                 columnSpacing: 8.0,
//                 columns: [
//                   DataColumn(
//                     label: Text('Pallet ID'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                   DataColumn(
//                     label: Text('No of Pallets'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                   DataColumn(
//                     label: Text('Aisle'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                   DataColumn(
//                     label: Text('X'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                   DataColumn(
//                     label: Text('Y'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                   DataColumn(
//                     label: Text('Direction'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                   DataColumn(
//                     label: Text('Deep'),
//                     onSort: (columnIndex, _) {
//                       // Handle sorting if needed
//                     },
//                   ),
//                 ],
//                 rows: palletDetails.map((detail) {
//                   return DataRow(
//                     cells: [
//                       DataCell(Text(detail.palletId)),
//                       DataCell(Text(detail.noOfPallets)),
//                       DataCell(Text(detail.aisle)),
//                       DataCell(Text(detail.x)),
//                       DataCell(Text(detail.y)),
//                       DataCell(Text(detail.direction)),
//                       DataCell(Text(detail.deep)),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade900,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       textStyle: const TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     onPressed: () {
//
//                       // Code to execute when this button is pressed.
//                     },
//                     child: const Text("Confirm"),
//                   ),
//                 ),
//                 const Divider(),
//                 SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 232, 24, 9),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       textStyle: const TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     onPressed: () {
//                       resetForm();
//                     },
//                     child: const Text("Reset"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Future<void> fetchDataFromApi() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://10.0.2.2:7058/api/Product/GetProductCount'),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final palletDetails = json.decode(response.body);
//         print(palletDetails);
//         setState(() {
//           // Update the state variables with the fetched data
//           // Example:
//           // numberOfPalletStacks = responseData['numberOfPalletStacks'];
//           // palletDetails = responseData['palletDetails'];
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Failed to fetch data from the API.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text(
//                 'An error occurred while fetching data from the API.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   void generatePalletDetails() {
//     palletDetails.clear();
//     setState(() {
//       for (int i = 1; i <= numberOfPalletStacks; i++) {
//         palletDetails.add(
//           PalletDetails(
//             palletId: 'Pallet $i',
//             noOfPallets: '10',
//             aisle: 'Aisle $i',
//             x: 'X $i',
//             y: 'Y $i',
//             direction: 'Direction $i',
//             deep: 'Deep $i',
//             selected: true,
//           ),
//         );
//       }
//     });
//   }
//
//   void resetForm() {
//     setState(() {
//       palletDetails.clear();
//       numberOfPalletStacks = 0;
//       selectAll = false;
//     });
//   }
// }
//
// class PalletDetails {
//   String palletId;
//   String noOfPallets;
//   String aisle;
//   String x;
//   String y;
//   String direction;
//   String deep;
//   bool selected;
//
//   PalletDetails({
//     required this.palletId,
//     required this.noOfPallets,
//     required this.aisle,
//     required this.x,
//     required this.y,
//     required this.direction,
//     required this.deep,
//     this.selected = false,
//   });
// }
//
//
//
//



















// ignore_for_file: unnecessary_null_comparison, prefer_const_literals_to_create_immutables
//
// import 'package:flutter/material.dart';
//
// class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
//   const EmptyPalletStoreOutProcessScreen({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _EmptyPalletStoreOutProcessScreenState createState() =>
//       _EmptyPalletStoreOutProcessScreenState();
// }
//
// class _EmptyPalletStoreOutProcessScreenState
//     extends State<EmptyPalletStoreOutProcessScreen> {
//   bool selectAll = false;
//   late int numberOfPalletStacks;
//   List<PalletDetails> palletDetails = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Empty Pallet Store Out Process'),
//       ),
//       // body: Padding(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             const Text(
//               'Number of Empty Pallet Stacks',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   numberOfPalletStacks = int.tryParse(value)!;
//                 });
//               },
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Number of Empty Pallet Stacks',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (numberOfPalletStacks != null) {
//                   generatePalletDetails();
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text(
//                             'Please enter the pallet stacks number.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: const Text('Accept'),
//             ),
//             // const SizedBox(height: 16.0),
//             // Row(
//             //   children: [
//             //     Checkbox(
//             //       value: selectAll,
//             //       onChanged: (value) {
//             //         setState(() {
//             //           selectAll = value!;
//             //           for (var detail in palletDetails) {
//             //             detail.selected = value;
//             //           }
//             //         });
//             //       },
//             //     ),
//             //     const Text('Select All'),
//             //   ],
//             // ),
//             const SizedBox(height: 16.0),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: DataTable(
//                 columns: [
//                   // const DataColumn(label: Text('Select')),
//                   const DataColumn(label: Text('Pallet ID')),
//                   const DataColumn(label: Text('No of Pallets')),
//                   const DataColumn(label: Text('Aisle')),
//                   const DataColumn(label: Text('X')),
//                   const DataColumn(label: Text('Y')),
//                   const DataColumn(label: Text('Direction')),
//                   const DataColumn(label: Text('Deep')),
//                 ],
//                 rows: palletDetails.map((detail) {
//                   return DataRow(
//                     cells: [
//                       // DataCell(
//                       //   Checkbox(
//                       //     value: detail.selected,
//                       //     onChanged: (value) {
//                       //       setState(() {
//                       //         detail.selected = value!;
//                       //         if (!value) {
//                       //           selectAll = false;
//                       //         } else {
//                       //           selectAll = palletDetails
//                       //               .every((detail) => detail.selected);
//                       //         }
//                       //       });
//                       //     },
//                       //   ),
//                       // ),
//                       DataCell(Text(detail.palletId)),
//                       DataCell(Text(detail.noOfPallets)),
//                       DataCell(Text(detail.aisle)),
//                       DataCell(Text(detail.x)),
//                       DataCell(Text(detail.y)),
//                       DataCell(Text(detail.direction)),
//                       DataCell(Text(detail.deep)),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                     height: 50, //height of button
//                     width: 130, //width of button
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors
//                                 .green.shade900, //background color of button
//                             // side: const BorderSide(
//                             //     width: 1,
//                             //     color: Color.fromARGB(255, 248, 243,
//                             //         242)), //border width and color
//                             //elevation: 3, //elevation of button
//                             shape: RoundedRectangleBorder(
//                                 //to set border radius to button
//                                 borderRadius: BorderRadius.circular(1)),
//                             //padding: const EdgeInsets.all(20),
//                             textStyle: const TextStyle(
//                               fontSize: 20,
//                               // fontWeight: FontWeight
//                               //     .bold
//                             ) //content padding inside button
//                             ),
//                         onPressed: () {
//                           //code to execute when this button is pressed.
//                         },
//                         child: const Text("confirm"))),
//                 const Divider(),
//                 SizedBox(
//                     height: 50, //height of button
//                     width: 130, //width of button
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Color.fromARGB(
//                                 255, 232, 24, 9), //background color of button
//                             // side: const BorderSide(
//                             //     width: 1,
//                             //     color: Colors.brown), //border width and color
//                             //elevation: 3, //elevation of button
//                             shape: RoundedRectangleBorder(
//                                 //to set border radius to button
//                                 borderRadius: BorderRadius.circular(1)),
//                             //padding: const EdgeInsets.all(20),
//                             textStyle: const TextStyle(
//                               fontSize: 20,
//                               // fontWeight: FontWeight
//                               //     .bold
//                             ) //content padding inside button
//                             ),
//                         onPressed: () {
//                           resetForm();
//                           //code to execute when this button is pressed.
//                         },
//                         child: const Text("reset")))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void generatePalletDetails() {
//     palletDetails.clear();
//     // Generate pallet details based on the number of pallet stacks
//     // You can replace this with your own logic to fetch data from an API or database
//
//     setState(() {
//       for (int i = 1; i <= numberOfPalletStacks; i++) {
//         palletDetails.add(
//           PalletDetails(
//             palletId: 'Pallet $i',
//             noOfPallets: '10',
//             aisle: 'Aisle $i',
//             x: 'X $i',
//             y: 'Y $i',
//             direction: 'Direction $i',
//             deep: 'Deep $i',
//             selected: true, // Set the selected property to true
//           ),
//         );
//       }
//     });
//   }
//
//   void resetForm() {
//     setState(() {
//       palletDetails.clear();
//       numberOfPalletStacks = 0;
//       selectAll = false;
//     });
//   }
// }
//
// class PalletDetails {
//   String palletId;
//   String noOfPallets;
//   String aisle;
//   String x;
//   String y;
//   String direction;
//   String deep;
//   bool selected;
//
//   PalletDetails({
//     required this.palletId,
//     required this.noOfPallets,
//     required this.aisle,
//     required this.x,
//     required this.y,
//     required this.direction,
//     required this.deep,
//     this.selected = false,
//   });
// }

// Main

//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
//   const EmptyPalletStoreOutProcessScreen({Key? key}) : super(key: key);
//
//   @override
//   _EmptyPalletStoreOutProcessScreenState createState() =>
//       _EmptyPalletStoreOutProcessScreenState();
// }
//
// class _EmptyPalletStoreOutProcessScreenState
//     extends State<EmptyPalletStoreOutProcessScreen> {
//   bool selectAll = false;
//   late int numberOfPalletStacks;
//   List<PalletDetails> palletDetails = [];
//   Color tableColor = Colors.lightBlueAccent; // Define the desired color for the table
//   Color outlineColor = Colors.blueAccent; // Define the desired color for the outline
//   bool showTable = false; // Track the visibility of the table
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Empty Pallet Store Out Process'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             const Text(
//               'Number of Empty Pallet Stacks',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   numberOfPalletStacks = int.tryParse(value)!;
//                 });
//               },
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Number of Empty Pallet Stacks',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (numberOfPalletStacks != null) {
//                   generatePalletDetails();
//                   setState(() {
//                     showTable = true; // Show the table
//                   });
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text(
//                             'Please enter the pallet stacks number.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: const Text('Accept'),
//             ),
//             if (showTable) ...[
//               const SizedBox(height: 16.0),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   dataRowColor:
//                   MaterialStateColor.resolveWith((states) => tableColor),
//                   headingRowColor:
//                   MaterialStateColor.resolveWith((states) => outlineColor),
//                   columnSpacing: 8.0,
//                   columns: [
//                     DataColumn(
//                       label: Text('Pallet ID'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('No of Pallets'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('Aisle'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('X'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('Y'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('Direction'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('Deep'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                   ],
//                   rows: palletDetails.map((detail) {
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(detail.palletId)),
//                         DataCell(Text(detail.noOfPallets)),
//                         DataCell(Text(detail.aisle)),
//                         DataCell(Text(detail.x)),
//                         DataCell(Text(detail.y)),
//                         DataCell(Text(detail.direction)),
//                         DataCell(Text(detail.deep)),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//             const SizedBox(height: 16.0),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade900,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       textStyle: const TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     onPressed: () {
//                       // Code to execute when this button is pressed.
//                     },
//                     child: const Text("Confirm"),
//                   ),
//                 ),
//                 const Divider(),
//                 SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 232, 24, 9),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       textStyle: const TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     onPressed: () {
//                       resetForm();
//                     },
//                     child: const Text("Reset"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> fetchDataFromApi() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://10.0.2.2:7058/api/Product/GetProductCount'),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final palletDetails = json.decode(response.body);
//         print(palletDetails);
//         setState(() {
//           // Update the state variables with the fetched data
//           // Example:
//           // numberOfPalletStacks = responseData['numberOfPalletStacks'];
//           // palletDetails = responseData['palletDetails'];
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Failed to fetch data from the API.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text(
//                 'An error occurred while fetching data from the API.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   void generatePalletDetails() {
//    // palletDetails.clear();
//     setState(() {
//       for (int i = 1; i <= numberOfPalletStacks; i++) {
//         palletDetails.add(
//           PalletDetails(
//             palletId: 'Pallet $i',
//             noOfPallets: '10',
//             aisle: 'Aisle $i',
//             x: 'X $i',
//             y: 'Y $i',
//             direction: 'Direction $i',
//             deep: 'Deep $i',
//             selected: true,
//           ),
//         );
//       }
//     });
//   }
//
//   void resetForm() {
//     setState(() {
//       palletDetails.clear();
//       numberOfPalletStacks = 0;
//       selectAll = false;
//       showTable = false; // Hide the table
//     });
//   }
// }
//
// class PalletDetails {
//   String palletId;
//   String noOfPallets;
//   String aisle;
//   String x;
//   String y;
//   String direction;
//   String deep;
//   bool selected;
//
//   PalletDetails({
//     required this.palletId,
//     required this.noOfPallets,
//     required this.aisle,
//     required this.x,
//     required this.y,
//     required this.direction,
//     required this.deep,
//     this.selected = false,
//   });
// }
//
//

// vip
//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
//   const EmptyPalletStoreOutProcessScreen({Key? key}) : super(key: key);
//
//   @override
//   _EmptyPalletStoreOutProcessScreenState createState() =>
//       _EmptyPalletStoreOutProcessScreenState();
// }
//
// class _EmptyPalletStoreOutProcessScreenState
//     extends State<EmptyPalletStoreOutProcessScreen> {
//   bool selectAll = false;
//   late int numberOfPalletStacks;
//   List<PalletDetails> palletDetails = [];
//   Color tableColor = Colors.lightBlueAccent; // Define the desired color for the table
//   Color outlineColor = Colors.blueAccent; // Define the desired color for the outline
//   bool showTable = false; // Track the visibility of the table
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Empty Pallet Store Out Process'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             const Text(
//               'Number of Empty Pallet Stacks',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   numberOfPalletStacks = int.tryParse(value)!;
//                 });
//               },
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Number of Empty Pallet Stacks',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (numberOfPalletStacks != null) {
//                   generatePalletDetails();
//                   setState(() {
//                     showTable = true; // Show the table
//                   });
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text(
//                             'Please enter the pallet stacks number.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: const Text('Accept'),
//             ),
//             if (showTable) ...[
//               const SizedBox(height: 16.0),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   dataRowColor:
//                   MaterialStateColor.resolveWith((states) => tableColor),
//                   headingRowColor:
//                   MaterialStateColor.resolveWith((states) => outlineColor),
//                   columnSpacing: 8.0,
//                   columns: [
//                     DataColumn(
//                       label: Text('HU_ID'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_VOL'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_STAT'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_HUPT'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_USAGE'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_PAPR3'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                   ],
//                   rows: palletDetails.map((detail) {
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(detail.huId)),
//                         DataCell(Text(detail.huVol)),
//                         DataCell(Text(detail.huStat)),
//                         DataCell(Text(detail.huHupt)),
//                         DataCell(Text(detail.huUsage)),
//                         DataCell(Text(detail.huPapr3)),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//             const SizedBox(height: 16.0),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade900,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       textStyle: const TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     onPressed: () {
//                       // Code to execute when this button is pressed.
//                     },
//                     child: const Text("Confirm"),
//                   ),
//                 ),
//                 const Divider(),
//                 SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 232, 24, 9),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       textStyle: const TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     onPressed: () {
//                       resetForm();
//                     },
//                     child: const Text("Reset"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Future<void> fetchDataFromApi() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await http.get(
//         Uri.parse('https://10.0.2.2:7058/api/Product/GetProductCount'),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         setState(() {
//           palletDetails = responseData.map((data) => PalletDetails(
//             huId: data['HU_ID'].toString(),
//             huVol: data['HU_VOL'].toString(),
//             huStat: data['HU_STAT'],
//             huHupt: data['HU_HUPT'].toString(),
//             huUsage: data['HU_USAGE'],
//             huPapr3: data['HU_PAPR3'].toString(),
//           )).toList();
//           isLoading = false;
//           showTable = true;
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Failed to fetch data from the API.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text(
//                 'An error occurred while fetching data from the API.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//   // void generatePalletDetails() {
//   //   // Filter the pallet details based on the number of pallet stacks
//   //   palletDetails = palletDetails
//   //       .where((detail) => int.parse(detail.huId.substring(6)) <= numberOfPalletStacks)
//   //       .toList();
//   // }
//   void generatePalletDetails() {
//     // Reset the pallet details list
//     palletDetails = [];
//
//     // Check if the number of pallet stacks is valid and greater than zero
//     if (numberOfPalletStacks != null && numberOfPalletStacks > 0) {
//       // Generate the pallet details based on the number of pallet stacks
//       for (int i = 1; i <= numberOfPalletStacks; i++) {
//         palletDetails.add(PalletDetails(
//           huId: 'HU_ID $i',
//           huVol: 'HU_VOL $i',
//           huStat: 'HU_STAT $i',
//           huHupt: 'HU_HUPT $i',
//           huUsage: 'HU_USAGE $i',
//           huPapr3: 'HU_PAPR3 $i',
//         ));
//       }
//
//       setState(() {
//         showTable = true; // Show the table with the filtered data
//       });
//     } else {
//       setState(() {
//         showTable = false; // Hide the table if the number of pallet stacks is not valid
//       });
//     }
//   }
//
//   void resetForm() {
//     setState(() {
//       showTable = false;
//       numberOfPalletStacks = 0;
//       palletDetails.clear();
//     });
//   }
// }
//
// class PalletDetails {
//   final String huId;
//   final String huVol;
//   final String huStat;
//   final String huHupt;
//   final String huUsage;
//   final String huPapr3;
//
//   PalletDetails({
//     required this.huId,
//     required this.huVol,
//     required this.huStat,
//     required this.huHupt,
//     required this.huUsage,
//     required this.huPapr3,
//   });
// }


// *in this accept button calls api*

//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
//   const EmptyPalletStoreOutProcessScreen({Key? key}) : super(key: key);
//
//   @override
//   _EmptyPalletStoreOutProcessScreenState createState() =>
//       _EmptyPalletStoreOutProcessScreenState();
// }
//
// class _EmptyPalletStoreOutProcessScreenState
//     extends State<EmptyPalletStoreOutProcessScreen> {
//   bool selectAll = false;
//   late int numberOfPalletStacks;
//   List<PalletDetails> palletDetails = [];
//   Color tableColor = Colors.lightBlueAccent; // Define the desired color for the table
//   Color outlineColor = Colors.blueAccent; // Define the desired color for the outline
//   bool showTable = false; // Track the visibility of the table
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//     showTable = false; // Hide the table initially
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Empty Pallet Store Out Process'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             const Text(
//               'Number of Empty Pallet Stacks',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 15),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   numberOfPalletStacks = int.tryParse(value)!;
//                 });
//               },
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Number of Empty Pallet Stacks',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (numberOfPalletStacks != null) {
//                   setState(() {
//                     showTable = true; // Show the table
//                   });
//                   generatePalletDetails();
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text(
//                             'Please enter the pallet stacks number.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: const Text('Accept'),
//             ),
//             if (showTable) ...[
//               const SizedBox(height: 16.0),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   dataRowColor:
//                   MaterialStateColor.resolveWith((states) => tableColor),
//                   headingRowColor:
//                   MaterialStateColor.resolveWith((states) => outlineColor),
//                   columnSpacing: 8.0,
//                   columns: [
//                     DataColumn(
//                       label: Text('HU_ID'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_VOL'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_STAT'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_HUPT'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_USAGE'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                     DataColumn(
//                       label: Text('HU_PAPR3'),
//                       onSort: (columnIndex, _) {
//                         // Handle sorting if needed
//                       },
//                     ),
//                   ],
//                   rows: palletDetails
//                       .map(
//                         (data) => DataRow(
//                       cells: [
//                         DataCell(Text(data.huId)),
//                         DataCell(Text(data.huVol)),
//                         DataCell(Text(data.huStat)),
//                         DataCell(Text(data.huHupt)),
//                         DataCell(Text(data.huUsage)),
//                         DataCell(Text(data.huPapr3)),
//                       ],
//                     ),
//                   )
//                       .toList(),
//                 ),
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                 SizedBox(
//                 height: 50,
//                 width: 100,
//               child:ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green.shade900,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   textStyle: const TextStyle(
//                     fontSize: 15,
//                   ),
//                   padding: EdgeInsets.zero, // Add this line to remove the default padding
//                 ),
//                 onPressed: () {
//                   // Implement confirm logic here
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Confirmation'),
//                         content: const Text('Are you sure you want to confirm?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               // Perform the confirmation action
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('Confirm'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('Cancel'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: const Text('Confirm'),
//               ),
//     ),
//     const Divider(),
//                   const SizedBox(width: 16.0),
//     SizedBox(
//         height: 50,
//         width: 100,
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Color.fromARGB(255, 232, 24, 9),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 15,
//         ),
//         padding: EdgeInsets.zero, // Add this line to remove the default padding
//       ),
//       onPressed: () {
//         setState(() {
//           showTable = false; // Hide the table
//           palletDetails.clear(); // Clear the pallet details
//         });
//       },
//       child: const Text('Reset'),
//     ),
//     ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> fetchDataFromApi() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await http.get(
//         Uri.parse('https://10.0.2.2:7058/api/Product/GetProductCount'),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         setState(() {
//           palletDetails = responseData
//               .map(
//                 (data) => PalletDetails(
//               huId: data['HU_ID'].toString(),
//               huVol: data['HU_VOL'].toString(),
//               huStat: data['HU_STAT'],
//               huHupt: data['HU_HUPT'].toString(),
//               huUsage: data['HU_USAGE'],
//               huPapr3: data['HU_PAPR3'].toString(),
//             ),
//           )
//               .toList();
//           filterPalletDetails();
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Failed to fetch data from the API.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text(
//                 'An error occurred while fetching data from the API.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void generatePalletDetails() {
//     // Filter the pallet details list based on the entered number of pallet stacks
//     palletDetails = palletDetails.take(numberOfPalletStacks).toList();
//   }
//
//
//   void filterPalletDetails() {
//     // Implement filtering logic here if needed
//   }
// }
//
// class PalletDetails {
//   final String huId;
//   final String huVol;
//   final dynamic huStat;
//   final String huHupt;
//   final dynamic huUsage;
//   final String huPapr3;
//
//   PalletDetails({
//     required this.huId,
//     required this.huVol,
//     required this.huStat,
//     required this.huHupt,
//     required this.huUsage,
//     required this.huPapr3,
//   });
// }




// new code that hits screen api





import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
  const EmptyPalletStoreOutProcessScreen({Key? key}) : super(key: key);

  @override
  _EmptyPalletStoreOutProcessScreenState createState() =>
      _EmptyPalletStoreOutProcessScreenState();
}

class _EmptyPalletStoreOutProcessScreenState
    extends State<EmptyPalletStoreOutProcessScreen> {
  bool selectAll = false;
  late int? numberOfPalletStacks;
  List<PalletDetails> palletDetails = [];



  Color tableColor = Colors.grey.shade50;
  Color outlineColor = Colors.grey.shade300;
  //  Color tableColor = Colors.grey.shade50;
  //   Color outlineColor = Colors.grey;Define the desired color for the outline
  bool showTable = false; // Track the visibility of the table
  bool isLoading = false;
  bool showError = false; // Add this line to initialize showError




  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    showTable = false; // Hide the table initially
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Pallet Out Process'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),

            const Text(
              'Number of Empty Pallet Stacks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, // Increase the font size
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              onChanged: (value) {
                setState(() {
                  numberOfPalletStacks = int.tryParse(value);
                  showError = false; // Reset the error state when input changes
                });
              },
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number of Empty Pallet Stacks',
                // errorText: showError ? 'Please enter the number of pallet stacks.' : null,
              ),
            ),
            SizedBox(height: 8.0),
            Visibility(
              visible: showError,
              child: Text(
                'Please enter the number of pallet stacks.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
            // const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (numberOfPalletStacks != null) {
            //       setState(() {
            //         showTable = true; // Show the table
            //         isLoading = true; // Show loading indicator
            //         palletDetails.clear(); // Clear the existing pallet details
            //       });
            //       await fetchDataFromApi();
            //       generatePalletDetails();
            //       setState(() {
            //         isLoading = false; // Hide loading indicator
            //       });
            //     } else {
            //       showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: const Text('Error'),
            //             content: const Text('Please enter the number of pallet stacks.'),
            //             actions: [
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.of(context).pop();
            //                 },
            //                 child: const Text('OK'),
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //       setState(() {
            //         showTable = false; // Hide the table
            //         palletDetails.clear(); // Clear the pallet details
            //       });
            //     }
            //   },
            //   child: const Text('Accept'),
            // ),

            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (numberOfPalletStacks != null) {
                  setState(() {
                    showTable = true;
                    isLoading = true;
                    palletDetails.clear();
                    showError = false;
                  });
                  await fetchDataFromApi();
                  generatePalletDetails();
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    showError = true;
                  });
                }
              },
              child: const Text('Accept'),
            ),


            if (showTable) ...[
              const SizedBox(height: 16.0),
              const Text(
                'Pallet Details :', // Add the desired text here
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
    if (showTable) ...[
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(width: 1, style: BorderStyle.solid),
                  // border: const TableBorder(
                  //     top: BorderSide(width: 1),
                  //     right: BorderSide(width:1),
                  //     bottom: BorderSide(width: 1),
                  //     left: BorderSide(width: 1),
                  //     verticalInside: BorderSide(width: 1)
                  // ),
                  dataRowColor:
                  MaterialStateColor.resolveWith((states) => tableColor),
                  headingRowColor:
                  MaterialStateColor.resolveWith((states) => outlineColor),
                  columnSpacing: 8.0,
                  columns: [
                    DataColumn(
                      label: Text('HU_ID'),
                      onSort: (columnIndex, _) {
                        // Handle sorting if needed
                      },
                    ),
                    DataColumn(
                      label: Text('HU_VOL'),
                      onSort: (columnIndex, _) {
                        // Handle sorting if needed
                      },
                    ),
                    DataColumn(
                      label: Text('HU_STAT'),
                      onSort: (columnIndex, _) {
                        // Handle sorting if needed
                      },
                    ),
                    DataColumn(
                      label: Text('HU_HUPT'),
                      onSort: (columnIndex, _) {
                        // Handle sorting if needed
                      },
                    ),
                    DataColumn(
                      label: Text('HU_USAGE'),
                      onSort: (columnIndex, _) {
                        // Handle sorting if needed
                      },
                    ),
                    DataColumn(
                      label: Text('HU_PAPR3'),
                      onSort: (columnIndex, _) {
                        // Handle sorting if needed
                      },
                    ),
                  ],
                  rows: palletDetails
                      .map(
                        (data) => DataRow(
                      cells: [
                        DataCell(Text(data.huId,textAlign: TextAlign.center)),
                        DataCell(Text(data.huVol,textAlign: TextAlign.center)),
                        DataCell(Text(data.huStat,textAlign: TextAlign.center)),
                        DataCell(Text(data.huHupt,textAlign: TextAlign.center)),
                        DataCell(Text(data.huUsage,textAlign: TextAlign.center)),
                        DataCell(Text(data.huPapr3,textAlign: TextAlign.center)),
                      ],
                    ),
                  )
                      .toList(),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                SizedBox(
                height: 50,
                width: 100,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  padding: EdgeInsets.zero, // Add this line to remove the default padding
                ),
                onPressed: () {
                  // Implement confirm logic here
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure you want to confirm?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Perform the confirmation action
                              Navigator.of(context).pop();
                            },
                            child: const Text('Confirm'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Confirm'),
              ),
    ),
    //const Divider(),
                  const SizedBox(width: 16.0),
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
        padding: EdgeInsets.zero, // Add this line to remove the default padding
      ),
      onPressed: () {
        setState(() {
          showTable = false; // Hide the table
          palletDetails.clear(); // Clear the pallet details
          numberOfPalletStacks = null; // Reset the entered number of pallet stacks
        });

        final textField = context.findAncestorWidgetOfExactType<TextField>();
        if (textField is TextField) {
          textField.controller?.clear(); // Clear the text field value
        }
      },



      child: const Text('Reset'),
    ),
    ),
            ],
    ),
    ],
       ],
        ]),

      ),
    );
  }

  Future<void> fetchDataFromApi() async {
    setState(() {
      isLoading = true;
    });

    if (palletDetails.isEmpty) {
      try {
        final response = await http.get(
          Uri.parse('https://10.0.2.2:7058/api/Product/GetProductCount'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> responseData = json.decode(response.body);
          setState(() {
            palletDetails = responseData
                .map(
                  (data) => PalletDetails(
                huId: data['HU_ID'].toString(),
                huVol: data['HU_VOL'].toString(),
                huStat: data['HU_STAT'],
                huHupt: data['HU_HUPT'].toString(),
                huUsage: data['HU_USAGE'],
                huPapr3: data['HU_PAPR3'].toString(),
              ),
            )
                .toList();
            filterPalletDetails();
          });
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Failed to fetch data from the API.'),
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'An error occurred while fetching data from the API.'),
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

    setState(() {
      isLoading = false;
    });
  }

  void generatePalletDetails() {
    // Generate pallet details based on the number of pallet stacks
    // Implement your logic here
    // Example:
    palletDetails = palletDetails.take(numberOfPalletStacks!).toList();
  }

  void filterPalletDetails() {
    // Implement filtering logic if needed
    // Example:
    // palletDetails = palletDetails.where((pallet) => ...).toList();
  }
}

class PalletDetails {
  final String huId;
  final String huVol;
  final dynamic huStat;
  final String huHupt;
  final dynamic huUsage;
  final String huPapr3;

  PalletDetails({
    required this.huId,
    required this.huVol,
    required this.huStat,
    required this.huHupt,
    required this.huUsage,
    required this.huPapr3,
  });
}

