import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/controller/provider_controller/save_provider.dart';
import 'package:weather_app/model/database_model.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:weather_app/views/explained_page/explain_page.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.model,
    required this.index,
  });

  final NewsModel? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    var saveprovider = Provider.of<SaveProvider>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailsPage(
                model: model,
                index: index,
              );
            }));
          },
          child: SizedBox(
            width: double.infinity,
            height: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            model?.articles?[index].urlToImage ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        model?.articles?[index].source?.name ?? "",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 143, 140, 140),
                        ),
                      ),
                    ),
                    Container(
                      width: 230,
                      height: 80,
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        model?.articles?[index].title ?? "",
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            model?.articles?[index].author ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        NewsDbController.savedArticles.any((element) =>
                                element.title == model?.articles?[index].title)
                            ? const Icon(
                                Icons.bookmark,
                                size: 24,
                              )
                            : InkWell(
                                onTap: () {
                                  saveprovider.addToSave(
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
                                          model?.articles?[index].content ?? "",
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.bookmark_border_rounded,
                                  size: 24,
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 8,
          thickness: 2,
          endIndent: 20,
          indent: 20,
        ),
      ],
    );
  }
}
