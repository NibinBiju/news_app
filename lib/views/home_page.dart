// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/hive_controller.dart';
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
  // final DbHive _dbHive = DbHive();

  @override
  void initState() {
    Provider.of<HomePageProvider>(context, listen: false).fetchData(tapbarlist[
        Provider.of<HomePageProvider>(context, listen: false).indexvalue]);
    // _dbHive.getData();
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

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
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
                            return const Searchpage();
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
                child: Scrollbar(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
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
                                            homeProvider.fetchData(tapbarlist[
                                                homeProvider.indexvalue]);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            clipBehavior: Clip.antiAlias,
                                            child: Container(
                                              padding: const EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                color:
                                                    homeProvider.indexvalue ==
                                                            index
                                                        ? Colors.black
                                                        : Colors.grey.shade300,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  tapbarlist[index],
                                                  style: TextStyle(
                                                    color: homeProvider
                                                                .indexvalue ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
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
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : NewsMainBody(
                                model: homeProvider.model,
                                fetchdata: () {
                                  homeProvider.fetchData("Latest");
                                },
                                title: tapbarlist[homeProvider.indexvalue],
                              )
                      ],
                    ),
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
