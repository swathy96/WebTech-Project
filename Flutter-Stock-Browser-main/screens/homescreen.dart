import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_browser/screens/favorite_list.dart';
import 'custom_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _SearchResult createState() => _SearchResult();
}

class _SearchResult extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock'),
        backgroundColor: const Color.fromRGBO(144, 49, 170, 1),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      body: FavoriteList(),
      backgroundColor: Colors.black,

      //const Center(child: Text("Hello")),
    );
  }
}
