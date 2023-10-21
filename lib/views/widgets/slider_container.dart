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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(top: 90, left: 5),
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          image: DecorationImage(
              image: NetworkImage(model?.articles?[index].urlToImage ?? ""),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  model?.articles?[index].source?.name ?? "N/a",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 240,
                  height: 140,
                  child: Text(
                    model?.articles?[index].title ?? "N/a",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  model?.articles?[index].author ?? "N/a",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
