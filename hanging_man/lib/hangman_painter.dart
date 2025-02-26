import 'package:flutter/material.dart';

class HangmanDrawing extends StatelessWidget {
  final int failedAttempts;

  const HangmanDrawing({super.key, required this.failedAttempts});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 300), 
      painter: _HangmanPainter(failedAttempts: failedAttempts),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  final int failedAttempts;

  _HangmanPainter({required this.failedAttempts});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.9),
      Offset(size.width * 0.8, size.height * 0.9),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.5, size.height * 0.9),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.1),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.8, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.2),
      paint,
    );

    if (failedAttempts >= 1) {
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.3),
        20.0,
        paint,
      );
    }

    if (failedAttempts >= 2) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.32),
        Offset(size.width * 0.8, size.height * 0.5),
        paint,
      );
    }

    if (failedAttempts >= 3) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.35),
        Offset(size.width * 0.7, size.height * 0.45),
        paint,
      );
    }

    if (failedAttempts >= 4) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.35),
        Offset(size.width * 0.9, size.height * 0.45),
        paint,
      );
    }

    if (failedAttempts >= 5) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.5),
        Offset(size.width * 0.7, size.height * 0.65),
        paint,
      );
    }

    if (failedAttempts >= 6) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.5),
        Offset(size.width * 0.9, size.height * 0.65),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
