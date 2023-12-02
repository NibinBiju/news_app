// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/homepage_controller/homepage_provider.dart';
import 'package:weather_app/controller/utils/constant_utils.dart';
import 'package:weather_app/views/explained_page/explain_page.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  @override
  void initState() {
    Provider.of<HomePageProvider>(context, listen: false).fetchData('latest');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homeprovider = Provider.of<HomePageProvider>(context);

    return Scaffold(
      body: homeprovider.isLoad
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: homeprovider.model?.articles?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (cnt) {
                      return DetailsPage(
                          model: homeprovider.model, index: index);
                    }));
                  },
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: Lottie.asset(loadingAnimation),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.crisis_alert,
                            size: 56,
                          ),
                          imageUrl:
                              homeprovider.model?.articles?[index].urlToImage ??
                                  '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Breaking news',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                homeprovider.model?.articles?[index].title ??
                                    '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(7),
                                  child: Text(
                                    homeprovider.model?.articles?[index].source
                                            ?.name ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
