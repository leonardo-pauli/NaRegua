import 'dart:math';
import 'package:flutter/material.dart';
import 'package:barber_flow/core/theme/app_colors.dart';

/// Seção hero (cabeçalho laranja) usada nas telas de autenticação.
/// Exibe o gradiente de marca, padrão decorativo de ícones de barbearia
/// e o logo/branding centralizado.
class AuthHeader extends StatelessWidget {
  final double height;

  const AuthHeader({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.orangeLight,
            AppColors.primaryOrange,
            AppColors.orangeDark,
          ],
        ),
      ),
      child: Stack(
        children: [
          _BarberPatternOverlay(height: height),
          _buildBranding(),
        ],
      ),
    );
  }

  Widget _buildBranding() {
    return Positioned(
      bottom: 56,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.content_cut_rounded,
            size: 42,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Overlay decorativo com ícones de barbearia espalhados
/// em posições e rotações aleatórias (seed fixo para consistência).
class _BarberPatternOverlay extends StatelessWidget {
  final double height;

  const _BarberPatternOverlay({required this.height});

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
    final screenWidth = MediaQuery.of(context).size.width;
    final random = Random(42); // Seed fixo para layout consistente

    return Stack(
      children: List.generate(18, (i) {
        final icon = _icons[i % _icons.length];
        final left = random.nextDouble() * (screenWidth - 40);
        final top = random.nextDouble() * (height - 40);
        final rotation = (random.nextDouble() - 0.5) * 1.6;
        final size = 24.0 + random.nextDouble() * 18;
        final opacity = 0.06 + random.nextDouble() * 0.09;

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
  }
}
