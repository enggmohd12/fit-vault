import 'package:flutter/material.dart';

class LockerHomeView extends StatefulWidget {
  const LockerHomeView({super.key});

  @override
  State<LockerHomeView> createState() => _LockerHomeViewState();
}

class _LockerHomeViewState extends State<LockerHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locker Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Locker Home!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}