import 'package:barber_flow/core/constants/app_constants.dart';
import 'package:barber_flow/core/di/injection_container.dart';
import 'package:barber_flow/core/routes/app_router.dart';
import 'package:barber_flow/core/theme/app_theme.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_event.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>()..add(const CheckAuthStatusEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthSuccess || current is AuthUnauthenticated,
        listener: (context, state) {
          if (state is AuthSuccess) {
            AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
          } else if (state is AuthUnauthenticated) {
            AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
          }
        },
        child: MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.login,
        ),
      ),
    );
  }
}
