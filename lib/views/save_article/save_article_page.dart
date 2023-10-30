import 'package:flutter/material.dart';
import 'package:weather_app/controller/news_controller.dart';

class SaveAritclePage extends StatelessWidget {
  const SaveAritclePage(
      {super.key,
      required this.index,
      required this.title,
      required this.sourse,
      required this.description,
      // required this.image,
      required this.content});
  final String title;
  final String sourse;
  final String description;
  // final String image;
  final String content;
  final int index;

  @override
  Widget build(BuildContext context) {
    // var saveProvider = Provider.of<SaveProvider>(context);
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
                          sourse,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 68, 66, 66),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    width: 374,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        //image
                        image: NetworkImage("image"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
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
}
