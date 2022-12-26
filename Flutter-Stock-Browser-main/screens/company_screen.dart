import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_handler.dart';
import '../models/favorite.dart';
import 'details_widget.dart';

class CompanyScreen extends StatefulWidget {
  final String symbol;
  final String name;

  CompanyScreen(this.symbol, this.name);

  @override
  Favorites createState() => Favorites(symbol, name);
}

class Favorites extends State<CompanyScreen> {
  final String symbol;
  final String name;
  IconData? icon;
  late DatabaseHandler handler;
  // bool favorite = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> favorite;
  Favorites(this.symbol, this.name);

  Future<void> isFavorite() async {
    final SharedPreferences prefs = await _prefs;
    final bool counter = !(prefs.getBool(symbol) ?? false);
    setState(() {
      favorite = prefs.setBool(symbol, counter).then((bool success) {
        return counter;
      });
      if (counter) {
        icon = Icons.star;
      } else {
        icon = Icons.star_border;
      }
      print("save = " + prefs.getBool(symbol).toString());
      addToFavorites();
    });
  }

  Future<bool> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("load val = " + preferences.getBool(symbol).toString());
    return preferences.getBool(symbol) ?? false;
  }

  setData() async {
    loadData().then((value) {
      setState(() {
        print("value = " + value.toString());
        if (value) {
          icon = Icons.star;
        } else {
          icon = Icons.star_border;
        }
        addToFavorites();
      });
    });
  }

  Future<void> addToFavorites() async {
    List<Favorite> favorites = [];
    Favorite? favor = await handler.findFavorite(symbol);
    if (icon == Icons.star && favor == null) {
      favor = Favorite(symbol: symbol, name: name);
      favorites.add(favor);
      await handler.insertFavorite(favorites);
    } else if (icon == Icons.star_border && favor != null) {
      await handler.deleteFavorite(symbol);
    } else {
      print("hey just started");
    }
  }

  @override
  void initState() {
    print("hey " + symbol);
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {});
    setData();
    super.initState();

    // print(favorite);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 20.0,
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                isFavorite();
              },
              icon: Icon(icon),
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.topLeft,
          child: DetailsWidget(symbol),
        ));
  }
}
