import 'package:flutter/material.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'title': 'متجر أزياء', 'icon': 'store'},
      {'title': 'عيادة', 'icon': 'medical'},
      {'title': 'مطعم', 'icon': 'restaurant'},
    ];
    IconData resolveIcon(String icon) {
      switch (icon) {
        case 'store':
          return Icons.store_rounded;
        case 'medical':
          return Icons.medical_services_rounded;
        case 'restaurant':
          return Icons.restaurant_rounded;
        default:
          return Icons.auto_awesome;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('معرض مختصر',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items.map((item) {
              final icon = resolveIcon(item['icon']!);
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  width: 220,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5D7FA0), Color(0xFF7FB3C8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5D7FA0).withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: Colors.white, size: 48),
                      const SizedBox(height: 8),
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
