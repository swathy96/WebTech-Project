import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_browser/api/api_constant.dart';
import 'package:stock_browser/models/stock_quote.dart';
import '../models/search_result.dart';
import '../models/company.dart';

class ApiClient {
  Future<SearchResult> fetchSearchResults(String query) async {
    String url = ApiConstant.baseUrl +
        "search?q=" +
        query +
        "&token=" +
        ApiConstant.apiKey;
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return SearchResult.fromJson(response.body);
    } else {
      throw Exception('Failed to load SearchResult');
    }
  }

  Future<Company> fetchCompanyDetails(String query) async {
    Company company;
    String url = ApiConstant.baseUrl +
        "stock/profile2?symbol=" +
        query +
        "&token=" +
        ApiConstant.apiKey;
    // print(url);
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      company = Company.fromJson(response.body);
      url = ApiConstant.baseUrl +
          "quote?symbol=" +
          query +
          "&token=" +
          ApiConstant.apiKey;
      print("hi " + url);
      uri = Uri.parse(url);
      final quoteResponse = await http.get(uri);
      if (quoteResponse.statusCode == 200) {
        StockQuote quote = StockQuote.fromJson(quoteResponse.body);
        print("quote");
        print(quote);
        company.setStockQuote(quote);
        print(company.quote?.c);
        return company;
      } else {
        throw Exception('Failed to fetch Quote');
      }
    } else {
      throw Exception('Failed to fetch Company Details');
    }
  }
}
