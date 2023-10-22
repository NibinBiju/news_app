import 'package:flutter/material.dart';
import 'package:weather_app/model/news_api_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.model, required this.index});
  final NewsModel? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //appbar
          SliverAppBar(
            backgroundColor: Colors.grey.shade400,
            title: const Text(
              'Article',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),

          //main body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: const Color.fromARGB(255, 72, 27, 80),
                        child: Text(
                          model?.articles?[index].source?.name ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model?.articles?[index].title ?? "",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model?.articles?[index].description ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 68, 66, 66),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    width: 374,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        image: NetworkImage(
                            model?.articles?[index].urlToImage ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model?.articles?[index].content ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
