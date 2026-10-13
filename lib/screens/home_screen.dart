import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/logo_badge.dart';
import 'contact_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 0 = Home, 1 = Services, 2 = Tickets, 3 = Profile
  int _selected = 0;

  final List<String> _titles = ['Home', 'Services', 'Tickets', 'Profile'];

  void _signOut() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }

  // Change the page, then close the drawer.
  void _go(int index) {
    setState(() {
      _selected = index;
    });
    Navigator.pop(context);
  }

  void _showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selected]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: AppColors.blue),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: AssetImage('assets/img/logo.png'),
              ),
              accountName: const Text('Campus Portal'),
              accountEmail: Text(widget.userName),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: _selected == 0,
              onTap: () => _go(0),
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Services'),
              selected: _selected == 1,
              onTap: () => _go(1),
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_number),
              title: const Text('Tickets'),
              selected: _selected == 2,
              onTap: () => _go(2),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: _selected == 3,
              onTap: () => _go(3),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign out'),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: _page(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selected,
        selectedItemColor: AppColors.blue,
        onTap: (index) {
          setState(() {
            _selected = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _page() {
    if (_selected == 1) {
      return _servicesPage();
    }
    if (_selected == 2) {
      return _ticketsPage();
    }
    if (_selected == 3) {
      return ProfileScreen(userName: widget.userName);
    }
    return _homePage();
  }

  Widget _homePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const LogoBadge(size: 64),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.userName, style: const TextStyle(color: AppColors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _showMessage('Open a ticket', 'Say the problem and the place.');
            },
            icon: const Icon(Icons.add),
            label: const Text('Open a ticket'),
          ),
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(child: InfoCard(value: '12', label: 'Open')),
            SizedBox(width: 8),
            Expanded(child: InfoCard(value: '1 min', label: 'To report')),
            SizedBox(width: 8),
            Expanded(child: InfoCard(value: '5', label: 'Teams')),
          ],
        ),
      ],
    );
  }

  Widget _servicesPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ServiceCard(
                title: 'Estates',
                details: 'Leaks and lights',
                icon: Icons.home_repair_service,
                onTap: () => _showMessage('Estates', 'Block A, ground floor'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ServiceCard(
                title: 'ICT',
                details: 'Wi-Fi and projectors',
                icon: Icons.computer,
                onTap: () => _showMessage('ICT', 'Library, 1st floor'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ServiceCard(
                title: 'Halls',
                details: 'Book a room',
                icon: Icons.meeting_room,
                onTap: () => _showMessage('Halls', 'Academic block'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ServiceCard(
                title: 'Hostels',
                details: 'Room faults',
                icon: Icons.hotel,
                onTap: () => _showMessage('Hostels', 'Gate 2'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ServiceCard(
                title: 'Registry',
                details: 'Letters',
                icon: Icons.article_outlined,
                onTap: () => _showMessage('Registry', 'Appointments and letters'),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _ticketsPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TicketCard(
          title: 'No display in Hall B2',
          owner: 'ICT · Peter',
          status: 'Working on it',
          statusColor: AppColors.blue,
        ),
        SizedBox(height: 8),
        TicketCard(
          title: 'Leak in Hostel C, room 14',
          owner: 'Estates',
          status: 'New',
          statusColor: AppColors.gold,
        ),
        SizedBox(height: 8),
        TicketCard(
          title: 'Hall A1 booked Friday',
          owner: 'Halls office',
          status: 'Done',
          statusColor: Color(0xFF15803D),
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String details;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.details,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/img/logo.png', fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              Icon(icon, color: AppColors.blue),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                details,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String value;
  final String label;

  const InfoCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
          ],
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String title;
  final String owner;
  final String status;
  final Color statusColor;

  const TicketCard({
    super.key,
    required this.title,
    required this.owner,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(owner, style: const TextStyle(color: AppColors.grey)),
          ],
        ),
      ),
    );
  }
}
