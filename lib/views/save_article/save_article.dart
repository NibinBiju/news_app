import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/hive_controller.dart';
import 'package:weather_app/controller/news_controller.dart';
import 'package:weather_app/controller/provider_controller/save_provider.dart';
import 'package:weather_app/views/save_article/save_article_page.dart';

class SaveArticle extends StatefulWidget {
  const SaveArticle({super.key});

  @override
  State<SaveArticle> createState() => _SaveArticleState();
}

class _SaveArticleState extends State<SaveArticle> {
  final DbHive _dbHive = DbHive();
  final box = Hive.box("NewsDb");
  @override
  void initState() {
    if (box.isEmpty) {
      _dbHive.initialData();
    } else {
      _dbHive.getData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var saveProvider = Provider.of<SaveProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            backgroundColor: Colors.transparent,
            title: Text(
              "Saved",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            NewsDbController.savedArticles.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SaveAritclePage(
                                        index: index,
                                        title: NewsDbController
                                                .savedArticles[index].title ??
                                            "",
                                        sourse: NewsDbController
                                                .savedArticles[index].source ??
                                            "",
                                        description: NewsDbController
                                                .savedArticles[index]
                                                .decription ??
                                            "",
                                        image: NewsDbController
                                                .savedArticles[index].image ??
                                            "",
                                        content: NewsDbController
                                                .savedArticles[index].content ??
                                            "");
                                  }));
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 170,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: 140,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  NewsDbController
                                                          .savedArticles[index]
                                                          .image ??
                                                      ""),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              NewsDbController
                                                      .savedArticles[index]
                                                      .source ??
                                                  "",
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 143, 140, 140),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 230,
                                            height: 80,
                                            padding: const EdgeInsets.all(6),
                                            child: Text(
                                              NewsDbController
                                                      .savedArticles[index]
                                                      .title ??
                                                  "",
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
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  NewsDbController
                                                          .savedArticles[index]
                                                          .author ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  saveProvider.remove(index);
                                                },
                                                child:
                                                    const Icon(Icons.bookmark),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
