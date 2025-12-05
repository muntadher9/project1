import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final int year = DateTime.now().year;
    return Center(
      child: Text(
        '© $year Montather Saleh — تطوير واجهات وتجارب رقمية',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
