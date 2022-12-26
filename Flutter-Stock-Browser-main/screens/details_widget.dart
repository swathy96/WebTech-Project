// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_browser/api/api_client.dart';
import 'package:stock_browser/models/stock_quote.dart';

import '../models/company.dart';

class DetailsWidget extends StatelessWidget {
  ApiClient client = ApiClient();
  final String symbol;

  DetailsWidget(
    this.symbol,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Company>(
        future: client.fetchCompanyDetails(symbol),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print(snapshot.data);
            return const CircularProgressIndicator();
          }
          print("data present");
          print(snapshot.data);
          Company? company = snapshot.data;
          StockQuote? quote = company?.quote;
          double current = quote?.c ?? 0.0;
          double change = quote?.d ?? 0.0;
          double difference = current - change;
          int r = difference > 0 ? 99 : 244;
          int g = difference > 0 ? 167 : 91;
          int b = difference > 0 ? 87 : 78;
          return Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.black,
              child: Column(children: [
                Table(children: [
                  TableRow(
                    children: [
                      Text(company?.ticker ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25)),
                      Text(company?.name ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Color.fromRGBO(155, 155, 155, 1),
                              fontSize: 25))
                    ],
                  ),
                  TableRow(children: [
                    Text(quote?.c.toString() ?? "",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25)),
                    Text(
                        difference > 0
                            ? "+" + difference.toString()
                            : "-" + difference.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(r, g, b, 1), fontSize: 25))
                  ])
                ]),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Stats",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                ),
                Table(children: [
                  TableRow(
                    children: [
                      const Text("Open",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text(quote?.o.toString() ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(157, 157, 157, 1))),
                      const Text("High",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text(quote?.h.toString() ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Low",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text(quote?.l.toString() ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(157, 157, 157, 1))),
                      const Text("Prev",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text(quote?.pc.toString() ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  ),
                ]),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("About",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
                Table(children: [
                  TableRow(
                    children: [
                      const Text("Start date",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text(company?.ipo ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Industry",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text(company?.finnhubIndustry ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Website",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text(company?.weburl ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Exchange",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text(company?.exchange ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Market Cap",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                      Text(company?.marketCapitalization.toString() ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(157, 157, 157, 1)))
                    ],
                  )
                ]),
              ]));
        });
  }
}
