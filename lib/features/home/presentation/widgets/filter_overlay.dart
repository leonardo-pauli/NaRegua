import 'package:flutter/material.dart';
import 'package:barber_flow/core/theme/app_colors.dart';
import 'package:barber_flow/core/presentation/widgets/custom_button.dart';

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({super.key});

  @override
  State<FilterOverlay> createState() => _FilterOverlayState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterOverlay(),
    );
  }
}

class _FilterOverlayState extends State<FilterOverlay> {
  final List<String> categories = [
    'Corte básico',
    'Coloração',
    'Tratamento',
    'Massagem',
    'Corte infantil',
  ];
  String selectedCategory = 'Corte básico';
  double rating = 4.0;
  
  final TextEditingController _minDistanceController = TextEditingController(text: '0.1');
  final TextEditingController _maxDistanceController = TextEditingController(text: '10');

  @override
  void dispose() {
    _minDistanceController.dispose();
    _maxDistanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 24 + bottomInset,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildCategories(),
            const SizedBox(height: 32),
            _buildRating(),
            const SizedBox(height: 32),
            _buildDistance(),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Aplicar',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: AppColors.primaryOrange, size: 20),
            ),
            const SizedBox(width: 16),
            const Text(
              'Filtro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkNavy,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categoria Geral',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final isSelected = selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkNavy.withValues(alpha: 0.05) : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.darkNavy : Colors.grey[300]!,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
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
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Avaliação',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ...List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: index < rating.floor() ? Colors.orange : Colors.grey[300],
                size: 28,
              );
            }),
            const SizedBox(width: 8),
            Text(
              '(${rating.toStringAsFixed(1)})',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            activeTrackColor: AppColors.darkNavy,
            inactiveTrackColor: Colors.grey[200],
            thumbColor: AppColors.darkNavy,
            overlayColor: AppColors.darkNavy.withValues(alpha: 0.1),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(
            value: rating,
            min: 1,
            max: 5,
            divisions: 40,
            onChanged: (value) {
              setState(() {
                rating = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDistance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distância',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildDistanceInput('Mínima', _minDistanceController),
            const SizedBox(width: 16),
            const Text(
              '-',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: AppColors.darkNavy,
              ),
            ),
            const SizedBox(width: 16),
            _buildDistanceInput('Máxima', _maxDistanceController),
          ],
        ),
      ],
    );
  }

  Widget _buildDistanceInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 60,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.darkNavy),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'km',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.darkNavy,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
