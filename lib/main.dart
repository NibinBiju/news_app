// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider_controller/bottomnavi_controller.dart';
import 'package:weather_app/controller/provider_controller/homepage_provider.dart';
import 'package:weather_app/controller/provider_controller/save_provider.dart';
import 'package:weather_app/controller/provider_controller/search_page.dart';
import 'package:weather_app/model/database_model.dart';
import 'package:weather_app/views/bottom_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageProvider>(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider<BottomNavi>(
          create: (context) => BottomNavi(),
        ),
        ChangeNotifierProvider<SearchPageNotifier>(
          create: (context) => SearchPageNotifier(),
        ),
        ChangeNotifierProvider<SaveProvider>(
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
