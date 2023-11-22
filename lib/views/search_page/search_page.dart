import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/savepage_controller/searchapage_controller/search_page.dart';
import 'package:weather_app/views/homepage/widgets/news_tile.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<SearchPageNotifier>(context, listen: false)
        .searchfetchData('indiatrending');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchPageNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: TextField(
          autofocus: false,
          autocorrect: true,
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
              onPressed: () {
                searchProvider.searchfetchData(_searchController.text);
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 29,
              ),
            ),
          ),
          onChanged: (value) {
            searchProvider.searchfetchData(value);
          },
          onSubmitted: (value) {
            searchProvider.searchfetchData(value);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              searchProvider.isLoad
                  ? const SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Column(
                      children: List.generate(
                        searchProvider.model?.articles?.length ?? 0,
                        (index) {
                          return NewsTile(
                            model: searchProvider.model,
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
