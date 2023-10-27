import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/bottomnavi_controller.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/controller/provider_controller/save_provider.dart';
import 'package:weather_app/controller/provider_controller/search_page.dart';
import 'package:weather_app/views/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavi(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchPageNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaveProvider(),
        )
      ],
      child: MaterialApp(
          title: "News App",
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          debugShowCheckedModeBanner: false,
          home: BottomNavigationPage()),
    );
  }
}
