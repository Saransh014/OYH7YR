import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> selectedWidgets = [];
  String? textData;
  String? imageUrl;

  void _showWidgetSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelectedWidgets = [];

        return AlertDialog(
          title: const Text('Select Widgets'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: const Text('Textbox'),
                    value: tempSelectedWidgets.contains('Textbox'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedWidgets.add('Textbox');
                        } else {
                          tempSelectedWidgets.remove('Textbox');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Imagebox'),
                    value: tempSelectedWidgets.contains('Imagebox'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedWidgets.add('Imagebox');
                        } else {
                          tempSelectedWidgets.remove('Imagebox');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Save Button'),
                    value: tempSelectedWidgets.contains('Save Button'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedWidgets.add('Save Button');
                        } else {
                          tempSelectedWidgets.remove('Save Button');
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedWidgets = tempSelectedWidgets;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _handleSave() {
    if (!selectedWidgets.contains('Textbox') &&
        !selectedWidgets.contains('Imagebox')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add at-least a widget to save'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Implement Firebase save functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          if (selectedWidgets.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No widgets added yet'),
              ),
            ),
          if (selectedWidgets.contains('Textbox'))
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                ),
                onChanged: (value) {
                  textData = value;
                },
              ),
            ),
          if (selectedWidgets.contains('Imagebox'))
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add_photo_alternate),
                  onPressed: () {
                    // TODO: Implement image picker
                  },
                ),
              ),
            ),
          if (selectedWidgets.contains('Save Button'))
            ElevatedButton(
              onPressed: _handleSave,
              child: const Text('Save'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showWidgetSelectionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
