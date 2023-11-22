import 'package:flutter/material.dart';
import 'package:weather_app/model/news_api_model.dart';

class LatestContainerSlider extends StatelessWidget {
  const LatestContainerSlider(
      {super.key, required this.model, required this.index});

  final NewsModel? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.only(top: 90, left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          image: DecorationImage(
              image: NetworkImage(model?.articles?[index].urlToImage ??
                  "https://img.freepik.com/premium-vector/news-pattern-consisting-microphone-tv-radio-newspaper-phone-speaker-planet_505620-315.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  model?.articles?[index].source?.name ?? "N/a",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 130,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 240,
                  height: 130,
                  child: Text(
                    model?.articles?[index].title ?? "N/a",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 130,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  model?.articles?[index].author ?? "N/a",
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 130,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
