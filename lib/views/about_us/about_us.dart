import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            elevation: 0,
            backgroundColor: Colors.grey,
            title: Text('About us'),
          )
        ],
      ),
    );
  }
}
