import 'package:flutter/material.dart';

class SongsTitle extends StatelessWidget {
  const SongsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Songs',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
