import 'package:flutter/material.dart';
import 'package:open_job/controller/setting_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingController _settingController = SettingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: _settingController.isDarkMode,
            onChanged: (value) {
              setState(() {
                _settingController.toggleDarkMode(value);
              });
            },
          ),
          
        ],
      ),
    );
  }
}
