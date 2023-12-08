import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/controller/savepage_controller/save_provider.dart';

class SaveAritclePage extends StatelessWidget {
  const SaveAritclePage(
      {super.key,
      required this.index,
      required this.title,
      required this.sourse,
      required this.url,
      required this.image,
      required this.content});
  final String title;
  final String sourse;
  final String url;
  final String image;
  final String content;
  final int index;

  @override
  Widget build(BuildContext context) {
    var saveProvider = Provider.of<SaveProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //appbar
          const SliverAppBar(
            backgroundColor: Colors.grey,
            title: Text(
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
                          sourse,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            saveProvider.remove(index);
                          },
                          icon: const Icon(
                            Icons.bookmark,
                            size: 33,
                          ))
                    ],
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 374,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          content,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
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
                                _launchUrl(Uri.parse(url));
                              }),
                        )
                      ],
                    ),
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
