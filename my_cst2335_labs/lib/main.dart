import 'package:flutter/material.dart';

void main() { //inits app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget { //extends stateful widget, which declares
  // ListPage as dynamic
  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  final TextEditingController _controllerItem = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  // Each list entry is an item with  String(name + quantity)
  List<Map<String, String>> _items = [];

  void _addItem() {

    final name = _controllerItem.text.trim();
    final qty  = _controllerQuantity.text.trim();

    if (name.isNotEmpty && qty.isNotEmpty) { //checks if input is completely empty
      _items.add({'name': name, 'quantity': qty}); //adds item to Pagelist
      _controllerItem.clear(); //clears input
      _controllerQuantity.clear(); //clears input
      setState(() {}); // tells app tp update the list
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Input Row
            Row(
              children: [
                // Item Name
                Expanded(
                  child: TextField(
                    controller: _controllerItem,
                    decoration: InputDecoration(
                      labelText: 'Item',
                      hintText: 'Type the item here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 12),

                // Quantity
                Expanded(
                  child: TextField(
                    controller: _controllerQuantity,
                    decoration: InputDecoration(
                      labelText: 'Qty',
                      hintText: 'Type the quantity here',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                SizedBox(width: 12),

                // Add Button
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // List or Placeholder
            Expanded( //lab6 begins
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return GestureDetector( // the delete function, activation
                    //when the item is long pressed below
                    onLongPress: () => _confirmDelete(index),


                    child: Center( // delete confirmation popup
                      child: Container(
                          child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [ //
                            Text(
                              '${index + 1}. ${item['name']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(// space at start to separate the metrics
                              ' quantity: ${item['quantity'] ?? ''}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder:(context) => AlertDialog(
        title: Text('Delete Item?'),
        content: Text(  //references the item in question, since the alert box
          //can block the item and I hate that.
          'Are you sure you want to remove "${_items[index]['name']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed:(){
              setState((){
                _items.removeAt(index); // Remove item from list
              });
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}