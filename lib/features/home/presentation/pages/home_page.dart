import 'package:flutter/material.dart';
import 'package:barber_flow/features/home/presentation/widgets/category_item.dart';
import 'package:barber_flow/features/home/presentation/widgets/barber_card.dart';
import 'package:barber_flow/features/home/presentation/widgets/home_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, Cliente! 👋',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Encontre o melhor serviço na sua região',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Search Bar
              const HomeSearchBar(),
              
              const SizedBox(height: 32),
              
              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categorias',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Ver todas'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryItem(icon: Icons.content_cut, label: 'Corte', isSelected: true),
                    SizedBox(width: 16),
                    CategoryItem(icon: Icons.face, label: 'Barba', isSelected: false),
                    SizedBox(width: 16),
                    CategoryItem(icon: Icons.color_lens, label: 'Tintura', isSelected: false),
                    SizedBox(width: 16),
                    CategoryItem(icon: Icons.spa, label: 'Relaxamento', isSelected: false),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              
              // Nearby Barbers Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Barbeiros Próximos',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Ver no Mapa'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Mocked List of Barbers
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return BarberCard(
                    name: 'Barbearia do Zé ${index + 1}',
                    address: 'Rua das Flores, 123 - Centro',
                    rating: 4.8,
                    reviewsCount: 120 + (index * 15),
                    distance: '1.${index + 2} km',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
