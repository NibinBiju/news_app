import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/db_controller/news_controller.dart';
import 'package:weather_app/controller/savepage_controller/save_provider.dart';
import 'package:weather_app/model/database_model.dart';
import 'package:weather_app/model/news_api_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.model, required this.index});
  final NewsModel? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    var saveProvider = Provider.of<SaveProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //appbar
          SliverAppBar(
            backgroundColor: Colors.grey.shade300,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 100,
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
                      NewsDbController.savedArticles.any((element) =>
                              element.title == model?.articles?[index].title)
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark,
                                size: 33,
                              ))
                          : IconButton(
                              onPressed: () {
                                saveProvider.addToSave(
                                  DatabaseModel(
                                      image:
                                          model?.articles?[index].urlToImage ??
                                              "",
                                      title:
                                          model?.articles?[index].title ?? "",
                                      source: model
                                              ?.articles?[index].source?.name ??
                                          "",
                                      // author:
                                      //     model?.articles?[index].author ?? "",
                                      decription:
                                          model?.articles?[index].description ??
                                              "",
                                      content:
                                          model?.articles?[index].content ??
                                              ""),
                                );
                              },
                              icon: const Icon(
                                Icons.bookmark_border,
                                size: 33,
                              ))
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
