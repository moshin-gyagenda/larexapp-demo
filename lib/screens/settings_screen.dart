import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Helpdesk hours'),
            subtitle: Text('Mon-Fri, 8:00am - 5:00pm'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Alerts'),
            subtitle: Text('Email when a ticket changes'),
          ),
        ],
      ),
    );
  }
}
