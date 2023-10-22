import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:weather_app/views/explained_page/explain_page.dart';
import 'package:weather_app/views/widgets/slider_container.dart';

class LatestNewsBody extends StatelessWidget {
  const LatestNewsBody(
      {super.key, required this.model, required this.fetchdata});

  final NewsModel? model;
  final VoidCallback fetchdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Latest News",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            //see all
            CupertinoButton(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("See All"),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                onPressed: () {})
          ],
        ),
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            fetchdata;
            //carosal conatiners
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DetailsPage(model: model, index: index + 8);
                  },
                ));
              },
              child: LatestContainerSlider(
                model: model,
                index: index + 8,
              ),
            );
          },
          options: CarouselOptions(aspectRatio: 5 / 4),
        ),
        Column(
          //news as list
          children: List.generate(
            model?.articles?.length ?? 0,
            (index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsPage(
                          model: model,
                          index: index,
                        );
                      }));
                    },
                    child: ListTile(
                      title: Text(
                        model?.articles?[index].title ?? "N/a",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        model?.articles?[index].description ?? "N/a",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      trailing: Container(
                        width: 120,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                model?.articles?[index].urlToImage ?? ""),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 8,
                    thickness: 2,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
