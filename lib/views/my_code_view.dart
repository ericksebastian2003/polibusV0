import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const QrCodeWidget({
    Key? key,
    required this.data,
    this.size = 200.0,
    this.backgroundColor,
    this.foregroundColor,
  })  : assert(size >= 100.0 && size <= 500.0, 'El tamaño debe ser entre 100 y 500'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: QrPainter(
        data: data,
        version: QrVersions.auto,
        color: foregroundColor ?? Colors.black,
        gapless: false,
      ),
    );
  }
}
