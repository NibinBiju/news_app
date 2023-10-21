// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/views/widgets/slider_container.dart';

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
  Future<void> fetchData(String newsSerch) async {
    // setState(() {
    //   isLoad = true;
    // });
    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=$newsSerch&apiKey=b719771d665245c9b1dc922eb15e9b65');

    var response = await http.get(uri);
    print(response.statusCode);
    print(response.body);

    jsonData = jsonDecode(response.body);

    model = NewsModel.fromJson(jsonData);
    // setState(() {
    //   isLoad = false;
    // });
  }

  @override
  void initState() {
    fetchData('india');
    super.initState();
  }

  List tapbarlist = [
    'Latest news',
    'Entertaiment',
    'Sports',
    "E Sports",
    "Kerala",
  ];

  List tapbarpages = [
    Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Homepage"),
      ),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Entertainment"),
      ),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Sports"),
      ),
    )
  ];

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
                return fetchData("latest");
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
                            homeProvider.indexvalue == 0
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Latest News",
                                            style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),

                                          //see all
                                          CupertinoButton(
                                              child: Row(
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
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          fetchData("exclusive");
                                          //carosal conatiners
                                          return LatestContainerSlider(
                                            model: model,
                                            index: index + 8,
                                          );
                                        },
                                        options:
                                            CarouselOptions(aspectRatio: 5 / 4),
                                      ),
                                      Column(
                                        //news as list
                                        children: List.generate(
                                          model?.articles?.length ?? 0,
                                          (index) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    model?.articles?[index]
                                                            .title ??
                                                        "N/a",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    model?.articles?[index]
                                                            .description ??
                                                        "N/a",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  trailing: Container(
                                                    width: 120,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(model
                                                                ?.articles?[
                                                                    index]
                                                                .urlToImage ??
                                                            ""),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 8,
                                                  thickness: 2,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    width: 300,
                                    height: 300,
                                    color: Colors.amber,
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
}
