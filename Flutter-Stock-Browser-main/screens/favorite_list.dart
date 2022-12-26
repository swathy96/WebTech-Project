import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_browser/models/favorite.dart';

import '../db/database_handler.dart';

class FavoriteList extends StatefulWidget {
  @override
  FavoriteTile createState() => FavoriteTile();
}

class FavoriteTile extends State<FavoriteList> {
  late DatabaseHandler handler;
  late List<Favorite> favorites;

  String getCurrentDate() {
    var formatter = DateFormat("MMMM dd");
    var now = DateTime.now();
    return formatter.format(now);
  }

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0, right: 20.0, bottom: 0.0),
          child: Align(
              alignment: Alignment.topRight,
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    'STOCK WATCH',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    getCurrentDate(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  )
                ],
              ))),
        ),
        Container(
            padding: const EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 0.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: (Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Favorites",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                      Divider(
                        color: Colors.white,
                      )
                    ])))),
        FutureBuilder(
            future: handler.retrieveFavorites(),
            builder: (context, AsyncSnapshot<List<Favorite>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Center(
                      child: Text("Empty",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)));
                }
                return ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                            alignment: Alignment.centerRight,
                            color: Color.fromRGBO(33, 33, 33, 1)),
                        key: ValueKey<String>(snapshot.data![index].symbol),
                        onDismissed: (DismissDirection direction) async {
                          await handler
                              .deleteFavorite(snapshot.data![index].symbol);
                          setState(() {
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: ListTile(
                          title: Text(snapshot.data![index].symbol,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          subtitle: Text(snapshot.data![index].name,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ));
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return const Divider(color: Colors.white, height: 5);
                  },
                  itemCount: snapshot.data?.length ?? 0,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                  scrollDirection: Axis.vertical,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
