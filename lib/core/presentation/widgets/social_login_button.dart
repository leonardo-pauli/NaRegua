import 'package:flutter/material.dart';
import 'package:barber_flow/core/theme/app_colors.dart';

/// Botão de login social (Google, Apple, etc.).
/// Aceita [icon] (IconData) ou [iconWidget] (Widget customizado, ex: SVG).
class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: AppColors.inputBorder, width: 1.5),
        foregroundColor: AppColors.textDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconWidget != null)
            iconWidget!
          else if (icon != null)
            Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
