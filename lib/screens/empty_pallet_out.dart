import 'package:flutter/material.dart';

class EmptyPalletStoreOutScreen extends StatefulWidget {
  const EmptyPalletStoreOutScreen({Key? key}) : super(key: key);

  @override
  _EmptyPalletStoreOutScreenState createState() =>
      _EmptyPalletStoreOutScreenState();
}

class _EmptyPalletStoreOutScreenState extends State<EmptyPalletStoreOutScreen> {
  bool selectAll = false;
  List<bool> selectedList = List.filled(5, true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Pallet Store Out Process'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pallet Requirement',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Number of Empty Pallet Stacks',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: selectAll,
                      onChanged: (value) {
                        setState(() {
                          selectAll = value!;
                          selectedList =
                              List.filled(selectedList.length, value);
                        });
                      },
                    ),
                    const Text('Select All'),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pallet Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Select')),
                        DataColumn(label: Text('Pallet ID')),
                        DataColumn(label: Text('No of Pallets')),
                        DataColumn(label: Text('Aisle')),
                        DataColumn(label: Text('X')),
                        DataColumn(label: Text('Y')),
                        DataColumn(label: Text('Direction')),
                        DataColumn(label: Text('Deep')),
                      ],
                      rows: List.generate(selectedList.length, (index) {
                        final selected = selectedList[index];
                        return DataRow(
                          cells: [
                            DataCell(
                              Checkbox(
                                value: selected,
                                onChanged: (value) {
                                  setState(() {
                                    selectedList[index] = value!;
                                    if (!value) {
                                      selectAll = false;
                                    }
                                  });
                                },
                              ),
                            ),
                            const DataCell(Text('Pallet 001')),
                            const DataCell(Text('10')),
                            const DataCell(Text('Aisle 1')),
                            const DataCell(Text('X1')),
                            const DataCell(Text('Y1')),
                            const DataCell(Text('Direction 1')),
                            const DataCell(Text('Deep 1')),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
