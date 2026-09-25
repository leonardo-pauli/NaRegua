import 'package:flutter/material.dart';
import 'package:barber_flow/core/theme/app_colors.dart';
import 'package:barber_flow/core/presentation/widgets/custom_button.dart';

class BarberDetailPage extends StatefulWidget {
  final bool isSoloBarber;

  const BarberDetailPage({
    super.key,
    this.isSoloBarber =
        false, // Modo mock para demonstrar barbeiro com/sem time
  });

  @override
  State<BarberDetailPage> createState() => _BarberDetailPageState();
}

class _BarberDetailPageState extends State<BarberDetailPage> {
  int _selectedTabIndex = 0;
  String? _selectedTimeSlot;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
          'Detalhes da Barbearia',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildCoverImage(),
                const SizedBox(height: 16),
                _buildTitleAndInfo(),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 24),
                _buildTabs(),
                const SizedBox(height: 24),
                _buildTabContent(),
              ],
            ),
          ),
          // Fixed Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: CustomButton(text: 'Agendar Agora', onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=400&auto=format&fit=crop',
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981), // Green
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Aberto',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Master piece Barbershop - Haircut styling',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey[400]),
            const SizedBox(width: 4),
            Text(
              'Jogja Expo Centre (2 km)',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.grey[400], size: 16),
            const SizedBox(width: 4),
            Text(
              '5.0',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(24)',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(Icons.place, 'Mapa', Colors.blue),
        _buildActionButton(Icons.chat_bubble, 'Chat', AppColors.darkNavy),
        _buildActionButton(Icons.share, 'Compartilhar', AppColors.darkNavy),
        _buildActionButton(Icons.favorite, 'Favorito', Colors.red),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color iconColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.darkNavy.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.black, Colors.black, Colors.transparent],
            stops: [0.0, 0.85, 1.0], // Começa a sumir nos últimos 15%
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabItem(0, Icons.info_outline, 'Sobre'),
              _buildTabSeparator(),
              _buildTabItem(1, Icons.content_cut, 'Serviços'),
              _buildTabSeparator(),
              _buildTabItem(2, Icons.calendar_month, 'Horários'),
              _buildTabSeparator(),
              _buildTabItem(3, Icons.star_outline, 'Avaliações'),
              const SizedBox(width: 16), // Espaço extra para o último item passar da máscara
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabSeparator() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildTabItem(int index, IconData icon, String label) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: AppColors.darkNavy.withValues(alpha: 0.2))
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.darkNavy : Colors.grey[500],
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.darkNavy : Colors.grey[500],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildTabContent() {
    if (_selectedTabIndex == 1) {
      return _buildServicesTab();
    }

    if (_selectedTabIndex == 2) {
      return _buildScheduleTab();
    }

    if (_selectedTabIndex == 3) {
      return _buildReviewTab();
    }

    if (_selectedTabIndex != 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Conteúdo em construção...',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
      );
    }

    // Tab 0: Sobre (About)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Color(0xFF4B5563),
              height: 1.5,
              fontSize: 14,
            ),
            children: [
              const TextSpan(
                text:
                    'Na Masterpiece Barbershop, nossa equipe dedicada de barbeiros habilidosos são verdadeiros artistas em sua profissão, transformando seu cabelo, ',
              ),
              TextSpan(
                text: 'Ler mais...',
                style: const TextStyle(
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Horário de Funcionamento',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Segunda - Sexta', style: TextStyle(color: Colors.grey[500])),
            const Text(
              '09:00 am - 08:00 pm',
              style: TextStyle(
                color: AppColors.darkNavy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sábado - Domingo', style: TextStyle(color: Colors.grey[500])),
            const Text(
              '09:00 am - 09:00 pm',
              style: TextStyle(
                color: AppColors.darkNavy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Seção de Equipe ou Barbeiro Solo
        if (widget.isSoloBarber) ...[
          const Text(
            'Atendimento Exclusivo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryOrange.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primaryOrange,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Barbeiro Solo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkNavy,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Este estabelecimento é operado por um único profissional dedicado.',
                        style: TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          const Text(
            'Nossa Equipe',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
            ),
          ),
          const SizedBox(height: 16),
          _buildTeamMember(
            'Luther Hammes',
            'Especialista em Corte',
            5.0,
            'https://i.pravatar.cc/150?img=11',
          ),
          const SizedBox(height: 16),
          _buildTeamMember(
            'Emanuel Bernier',
            'Especialista em Coloração',
            4.5,
            'https://i.pravatar.cc/150?img=12',
          ),
          const SizedBox(height: 16),
          _buildTeamMember(
            'Karl Vandervort',
            'Especialista em Tratamento',
            4.5,
            'https://i.pravatar.cc/150?img=13',
          ),
        ],
      ],
    );
  }

  Widget _buildTeamMember(
    String name,
    String role,
    double rating,
    String imageUrl,
  ) {
    return Row(
      children: [
        CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.darkNavy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                role,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.grey, size: 16),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServicesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nossos Serviços',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
          ),
        ),
        const SizedBox(height: 16),
        _buildServiceItem(
          'Corte básico',
          'Corte básico & vitamina',
          20.0,
          'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=150&q=80',
        ),
        const SizedBox(height: 16),
        _buildServiceItem(
          'Corte infantil',
          'Corte especial infantil',
          15.0,
          'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=150&q=80',
        ),
        const SizedBox(height: 16),
        _buildServiceItem(
          'Coloração',
          'Tratamento com coloração',
          30.0,
          'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?w=150&q=80',
        ),
        const SizedBox(height: 16),
        _buildServiceItem(
          'Tratamento capilar',
          'Tratamento completo especial',
          10.0,
          'https://images.unsplash.com/photo-1517832606299-7ae9b620a186?w=150&q=80',
        ),
        const SizedBox(height: 16),
        _buildServiceItem(
          'Massagem especial',
          'Massagem adicional',
          10.0,
          'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=150&q=80',
        ),
      ],
    );
  }

  Widget _buildServiceItem(
    String name,
    String description,
    double price,
    String imageUrl,
  ) {
    return Row(
      children: [
        CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.darkNavy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          'R\$ ${price.toInt()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkNavy,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTab() {
    // Horários mockados (já filtrados, ou seja, apenas os livres aparecem aqui)
    final availableSlots = [
      '08:00',
      '09:30',
      '10:00',
      '11:30',
      '13:00',
      '14:30',
      '15:00',
      '16:30',
      '17:00',
    ];

    // Formatando a data atual para exibição (mock básico)
    final dateString =
        "${_selectedDate.day} de ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seletor de Data
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime.now(), // Bloqueia dias anteriores
              lastDate: DateTime(DateTime.now().year + 2), // Limita para ano atual + 2 anos
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.darkNavy,
                      onPrimary: Colors.white,
                      onSurface: AppColors.darkNavy,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
                _selectedTimeSlot = null; // Reseta o horário ao trocar de dia
              });
            }
          },
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: AppColors.darkNavy,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                dateString,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.darkNavy),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Horários Disponíveis',
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
          children: availableSlots.map((time) {
            final isSelected = _selectedTimeSlot == time;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTimeSlot = time;
                });
              },
              child: Container(
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkNavy : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.darkNavy : Colors.grey[300]!,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.darkNavy,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    return months[month - 1];
  }

  Widget _buildReviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReviewItem('Alan Cartwright', 4.0, 'Ótimo atendimento, recomendo para quem procura uma boa barbearia.', 'https://i.pravatar.cc/150?img=11'),
        const SizedBox(height: 24),
        _buildReviewItem('Robert Gleichner', 5.0, 'O lugar não é muito longe e o resultado do corte foi muito bom.', 'https://i.pravatar.cc/150?img=12'),
        const SizedBox(height: 24),
        _buildReviewItem('Sergio Wilderman', 4.0, 'Preço bem acessível e o serviço é bom, estou muito satisfeito.', 'https://i.pravatar.cc/150?img=13'),
        const SizedBox(height: 24),
        _buildReviewItem('Miss Erik VonRueden', 5.0, 'O estilo de corte aqui acompanha as tendências, gostei bastante do serviço.', 'https://i.pravatar.cc/150?img=14'),
      ],
    );
  }

  Widget _buildReviewItem(String name, double rating, String review, String imageUrl) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < rating.floor() ? Icons.star : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    );
                  }),
                  const SizedBox(width: 6),
                  Text(
                    '(\${rating.toStringAsFixed(1)})',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                review,
                style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
