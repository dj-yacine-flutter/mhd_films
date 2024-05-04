import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class Poster extends StatefulWidget {
  final Movie data;
  final Function()? callback;
  const Poster({super.key, required this.data, this.callback});

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        focusColor: Theme.of(context).colorScheme.onBackground,
        onTap: widget.callback,
        child: Container(
          margin: const EdgeInsetsDirectional.all(5.5),
          padding: const EdgeInsetsDirectional.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 1.5,
                blurRadius: 4.5,
                blurStyle: BlurStyle.inner,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 1.5,
                blurRadius: 3.5,
                blurStyle: BlurStyle.outer,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 1.5,
                blurRadius: 4.5,
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: GridTile(
              header: widget.data.version.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(widget.data.version),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
              footer: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Center(
                  child: AutoSizeText(
                    widget.data.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    minFontSize: 9,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              child: ColoredBox(
                color: Theme.of(context).splashColor,
                child: widget.data.img.isNotEmpty
                    ? Image.network(
                        widget.data.img,
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.fill,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.error_outlined,
                            color: Colors.red,
                          );
                        },
                      )
                    : FractionallySizedBox(
                        widthFactor: 0.8,
                        heightFactor: 0.55,
                        child: CustomPaint(
                          painter: PosterSVG(context),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
