import 'package:flutter/material.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:weather_app/views/widgets/news_tile.dart';

class Searchpage extends StatelessWidget {
  Searchpage({super.key, this.model, required this.index});

  final NewsModel? model;
  final int index;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        hintText: "Search",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search_rounded,
                            size: 29,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: List.generate(
                  model?.articles?.length ?? 0,
                  (index) {
                    return NewsTile(
                      model: model,
                      index: index,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
