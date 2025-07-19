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

  void _confirmDelete(int index) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                    onLongPress: () => _confirmDelete(index),
                    child: Center(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${index + 1}. ${item.name}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              ' quantity: ${item.quantity}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
