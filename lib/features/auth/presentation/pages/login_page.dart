import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barber_flow/core/theme/app_colors.dart';
import 'package:barber_flow/core/presentation/widgets/custom_text_field.dart';
import 'package:barber_flow/core/presentation/widgets/custom_button.dart';
import 'package:barber_flow/core/presentation/widgets/social_login_button.dart';
import 'package:barber_flow/core/routes/app_router.dart';
import 'package:barber_flow/features/auth/presentation/widgets/auth_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Disparar evento para AuthBloc
    }
  }

  void _onGoogleLoginPressed() {
    // TODO: Disparar evento para AuthBloc (Google Sign In)
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, AppRouter.register);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight * 0.40;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            AuthHeader(height: heroHeight),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: heroHeight - 30),
                  _buildFormCard(screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(double screenHeight) {
    return Container(
      constraints: BoxConstraints(minHeight: screenHeight * 0.65),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bem-vindo de volta! 👋',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Faça login para acessar sua conta',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              label: 'E-mail',
              hintText: 'seunome@email.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.primaryOrange,
                size: 22,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O e-mail é obrigatório';
                }
                if (!value.contains('@')) return 'E-mail inválido';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Senha',
              hintText: '••••••••',
              controller: _passwordController,
              isPassword: true,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.primaryOrange,
                size: 22,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A senha é obrigatória';
                }
                return null;
              },
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Tela de recuperar senha
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryOrange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                ),
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(text: 'Entrar', onPressed: _onLoginPressed),
            const SizedBox(height: 28),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OU',
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 28),
            SocialLoginButton(
              text: 'Continuar com Google',
              icon: Icons.g_mobiledata,
              onPressed: _onGoogleLoginPressed,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ainda não tem conta? ',
                  style: TextStyle(color: AppColors.textGray, fontSize: 14),
                ),
                GestureDetector(
                  onTap: _navigateToRegister,
                  child: const Text(
                    'Cadastre-se',
                    style: TextStyle(
                      color: AppColors.darkNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
