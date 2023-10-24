import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/views/home_page.dart';
import 'package:weather_app/views/save_article/save_article.dart';

class BottomNavigationPage extends StatelessWidget {
  BottomNavigationPage({super.key});

  final List mypages = [
    const Homepage(),
    const SaveArticle(),
  ];

  @override
  Widget build(BuildContext context) {
    var homeprovider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      body: mypages[homeprovider.bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        selectedItemColor: Colors.black,
        currentIndex: homeprovider.bottomIndex,
        onTap: (value) {
          homeprovider.bottomnaviIndex(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ""),
        ],
      ),
    );
  }
}
