// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:weather_app/views/health/health_news.dart';
import 'package:weather_app/views/entertainement_page/entertainment.dart';
import 'package:weather_app/views/kerala_news/kerala_news.dart';
import 'package:weather_app/views/latest_news/latest_news.dart';
import 'package:weather_app/views/sports/sports_news.dart';

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
    fetchData('latest');
    super.initState();
  }

  List tapbarlist = [
    'Latest news',
    'Entertaiment',
    'Sports',
    "Health",
    "Kerala",
  ];

  // List tapbarpages = [
  //   LatestNewsBody(),
  //   EnetrtainmentNewsBody(),
  // ];

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          if (homeProvider.indexvalue == 0) {
            return fetchData("latest");
          }
          if (homeProvider.indexvalue == 1) {
            return fetchData("entertainment");
          }
          if (homeProvider.indexvalue == 2) {
            return fetchData('sports');
          }
          if (homeProvider.indexvalue == 3) {
            return fetchData('health');
          } else {
            return fetchData('kerala');
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
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
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
                                          if (homeProvider.indexvalue == 0) {
                                            fetchData("latest");
                                          }
                                          if (homeProvider.indexvalue == 1) {
                                            fetchData("entertainment");
                                            print(homeProvider.indexvalue);
                                          }
                                          if (homeProvider.indexvalue == 2) {
                                            fetchData('sports');
                                          }
                                          if (homeProvider.indexvalue == 3) {
                                            fetchData('health');
                                          }
                                          if (homeProvider.indexvalue == 4) {
                                            fetchData('kerala');
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: homeProvider.indexvalue ==
                                                      index
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(19)),
                                          child: Center(
                                            child: Text(
                                              tapbarlist[index],
                                              style: TextStyle(
                                                color:
                                                    homeProvider.indexvalue ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),

                      // main body
                      isLoad
                          ? Container(
                              width: double.infinity,
                              height: 500,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeProvider.indexvalue == 0
                              ? LatestNewsBody(
                                  model: model,
                                  fetchdata: () {
                                    fetchData("Latest");
                                  },
                                )
                              : homeProvider.indexvalue == 1
                                  ? EnetrtainmentNewsBody(
                                      fetchdata: () {
                                        fetchData("entertainment");
                                      },
                                      model: model,
                                    )
                                  : homeProvider.indexvalue == 2
                                      ? SportsNewspage(
                                          model: model,
                                          fetchdata: () {
                                            fetchData("sports");
                                          })
                                      : homeProvider.indexvalue == 3
                                          ? HealthNewsBody(
                                              model: model,
                                              fetchdata: () {
                                                fetchData('esports');
                                              })
                                          : KeralaNewsBody(
                                              model: model,
                                              fetchdata: () {
                                                fetchData('kerala');
                                              })
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
