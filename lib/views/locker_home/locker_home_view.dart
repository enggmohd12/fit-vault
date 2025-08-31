import 'package:fitvault/services/credential_store.dart';
import 'package:flutter/material.dart';

class LockerHomeView extends StatefulWidget {
  final CredentialStore credStore;
  const LockerHomeView({
    super.key,
    required this.credStore,
  });

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
