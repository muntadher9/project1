import 'package:flutter/material.dart';

class ClientsSection extends StatelessWidget {
  const ClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> clients = [
      'Startup One',
      'Clinic Care',
      'Cafe & Co',
      'ShopLine',
      'Agency Plus',
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _statCard(context, '20+', 'مشروع'),
        _statCard(context, '10+', 'عملاء'),
        _statCard(context, '5+', 'متاجر إلكترونية'),
        ...clients.map(
          (c) => Chip(
            label: Text(
              c,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            avatar: const Icon(Icons.check_circle, size: 18),
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withValues(
                      alpha: 0.2,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard(BuildContext context, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
