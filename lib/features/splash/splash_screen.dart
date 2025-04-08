import 'package:comment_management/core/extensions/context-extensions.dart';
import 'package:comment_management/core/router/app_routes_names.dart';
import 'package:comment_management/utils/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(3750.ms, () {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutesNames.commentsInfoScreen, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: context.primaryColor.withOpacity(0.2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Crescent moon with a star
              const SizedBox(height: 20),
              Image.asset(AssetsData.logo, width: 100, height: 100),
              // Animated App Title
              const Text(
                'CommentSync',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ).animate().fadeIn(delay: 1000.ms, duration: 1000.ms),
              const SizedBox(height: 10),
              const Text(
                'Organize, review, and respond.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white54),
              ).animate().fadeIn(delay: 1500.ms, duration: 1000.ms),
            ],
          ) // Drop from top
          .animate().moveY(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceOut,
            begin: -300,
            end: 0,
          ),
        ),
      ),
    );
  }
}
