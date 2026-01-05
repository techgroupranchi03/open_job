import 'package:flutter/material.dart';

class ApplyJobScreen extends StatelessWidget {
  const ApplyJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Job'),
      ),
      body: const Center(
        child: Text('Application Form Goes Here'),
      ),
    );
  }
}