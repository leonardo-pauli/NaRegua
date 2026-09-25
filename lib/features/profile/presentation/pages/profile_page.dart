import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber_flow/core/theme/app_colors.dart';
import 'package:barber_flow/core/presentation/widgets/custom_button.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:barber_flow/features/auth/presentation/bloc/auth_event.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Navy Background with Pattern
          _buildNavyBackground(context),
          
          // Foreground Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(),
                const SizedBox(height: 16),
                _buildProfileInfo(context),
                const SizedBox(height: 24),
                _buildSettingsCard(context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.darkNavy,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        currentIndex: 3,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Agendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildNavyBackground(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      color: AppColors.darkNavy,
      child: const _BarberPatternOverlay(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Perfil',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: const [
              Icon(Icons.content_cut, color: AppColors.white, size: 20),
              SizedBox(width: 6),
              Text(
                'Gobar',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white.withValues(alpha: 0.5), width: 3),
                  image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Name and Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.workspace_premium, color: AppColors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Platinum',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Joe Samanta',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Edit Button
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.edit, color: AppColors.darkNavy, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Icon(Icons.email_outlined, color: AppColors.white, size: 18),
              SizedBox(width: 12),
              Text(
                'Joesamanta@gmail.com',
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.location_on_outlined, color: AppColors.white, size: 18),
              SizedBox(width: 12),
              Text(
                'Daerah Istimewa Yogyakarta',
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configurações',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingTile(
                title: 'Notificações',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.white,
                  activeTrackColor: AppColors.darkNavy,
                ),
              ),
              const Divider(height: 1),
              _buildSettingTile(
                title: 'Conta',
              ),
              const Divider(height: 1),
              _buildSettingTile(
                title: 'Segurança',
              ),
              const Divider(height: 1),
              _buildSettingTile(
                title: 'Ajuda',
              ),
              const Divider(height: 1),
              _buildSettingTile(
                title: 'Sobre',
              ),
              const Divider(height: 1),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Sair',
                onPressed: () {
                  context.read<AuthBloc>().add(const SignOutEvent());
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({required String title, Widget? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.darkNavy,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textGray),
      onTap: () {},
    );
  }
}

/// Overlay decorativo com ícones de barbearia (reutilizado o padrão visual)
class _BarberPatternOverlay extends StatelessWidget {
  const _BarberPatternOverlay();

  static const _icons = [
    Icons.content_cut,
    Icons.brush_outlined,
    Icons.air_outlined,
    Icons.auto_fix_high,
    Icons.face_retouching_natural,
    Icons.spa_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final random = Random(42);
        
        return Stack(
          children: List.generate(24, (i) {
            final icon = _icons[i % _icons.length];
            final left = random.nextDouble() * (constraints.maxWidth - 40);
            final top = random.nextDouble() * (constraints.maxHeight - 40);
            final rotation = (random.nextDouble() - 0.5) * 1.6;
            final size = 24.0 + random.nextDouble() * 24;
            final opacity = 0.03 + random.nextDouble() * 0.05;

            return Positioned(
              left: left,
              top: top,
              child: Transform.rotate(
                angle: rotation,
                child: Icon(
                  icon,
                  size: size,
                  color: Colors.white.withValues(alpha: opacity),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
