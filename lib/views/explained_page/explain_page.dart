// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/controller/db_controller/news_controller.dart';
import 'package:weather_app/controller/savepage_controller/save_provider.dart';
import 'package:weather_app/model/database_model.dart';
import 'package:weather_app/model/news_api_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.model, required this.index});
  final NewsModel? model;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // Uri _url = Uri.parse('https://flutter.dev');

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
                          widget.model?.articles?[widget.index].source?.name ??
                              "",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      NewsDbController.savedArticles.any((element) =>
                              element.title ==
                              widget.model?.articles?[widget.index].title)
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
                                      image: widget
                                              .model
                                              ?.articles?[widget.index]
                                              .urlToImage ??
                                          "",
                                      title: widget.model
                                              ?.articles?[widget.index].title ??
                                          "",
                                      source: widget
                                              .model
                                              ?.articles?[widget.index]
                                              .source
                                              ?.name ??
                                          "",
                                      url: widget
                                              .model
                                              ?.articles?[widget.index]
                                              .url ??
                                          "",
                                      content: widget
                                              .model
                                              ?.articles?[widget.index]
                                              .content ??
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
                        widget.model?.articles?[widget.index].title ?? "",
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
                      widget.model?.articles?[widget.index].description ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 68, 66, 66),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 374,
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.model?.articles?[widget.index].urlToImage ??
                                '',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.model?.articles?[widget.index].content ?? "",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                          child: const Text(
                            '....Read more',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            // bottomNaviProvider.launchUri(_url);
                            _launchUrl(Uri.parse(
                                widget.model?.articles?[widget.index].url ??
                                    ''));
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
