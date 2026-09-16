import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Rotas serão adicionadas conforme features forem implementadas
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Rota não encontrada'),
            ),
          ),
        );
    }
  }
}
