// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grid_model.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gridModel = Provider.of<GridModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text('Manage Classes', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Back to Menu'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Add New Class'),
              onTap: () {
                Navigator.pop(context);
                _showAddGroupDialog(context, gridModel);
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: gridModel.groupNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(gridModel.groupNames[index]),
            onTap: () {
              gridModel.setCurrentGroup(gridModel.groupNames[index]);
              Navigator.pushNamed(context, '/table');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGroupDialog(context, gridModel);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddGroupDialog(BuildContext context, GridModel gridModel) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Group'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter group name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                gridModel.addGroup(_controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
