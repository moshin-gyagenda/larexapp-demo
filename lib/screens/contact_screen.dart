import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.email),
            title: Text('helpdesk@campus.ac.ug'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Estates'),
            subtitle: Text('0414 000 210'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('ICT'),
            subtitle: Text('0414 000 211'),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Mon-Fri, 8:00am - 5:00pm'),
          ),
        ],
      ),
    );
  }
}
