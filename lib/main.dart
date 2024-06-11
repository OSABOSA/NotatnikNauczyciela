// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grid_notepad.dart';
import 'grid_model.dart';
import 'main_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';
import 'theme_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GridModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'Tabular Notepad',
            theme: ThemeData(
              primarySwatch: theme.mainColor,
              brightness: theme.isDark ? Brightness.dark : Brightness.light,
            ),
            initialRoute: '/login',
            routes: {
              '/login': (context) => LoginScreen(),
              '/': (context) => MainScreen(),
              '/table': (context) => GridNotepad(),
              '/settings': (context) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
