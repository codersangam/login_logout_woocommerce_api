import 'package:flutter/material.dart';
import 'package:login/services/shared_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        actions: [
          IconButton(
            onPressed: () {
              SharedService.logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const SizedBox(
        child: Center(
          child: Text('This is HomePage'),
        ),
      ),
    );
  }
}
