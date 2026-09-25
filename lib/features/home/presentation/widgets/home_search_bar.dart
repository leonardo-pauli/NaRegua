import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar barbeiros ou serviços...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.tune,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
