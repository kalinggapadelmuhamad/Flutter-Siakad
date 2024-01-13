import 'package:flutter/material.dart';
import 'package:flutter_siakad_app/pages/auth/_auth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AuthPage();
          }));
        },
        child: const Text('Logout'),
      ),
    );
  }
}
