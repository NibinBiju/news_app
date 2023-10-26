import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:weather_app/views/explained_page/explain_page.dart';
import 'package:weather_app/views/widgets/news_tile.dart';
import 'package:weather_app/views/widgets/slider_container.dart';

class NewsMainBody extends StatelessWidget {
  const NewsMainBody(
      {super.key,
      required this.model,
      required this.fetchdata,
      required this.title});

  final NewsModel? model;
  final VoidCallback fetchdata;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
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
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  onPressed: () {})
            ],
          ),
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
                    return DetailsPage(model: model, index: index);
                  },
                ));
              },
              child: LatestContainerSlider(
                model: model,
                index: index,
              ),
            );
          },
          options: CarouselOptions(
            aspectRatio: 5 / 4,
            animateToClosest: true,
            // autoPlay: true,
            enlargeCenterPage: true,
          ),
        ),
        Column(
          //news as list
          children: List.generate(
            model?.articles?.length ?? 0,
            (index) {
              return NewsTile(
                model: model,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
