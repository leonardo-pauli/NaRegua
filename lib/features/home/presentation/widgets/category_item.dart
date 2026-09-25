import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? theme.colorScheme.onPrimary : theme.iconTheme.color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
