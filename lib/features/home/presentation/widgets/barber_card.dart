import 'package:flutter/material.dart';

class BarberCard extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final String distance;
  final String imageUrl;

  const BarberCard({
    super.key,
    required this.name,
    required this.address,
    required this.rating,
    required this.distance,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.store, color: Colors.white, size: 40),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Color(0xFF9CA3AF)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '$address ($distance)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFF9CA3AF), size: 14),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
