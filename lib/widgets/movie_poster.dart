import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mhd_films/widgets/poster.dart';

import '../models/movie.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white,
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade700,
            spreadRadius: 1.5,
            blurRadius: 4.5,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: Colors.red.shade700,
            spreadRadius: 1.5,
            blurRadius: 3.5,
            blurStyle: BlurStyle.outer,
          ),
          BoxShadow(
            color: Colors.red.shade700,
            spreadRadius: 1.5,
            blurRadius: 4.5,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: Colors.red.shade700,
            spreadRadius: 1.5,
            blurRadius: 3.5,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: GridTile(
          header: movie.version.isNotEmpty
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
                            child: Text(movie.version),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          footer: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                movie.title,
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
            child: movie.img.isNotEmpty
                ? Image.network(
                    movie.img,
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
    );
  }
}
