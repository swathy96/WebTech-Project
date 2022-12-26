import 'package:flutter/material.dart';
import 'package:stock_browser/api/api_client.dart';
import 'package:stock_browser/models/search_result.dart';
import 'package:stock_browser/screens/details_widget.dart';

import 'company_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  ApiClient client = ApiClient();
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textTheme: const TextTheme(
          // Use this to change the query's text style
          headline6: TextStyle(fontSize: 17.0, color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromRGBO(33, 33, 33, 1)),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,

          // Use this change the placeholder's text style
          hintStyle: TextStyle(
              fontSize: 17.0, color: Color.fromRGBO(155, 155, 155, 1)),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(142, 110, 191, 1), //thereby
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults//Implelemt theme
    return DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Container(
            color: Colors.black,
            child: FutureBuilder<SearchResult>(
              future: client.fetchSearchResults(query),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                SearchResult? result = snapshot.data;
                if (result?.count == 0) {
                  return const Center(
                      child: Text(
                    "No Suggestions Found!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ));
                }
                return ListView.builder(
                    itemCount: result?.count,
                    itemBuilder: (context, index) {
                      String end = result?.result[index].description ?? "";
                      String value = result?.result[index].symbol ?? "";
                      value += " | " + end;
                      return ListTile(
                        title: Text(value,
                            style: const TextStyle(color: Colors.white)),
                        onTap: () {
                          String symbol = result?.result[index].symbol ?? "";
                          String name = end;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CompanyScreen(symbol, name)));
                        },
                      );
                    });
              },
            )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Center(
      child: Text(''),
    );
  }
}
