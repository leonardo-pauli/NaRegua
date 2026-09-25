import 'package:flutter/material.dart';
import 'package:barber_flow/core/theme/app_colors.dart';
import 'package:barber_flow/features/home/presentation/widgets/barber_card.dart';
import 'package:barber_flow/features/home/presentation/widgets/filter_overlay.dart';

class ExploreBarbersPage extends StatefulWidget {
  const ExploreBarbersPage({super.key});

  @override
  State<ExploreBarbersPage> createState() => _ExploreBarbersPageState();
}

class _ExploreBarbersPageState extends State<ExploreBarbersPage> {
  final List<String> categories = [
    'All Service',
    'Basic haircut',
    'Coloring',
    'Treatment',
  ];
  String selectedCategory = 'All Service';

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppColors.darkNavy;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Explore Barbers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildFeaturedCarousel(primaryColor),
              const SizedBox(height: 24),
              _buildSearchBar(context, primaryColor),
              const SizedBox(height: 24),
              _buildCategories(),
              const SizedBox(height: 24),
              _buildBarbersList(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCarousel(Color primaryColor) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=400&auto=format&fit=crop',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            'Booking',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.calendar_month, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Master piece Barbershop - Haircut styling',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Color(0xFF9CA3AF)),
                  const SizedBox(width: 4),
                  const Text(
                    'Jogja Expo Centre (2 km)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFF9CA3AF), size: 14),
                  const SizedBox(width: 4),
                  const Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Container(width: 16, height: 6, decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(4))),
          ],
        )
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, Color primaryColor) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search barber's, haircut ser...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => FilterOverlay.show(context),
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkNavy.withValues(alpha: 0.1) : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.darkNavy : Colors.transparent,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? AppColors.darkNavy : Colors.grey[500],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBarbersList() {
    final barbers = [
      {
        'name': 'Varcity Barbershop Jogja ex The Varcher',
        'address': 'Condongcatur',
        'distance': '10 km',
        'rating': 4.5,
        'image': 'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?q=80&w=150&auto=format&fit=crop'
      },
      {
        'name': 'Twinsky Monkey Barber & Men Stuff',
        'address': 'Jl Taman Siswa',
        'distance': '8 km',
        'rating': 5.0,
        'image': 'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?q=80&w=150&auto=format&fit=crop'
      },
      {
        'name': 'Barberman - Haircut styling & massage',
        'address': 'J-Walk Centre',
        'distance': '17 km',
        'rating': 4.5,
        'image': 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=150&auto=format&fit=crop'
      },
      {
        'name': 'Alana Barbershop - Haircut massage & Spa',
        'address': 'Banguntapan',
        'distance': '5 km',
        'rating': 4.5,
        'image': 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?q=80&w=150&auto=format&fit=crop'
      },
      {
        'name': 'Hercha Barbershop - Haircut & Styling',
        'address': 'Jalan Kaliurang',
        'distance': '8 km',
        'rating': 5.0,
        'image': 'https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=150&auto=format&fit=crop'
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: barbers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final barber = barbers[index];
        return BarberCard(
          name: barber['name'] as String,
          address: barber['address'] as String,
          rating: barber['rating'] as double,
          distance: barber['distance'] as String,
          imageUrl: barber['image'] as String,
        );
      },
    );
  }
}
