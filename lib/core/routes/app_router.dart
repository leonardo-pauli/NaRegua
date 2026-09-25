import 'package:flutter/material.dart';
import 'package:barber_flow/features/auth/presentation/pages/login_page.dart';
import 'package:barber_flow/features/auth/presentation/pages/register_page.dart';
import 'package:barber_flow/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:barber_flow/features/auth/presentation/pages/authentication_page.dart';
import 'package:barber_flow/features/home/presentation/pages/home_page.dart';
import 'package:barber_flow/features/home/presentation/pages/explore_barbers_page.dart';
import 'package:barber_flow/features/home/presentation/pages/barber_detail_page.dart';
import 'package:barber_flow/features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String authentication = '/authentication';
  static const String home = '/home';
  static const String exploreBarbers = '/explore_barbers';
  static const String barberDetail = '/barber_detail';
  static const String profile = '/profile';

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
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case exploreBarbers:
        return MaterialPageRoute(builder: (_) => const ExploreBarbersPage());
      case barberDetail:
        return MaterialPageRoute(builder: (_) => const BarberDetailPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
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
