import 'package:flutter/material.dart';

class LogoBadge extends StatelessWidget {
  final double size;

  const LogoBadge({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/img/logo.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
