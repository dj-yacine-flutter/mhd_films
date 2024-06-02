import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mhd_films/widgets/poster.dart';

import '../models/anime.dart';

class AnimePoster extends StatelessWidget {
  final Anime anime;
  const AnimePoster({super.key, required this.anime});

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
            color: Colors.blue.shade700,
            spreadRadius: 1.5,
            blurRadius: 4.5,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: Colors.blue.shade700,
            spreadRadius: 1.5,
            blurRadius: 3.5,
            blurStyle: BlurStyle.outer,
          ),
          BoxShadow(
            color: Colors.blue.shade700,
            spreadRadius: 1.5,
            blurRadius: 4.5,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: Colors.blue.shade700,
            spreadRadius: 1.5,
            blurRadius: 3.5,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 225,
              height: 350,
              child: ColoredBox(
                color: Colors.black,
                child: anime.img.isNotEmpty
                    ? Image.network(
                        anime.img,
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
            const VerticalDivider(width: 5, thickness: 3, color: Colors.white),
            SizedBox(
              width: 225,
              height: 350,
              child: ColoredBox(
                color: Colors.black.withOpacity(0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox.square(dimension: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Title",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        const SizedBox.square(dimension: 10),
                        Expanded(
                          child: AutoSizeText(
                            anime.title,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox.square(dimension: 10),
                      ],
                    ),
                    const SizedBox.square(dimension: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Version",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        const SizedBox.square(dimension: 10),
                        Expanded(
                          child: AutoSizeText(
                            anime.version,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox.square(dimension: 10),
                      ],
                    ),
                    const SizedBox.square(dimension: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Year",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        const SizedBox.square(dimension: 10),
                        Expanded(
                          child: AutoSizeText(
                            anime.year,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox.square(dimension: 10),
                      ],
                    ),
                    const SizedBox.square(dimension: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Season",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        const SizedBox.square(dimension: 10),
                        Expanded(
                          child: AutoSizeText(
                            anime.season,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox.square(dimension: 10),
                      ],
                    ),
                    const SizedBox.square(dimension: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Episodes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        const SizedBox.square(dimension: 10),
                        Expanded(
                          child: AutoSizeText(
                            anime.episodes,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox.square(dimension: 10),
                      ],
                    ),
                    const SizedBox.square(dimension: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
