// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:weather_app/views/widgets/entertainement_page/entertainment.dart';
import 'package:weather_app/views/widgets/latest_news/latest_news.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var jsonData;
  String nvalue = '';
  NewsModel? model;
  bool isLoad = false;

  @override
  void initState() {
    fetchData('us');
    super.initState();
  }

  List tapbarlist = [
    'Latest news',
    'Entertaiment',
    'Sports',
    "E Sports",
    "Kerala",
  ];

  // List tapbarpages = [
  //   LatestNewsBody(model: model, fetchdata: () => fetchData("Latest")),
  // ];

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      body: isLoad
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                if (homeProvider.indexvalue == 0) {
                  return fetchData("latest");
                } else {
                  return fetchData("entertainment");
                }
              },
              child: CustomScrollView(
                slivers: [
                  //appbar
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text("News"),
                    actions: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.notifications))
                    ],
                  ),

                  //body
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //text field
                            TextField(
                              style: TextStyle(
                                fontSize: 23,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                hintText: "Search",
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search_rounded,
                                    size: 29,
                                  ),
                                ),
                              ),
                            ),

                            //tap bar
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                      tapbarlist.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                homeProvider.appbarIndex(
                                                    index: index);
                                                if (homeProvider.indexvalue ==
                                                    0) {
                                                  fetchData("latest");
                                                } else {
                                                  fetchData("entertainment");
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: homeProvider
                                                                .indexvalue ==
                                                            index
                                                        ? Colors.black
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19)),
                                                child: Center(
                                                  child: Text(
                                                    tapbarlist[index],
                                                    style: TextStyle(
                                                      color: homeProvider
                                                                  .indexvalue ==
                                                              index
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))),
                            ),

                            //main body
                            homeProvider.indexvalue == 0
                                ? LatestNewsBody(
                                    model: model,
                                    fetchdata: () {
                                      fetchData("Latest");
                                    },
                                  )
                                : EnetrtainmentNewsBody(
                                    fetchdata: () {
                                      fetchData("entertainment");
                                    },
                                    model: model,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> fetchData(String newsSerch) async {
    setState(() {
      isLoad = true;
    });
    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=$newsSerch&apiKey=b719771d665245c9b1dc922eb15e9b65');

    var response = await http.get(uri);
    print(response.statusCode);
    print(response.body);

    jsonData = jsonDecode(response.body);

    model = NewsModel.fromJson(jsonData);
    setState(() {
      isLoad = false;
    });
  }
}
