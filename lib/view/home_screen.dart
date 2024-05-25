import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  late Box myBox;

  @override
  void initState() {
    super.initState();
    myBox = Hive.box('myBox');
  }

  void addItem() {
    final key = keyController.text;
    final value = valueController.text;

    if (key.isNotEmpty && value.isNotEmpty) {
      myBox.put(key, value);

      keyController.clear();
      valueController.clear();

      setState(() {});
    }
  }

  void updateItem(String key, String value) {
    keyController.text = key;
    valueController.text = value;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              decoration: InputDecoration(labelText: 'Key'),
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Value'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newKey = keyController.text;
              final newValue = valueController.text;

              if (newKey.isNotEmpty && newValue.isNotEmpty) {
                myBox.delete(key);
                myBox.put(newKey, newValue);

                keyController.clear();
                valueController.clear();

                Navigator.of(context).pop();
                setState(() {});
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void deleteItem(String key) {
    myBox.delete(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive CRUD')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: keyController,
                  decoration: InputDecoration(labelText: 'Key'),
                ),
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(labelText: 'Value'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: addItem,
                  child: Text('Add Item'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: myBox.listenable(),
              builder: (context, Box box, _) {
                if (box.isEmpty) {
                  return Center(child: Text('No data available.'));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final key = box.keyAt(index);
                    final value = box.get(key);

                    if (key is String && value is String) {
                      return ListTile(
                        title: Text('Key: $key'),
                        subtitle: Text('Value: $value'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => updateItem(key, value),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteItem(key),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(); // Handle non-string cases or errors
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
