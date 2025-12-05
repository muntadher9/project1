import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: const [
          Text('Reports'),
          SizedBox(height: 12),
          Text('- Stock on hand per warehouse'),
          Text('- Movement history'),
          Text('- Sales margin and slow movers'),
          Text('- Export to CSV/PDF (TODO)'),
        ],
      ),
    );
  }
}
