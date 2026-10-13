import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/logo_badge.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openWelcomeScreen();
  }

  // Wait 2 seconds, then replace this screen with the welcome screen.
  Future<void> _openWelcomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    // The screen may already be closed. Do not navigate if it is.
    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoBadge(size: 160),
              const SizedBox(height: 24),
              const Text(
                'Campus Service Portal',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Helpdesk for students and staff',
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
