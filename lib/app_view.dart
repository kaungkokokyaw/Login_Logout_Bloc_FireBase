import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_logout/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:login_logout/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:login_logout/home/home_screens.dart';
import 'package:login_logout/screens/auth/welcome_screens.dart';
import 'package:lottie/lottie.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  late bool _showSplash;

  @override
  void initState() {
    super.initState();
    _showSplash = true;
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 128, 1),
          onSecondary: Colors.white,
          tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
      ),
      home: _showSplash
          ? _buildSplashScreen()
          : BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
              builder: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  return BlocProvider(
                    create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository,
                    ),
                    child: const HomeScreen(),
                  );
                } else {
                  return const WelcomeScreen();
                }
              },
            ),
    );
  }

  Widget _buildSplashScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/animation/splash_view.json',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
