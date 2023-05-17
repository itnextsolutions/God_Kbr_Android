import 'package:flutter/material.dart';

class EmptyPalletStoreOutProcessScreen extends StatefulWidget {
  @override
  _EmptyPalletStoreOutProcessScreenState createState() =>
      _EmptyPalletStoreOutProcessScreenState();
}

class _EmptyPalletStoreOutProcessScreenState
    extends State<EmptyPalletStoreOutProcessScreen> {
  bool selectAll = false;
  List<bool> selectedItems = [];
  List<PalletData> palletData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Pallet Store Out Process'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Number of Empty Pallet Stacks'),
          ),
          Row(
            children: [
              Checkbox(
                value: selectAll,
                onChanged: (value) {
                  setState(() {
                    selectAll = value!;
                    if (value) {
                      selectedItems = List.generate(palletData.length, (_) => true);
                    } else {
                      selectedItems = List.generate(palletData.length, (_) => false);
                    }
                  });
                },
              ),
              Text('Select All'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: palletData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: selectedItems[index],
                    onChanged: (value) {
                      setState(() {
                        selectedItems[index] = value!;
                        selectAll = selectedItems.every((item) => item);
                      });
                    },
                  ),
                  title: Text(palletData[index].name),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedItems = List.generate(palletData.length, (_) => false);
                    selectAll = false;
                  });
                },
                child: Text('Reset'),
              ),
              ElevatedButton(
                onPressed: () {
                  List<PalletData> confirmedData = [];
                  for (int i = 0; i < palletData.length; i++) {
                    if (selectedItems[i]) {
                      confirmedData.add(palletData[i]);
                    }
                  }
                  // Perform the necessary actions with confirmedData
                  print('Confirmed Data: $confirmedData');
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Simulated API call to fetch pallet data
  void fetchPalletData() {
    // Replace this with your actual API integration code
    // Mocking data for demonstration purposes
    palletData = [
      PalletData('Pallet 1'),
      PalletData('Pallet 2'),
      PalletData('Pallet 3'),
      PalletData('Pallet 4'),
      PalletData('Pallet 5'),
    ];
  }

  @override
  void initState() {
    super.initState();
    fetchPalletData();
    selectedItems = List.generate(palletData.length, (_) => false);
  }
}

class PalletData {
  final String name;

  PalletData(this.name);
}
