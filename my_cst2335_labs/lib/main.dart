import 'package:flutter/material.dart';
import 'AppList.dart';
import 'DAO.dart';
import 'Database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  final _controllerItem = TextEditingController();
  final _controllerQuantity = TextEditingController();



  List<AppList> _items = [];
  AppList? _selectedItem;
  AppListDao? _dao;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    final db = await $FloorAppDatabase.databaseBuilder('applist.db').build();
    _dao = db.appListDao;

    final dbItems = await _dao!.findAllItems();
    for (var item in dbItems) {
      if (item.id >= AppList.ID) AppList.ID = item.id + 1;
    }

    setState(() {
      _items = dbItems;
    });
  }

  void _addItem() async {
    final name = _controllerItem.text.trim();
    final qty = _controllerQuantity.text.trim();

    if (name.isNotEmpty && qty.isNotEmpty) {
      final newItem = AppList(AppList.ID++, name, qty);
      await _dao?.insertItem(newItem);
      _controllerItem.clear();
      _controllerQuantity.clear();
      setState(() => _items.add(newItem));
    }
  }

  //deprecated method for this lab
  /* void _confirmDelete(int index) {
    final item = _items[index];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Item?'),
        content: Text('Are you sure you want to remove "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await _dao?.deleteItem(item);
              setState(() => _items.removeAt(index));
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }*/

  void _deleteItem(AppList item) async {
    await _dao?.deleteItem(item);
    setState(() {
      _items.removeWhere((i) => i.id == item.id); //specifies which item
      _selectedItem = null; //deletes item here
    });
  }

  void _closeDetails() {
    setState(() {
      _selectedItem = null; //deselects item
    });
  }

  void _selectItem(AppList item) {//setter for selected item
    setState(() {
      _selectedItem = item;
    });
  }

  Widget _detailsBox(AppList item) { // popup for details
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Item: ${item.name}", style: TextStyle(fontSize: 20)),
          SizedBox(height: 8),
          Text("Quantity: ${item.quantity}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text("ID: ${item.id}", style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _deleteItem(item),
                child: Text("Delete"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: _closeDetails,
                child: Text("Close"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override // checks for phone size, if its too narrow (600px) then it overrides the
  //2 column layout and sticks with 1 column
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: Text("App List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isWide
            ? Row(
          children: [
            Expanded(child: _buildMainList()),
            VerticalDivider(),
            Expanded(
              child: _selectedItem != null
                  ? _detailsBox(_selectedItem!)
                  : Center(child: Text("Select an item to view details")),
            ),
          ],
        )
            : _selectedItem != null
            ? _detailsBox(_selectedItem!)
            : _buildMainList(),
      ),
    );
  }


  Widget _buildMainList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input Row
        Row(
          children: [
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
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add'),
            ),
          ],
        ),
        SizedBox(height: 20),

        // List
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              return GestureDetector(
                onTap: () => _selectItem(item), //replaced on long press as per instructions
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text('${index + 1}. ${item.name}',
                          style: TextStyle(fontSize: 16)),
                      Text(' quantity: ${item.quantity}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

