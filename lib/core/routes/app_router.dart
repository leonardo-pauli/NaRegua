import 'package:flutter/material.dart';
import 'package:barber_flow/features/auth/presentation/pages/login_page.dart';
import 'package:barber_flow/features/auth/presentation/pages/register_page.dart';
import 'package:barber_flow/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:barber_flow/features/auth/presentation/pages/authentication_page.dart';

class AppRouter {
  AppRouter._();

  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String authentication = '/authentication';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case authentication:
        return MaterialPageRoute(builder: (_) => const AuthenticationPage());
      // Outras rotas serão adicionadas conforme features forem implementadas
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
