import 'package:flutter/material.dart';

class PosterSVG extends CustomPainter {
  final BuildContext context;
  const PosterSVG(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8125000, size.height * 0.3333333);
    path_0.lineTo(size.width * 0.8125000, size.height * 0.8541667);
    path_0.cubicTo(
        size.width * 0.8125000,
        size.height * 0.8771875,
        size.width * 0.7938542,
        size.height * 0.8958333,
        size.width * 0.7708333,
        size.height * 0.8958333);
    path_0.lineTo(size.width * 0.2291667, size.height * 0.8958333);
    path_0.cubicTo(
        size.width * 0.2061458,
        size.height * 0.8958333,
        size.width * 0.1875000,
        size.height * 0.8771875,
        size.width * 0.1875000,
        size.height * 0.8541667);
    path_0.lineTo(size.width * 0.1875000, size.height * 0.1458333);
    path_0.cubicTo(
        size.width * 0.1875000,
        size.height * 0.1228125,
        size.width * 0.2061458,
        size.height * 0.1041667,
        size.width * 0.2291667,
        size.height * 0.1041667);
    path_0.lineTo(size.width * 0.5833333, size.height * 0.1041667);
    path_0.lineTo(size.width * 0.8125000, size.height * 0.3333333);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Theme.of(context).colorScheme.primary.withOpacity(0.5);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5833333, size.height * 0.1041667);
    path_1.lineTo(size.width * 0.5833333, size.height * 0.2916667);
    path_1.cubicTo(
        size.width * 0.5833333,
        size.height * 0.3146875,
        size.width * 0.6019792,
        size.height * 0.3333333,
        size.width * 0.6250000,
        size.height * 0.3333333);
    path_1.lineTo(size.width * 0.8125000, size.height * 0.3333333);
    path_1.lineTo(size.width * 0.5833333, size.height * 0.1041667);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Theme.of(context).colorScheme.onPrimary;
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.7083333, size.height * 0.7083333);
    path_2.lineTo(size.width * 0.5946250, size.height * 0.5946250);
    path_2.cubicTo(
        size.width * 0.5806042,
        size.height * 0.5806042,
        size.width * 0.5580000,
        size.height * 0.5803125,
        size.width * 0.5436042,
        size.height * 0.5939375);
    path_2.lineTo(size.width * 0.4305625, size.height * 0.7010417);
    path_2.lineTo(size.width * 0.4305625, size.height * 0.7500000);
    path_2.lineTo(size.width * 0.6875000, size.height * 0.7500000);
    path_2.cubicTo(
        size.width * 0.6990000,
        size.height * 0.7500000,
        size.width * 0.7083333,
        size.height * 0.7406667,
        size.width * 0.7083333,
        size.height * 0.7291667);
    path_2.lineTo(size.width * 0.7083333, size.height * 0.7083333);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = Theme.of(context).colorScheme.onPrimary;
    canvas.drawPath(path_2, paint2Fill);

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = Theme.of(context).colorScheme.primary;
    canvas.drawCircle(Offset(size.width * 0.6458333, size.height * 0.5000000),
        size.width * 0.04166667, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.6574167, size.height * 0.7500000);
    path_4.lineTo(size.width * 0.4647500, size.height * 0.5573333);
    path_4.cubicTo(
        size.width * 0.4457292,
        size.height * 0.5383125,
        size.width * 0.4150000,
        size.height * 0.5378958,
        size.width * 0.3954792,
        size.height * 0.5563958);
    path_4.lineTo(size.width * 0.2916667, size.height * 0.6547292);
    path_4.lineTo(size.width * 0.2916667, size.height * 0.7083333);
    path_4.cubicTo(
        size.width * 0.2916667,
        size.height * 0.7313542,
        size.width * 0.3103125,
        size.height * 0.7500000,
        size.width * 0.3333333,
        size.height * 0.7500000);
    path_4.lineTo(size.width * 0.6574167, size.height * 0.7500000);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = Theme.of(context).colorScheme.onPrimary;
    canvas.drawPath(path_4, paint4Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
