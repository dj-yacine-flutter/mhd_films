import 'package:flutter/material.dart';
import 'package:mhd_films/pages/movie.dart';
import 'package:mhd_films/widgets/routly.dart';

import 'anime.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xff000000),
      child: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          children: [
            ShaderMask(
              blendMode: BlendMode.srcOver,
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.center,
                  radius: 0.5,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.1, 1.0],
                ).createShader(bounds);
              },
              child: Image.asset(
                "assets/home-wallpaper.webp",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.none,
                height: constraint.maxHeight,
                width: constraint.maxWidth,
              ),
            ),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  MaterialButton(
                      padding: const EdgeInsets.all(24),
                      color: Colors.red.shade900,
                      highlightColor: Colors.red,
                      hoverColor: Colors.red.shade700,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        "Movies",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, Routly(route: const MovieSearch()));
                      }),
                  MaterialButton(
                    padding: const EdgeInsets.all(24),
                      color: Colors.blue.shade900,
                      highlightColor: Colors.blue,
                      hoverColor: Colors.blue.shade700,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        "Animes",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, Routly(route: const AnimeSearch()));
                      }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
