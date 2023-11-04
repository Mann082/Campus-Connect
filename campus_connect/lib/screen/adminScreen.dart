import 'package:flutter/material.dart';

class adminScreen extends StatelessWidget {
  static const routeName = '/adminScreen';
  const adminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Controls')),
      body: const Center(),
    );
  }
}
