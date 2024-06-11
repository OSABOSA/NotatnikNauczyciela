// lib/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grid_model.dart';
import 'theme_model.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gridModel = Provider.of<GridModel>(context);
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Passcode'),
            onTap: () {
              _showChangePasscodeDialog(context, gridModel);
            },
          ),
          ListTile(
            title: Text('Manage Classes'),
            onTap: () {
              _showManageClassesDialog(context, gridModel);
            },
          ),
          SwitchListTile(
            title: Text('Dark Theme'),
            value: themeModel.isDark,
            onChanged: (value) {
              themeModel.toggleTheme();
            },
          ),
          ListTile(
            title: Text('Change Main Color'),
            onTap: () {
              _showChangeColorDialog(context, themeModel);
            },
          ),
        ],
      ),
    );
  }

  void _showChangePasscodeDialog(BuildContext context, GridModel gridModel) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Passcode'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter new passcode'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                gridModel.setPasscode(_controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }

  void _showManageClassesDialog(BuildContext context, GridModel gridModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Manage Classes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: gridModel.groupNames.map((name) {
              return ListTile(
                title: Text(name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    gridModel.removeGroup(name);
                    Navigator.of(context).pop();
                  },
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _showChangeColorDialog(BuildContext context, ThemeModel themeModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Main Color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Purple'),
                onTap: () {
                  themeModel.changeMainColor(Colors.purple);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Blue'),
                onTap: () {
                  themeModel.changeMainColor(Colors.blue);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Green'),
                onTap: () {
                  themeModel.changeMainColor(Colors.green);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
