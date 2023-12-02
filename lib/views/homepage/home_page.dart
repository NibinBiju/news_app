// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/homepage_controller/homepage_provider.dart';
import 'package:weather_app/controller/utils/constant_utils.dart';
import 'package:weather_app/views/about_us/about_us.dart';
import 'package:weather_app/views/homepage/widgets/shimmer_widget/shimmer_containers.dart';
import 'package:weather_app/views/news_main_body/news_main_body.dart';
import 'package:weather_app/views/privacy_page/privacy_page.dart';
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
    Provider.of<HomePageProvider>(context, listen: false).fetchData(tapbarlist[
        Provider.of<HomePageProvider>(context, listen: false).indexvalue]);

    super.initState();
  }

  List<String> tapbarlist = [
    "All",
    'Latest news',
    'Entertaiment',
    'Sports',
    "Health",
    "Trending",
  ];

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(13),
              decoration: const BoxDecoration(
                color: Color.fromARGB(160, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: const DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AboutUsPage();
                }));
              },
              title: const Text(
                'About us',
                style: TextStyle(
                  color: Color.fromARGB(255, 100, 100, 100),
                  fontSize: 24,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more,
                  color: Color.fromARGB(255, 100, 100, 100),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PrivacyDetailsPage();
                }));
              },
              title: const Text(
                "Privacy Policy",
                style: TextStyle(
                  color: Color.fromARGB(255, 100, 100, 100),
                  fontSize: 24,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Color.fromARGB(255, 100, 100, 100),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return homeProvider.fetchData(tapbarlist[homeProvider.indexvalue]);
        },
        child: CustomScrollView(
          slivers: [
            //appbar

            SliverAppBar.medium(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      size: 32,
                      color: Colors.grey.shade800,
                    ),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 32,
              ),
              stretch: true,
              centerTitle: true,
              backgroundColor: newsAppbarColor,
              elevation: 0,
              title: const Text("News Express"),
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
                                            homeProvider.fetchData(
                                              tapbarlist[
                                                  homeProvider.indexvalue],
                                            );
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
                                child: Center(
                                  child: ShimmerWidget(),
                                ),
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
