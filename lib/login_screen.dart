// lib/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String input = '';
  final String passcode = '1478';

  void _onKeyPressed(String key) {
    setState(() {
      input += key;
      if (input.length == 4) {
        if (input == passcode) {
          Navigator.pushReplacementNamed(context, '/');
        } else {
          setState(() {
            input = '';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter Passcode', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < input.length
                        ? Colors.black
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index < 9) {
                  return _buildKey((index + 1).toString());
                } else if (index == 9) {
                  return _buildKey('');
                } else if (index == 10) {
                  return _buildKey('0');
                } else {
                  return _buildKey('←', isBackspace: true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKey(String label, {bool isBackspace = false}) {
    return GestureDetector(
      onTap: () {
        if (isBackspace) {
          setState(() {
            input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
          });
        } else if (label.isNotEmpty) {
          _onKeyPressed(label);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
