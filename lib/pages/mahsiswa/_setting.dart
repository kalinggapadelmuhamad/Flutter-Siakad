import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/logout/logout_bloc.dart';
import 'package:flutter_siakad_app/data/datasource/auth_local_datasource.dart';
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
      child: BlocProvider(
        create: (context) => LogoutBloc(),
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                loaded: () {
                  AuthLocalDatasource().removeAuthData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const AuthPage();
                  }));
                },
                error: () {
                  return ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout Error')));
                });
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('Logout'),
                );
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}
