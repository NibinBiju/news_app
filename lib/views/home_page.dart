// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/views/news_main_body/news_main_body.dart';
import 'package:weather_app/views/search_page/search_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String nvalue = '';

  @override
  void initState() {
    Provider.of<HomePageProvider>(context, listen: false)
        .fetchData(tapbarlist[0]);
    super.initState();
  }

  List<String> tapbarlist = [
    "All",
    'Latest news',
    'Entertaiment',
    'Sports',
    "Health",
    "Kerala",
    "Trending",
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
          // if (homeProvider.indexvalue == 0) {
          //   return homeProvider.fetchData("trending");
          // }
          // if (homeProvider.indexvalue == 1) {
          //   return homeProvider.fetchData("entertainment");
          // }
          // if (homeProvider.indexvalue == 2) {
          //   return homeProvider.fetchData('sports');
          // }
          // if (homeProvider.indexvalue == 3) {
          //   return homeProvider.fetchData('health');
          // } else {
          //   return homeProvider.fetchData('kerala');
          // }
          return homeProvider.fetchData(tapbarlist[homeProvider.indexvalue]);
        },
        child: CustomScrollView(
          slivers: [
            //appbar
            SliverAppBar.medium(
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 32,
              ),
              stretch: true,
              centerTitle: true,
              backgroundColor: Colors.grey.shade100,
              elevation: 0,
              title: const Text("News"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Searchpage();
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),

            //body
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // textfield for search
                      // TextField(
                      //   style: const TextStyle(
                      //     fontSize: 23,
                      //   ),
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(18),
                      //     ),
                      //     hintText: "Search",
                      //     suffixIcon: IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(
                      //         Icons.search_rounded,
                      //         size: 29,
                      //       ),
                      //     ),
                      //   ),
                      // ),

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
                                          // if (homeProvider.indexvalue == 0) {
                                          //   homeProvider.fetchData("latest");
                                          // }
                                          // if (homeProvider.indexvalue == 1) {
                                          //   homeProvider
                                          //       .fetchData("entertainment");
                                          //   print(homeProvider.indexvalue);
                                          // }
                                          // if (homeProvider.indexvalue == 2) {
                                          //   homeProvider.fetchData('sports');
                                          // }
                                          // if (homeProvider.indexvalue == 3) {
                                          //   homeProvider
                                          //       .fetchData('health&fitness');
                                          // }
                                          // if (homeProvider.indexvalue == 4) {
                                          //   homeProvider.fetchData('kerala');
                                          // }
                                          homeProvider.fetchData(tapbarlist[
                                              homeProvider.indexvalue]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: homeProvider.indexvalue ==
                                                      index
                                                  ? Colors.black
                                                  : Colors.grey.shade300,
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
                      homeProvider.isLoad
                          ? const SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : NewsMainBody(
                              model: homeProvider.model,
                              fetchdata: () {
                                homeProvider.fetchData("Latest");
                              },
                              title: tapbarlist[homeProvider.indexvalue],
                            )
                      // : homeProvider.indexvalue == 1
                      //     ? EnetrtainmentNewsBody(
                      //         fetchdata: () {
                      //           homeProvider.fetchData("entertainment");
                      //         },
                      //         model: homeProvider.model,
                      //       )
                      //     : homeProvider.indexvalue == 2
                      //         ? SportsNewspage(
                      //             model: homeProvider.model,
                      //             fetchdata: () {
                      //               homeProvider.fetchData("sports");
                      //             })
                      //         : homeProvider.indexvalue == 3
                      //             ? HealthNewsBody(
                      //                 model: homeProvider.model,
                      //                 fetchdata: () {
                      //                   homeProvider
                      //                       .fetchData('esports');
                      //                 })
                      //             : KeralaNewsBody(
                      //                 model: homeProvider.model,
                      //                 fetchdata: () {
                      //                   homeProvider
                      //                       .fetchData('kerala');
                      //                 })
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
