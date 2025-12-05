import 'package:flutter/material.dart';
import 'dart:math';

/// فاصل بشكل خط مرسوم يدوياً لإضافة لمسة بشرية إلى التصميم.
class HandDrawnDivider extends StatelessWidget {
  const HandDrawnDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DoodlePainter(),
      child: const SizedBox(width: double.infinity, height: 40),
    );
  }
}

class _DoodlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    final double amplitude = 8;
    final double centerY = size.height / 2;
    for (double x = 0; x <= size.width; x += 1) {
      final double y = centerY + sin((x / size.width) * pi * 4) * amplitude;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
