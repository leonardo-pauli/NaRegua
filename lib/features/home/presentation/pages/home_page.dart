import 'package:flutter/material.dart';
import 'package:barber_flow/features/home/presentation/widgets/barber_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF322C5C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: primaryColor),
                            const SizedBox(width: 4),
                            Text(
                              'Yogyakarta',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Joe Samanta',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Banner
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9900),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Placeholder for banner background pattern and image
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?q=80&w=300&auto=format&fit=crop',
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.content_cut, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Booking Now', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Search Bar
                Row(
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
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Nearest Babershop
                const Text(
                  'Nearest Babershop',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 16),
                
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final barbers = [
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
                        'image': 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=150&auto=format&fit=crop'
                      },
                      {
                        'name': 'Barberking - Haircut styling & massage',
                        'address': 'Jogja Expo Centre',
                        'distance': '12 km',
                        'rating': 4.5,
                        'image': 'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?q=80&w=150&auto=format&fit=crop'
                      },
                    ];
                    final barber = barbers[index];
                    return BarberCard(
                      name: barber['name'] as String,
                      address: barber['address'] as String,
                      rating: barber['rating'] as double,
                      distance: barber['distance'] as String,
                      imageUrl: barber['image'] as String,
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // See All
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('See All', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_outward, size: 18),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Most recommended
                const Text(
                  'Most recommended',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Recommended Card
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
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
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
                
                const SizedBox(height: 32),
                
                // Find a barber nearby
                const Text(
                  'Find a barber nearby',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Map Card
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=400&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Find now', style: TextStyle(color: Colors.white)),
                              SizedBox(width: 8),
                              Icon(Icons.search, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
