import 'package:comment_management/core/router/app_routes_names.dart';
import 'package:comment_management/core/router/middleware.dart';
import 'package:comment_management/features/comments_info/presentation/screens/comments_index_screen.dart';
import 'package:comment_management/features/comments_info/presentation/screens/comments_info_screen.dart';
import 'package:comment_management/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(builder: (context) => const SplashScreen(), settings: routeSettings);
      case AppRoutesNames.commentsInfoScreen:
        return CustomPageRoute(
          builder: (context) => const CommentsInfoScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.commentsIndexScreen:
        return CustomPageRoute(
          builder: (context) => const CommentsIndexScreen(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
