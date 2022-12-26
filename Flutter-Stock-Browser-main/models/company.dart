// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:stock_browser/models/stock_quote.dart';

class Company {
  String country;
  String currency;
  String exchange;
  String finnhubIndustry;
  String ipo;
  String logo;
  double marketCapitalization;
  String name;
  String phone;
  double shareOutstanding;
  String ticker;
  String weburl;
  StockQuote? quote;

  Company({
    required this.country,
    required this.currency,
    required this.exchange,
    required this.finnhubIndustry,
    required this.ipo,
    required this.logo,
    required this.marketCapitalization,
    required this.name,
    required this.phone,
    required this.shareOutstanding,
    required this.ticker,
    required this.weburl,
  });

  setStockQuote(stockQuote) => quote = stockQuote;

  Company copyWith({
    String? country,
    String? currency,
    String? exchange,
    String? finnhubIndustry,
    String? ipo,
    String? logo,
    double? marketCapitalization,
    String? name,
    String? phone,
    double? shareOutstanding,
    String? ticker,
    String? weburl,
  }) {
    return Company(
      country: country ?? this.country,
      currency: currency ?? this.currency,
      exchange: exchange ?? this.exchange,
      finnhubIndustry: finnhubIndustry ?? this.finnhubIndustry,
      ipo: ipo ?? this.ipo,
      logo: logo ?? this.logo,
      marketCapitalization: marketCapitalization ?? this.marketCapitalization,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shareOutstanding: shareOutstanding ?? this.shareOutstanding,
      ticker: ticker ?? this.ticker,
      weburl: weburl ?? this.weburl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'currency': currency,
      'exchange': exchange,
      'finnhubIndustry': finnhubIndustry,
      'ipo': ipo,
      'logo': logo,
      'marketCapitalization': marketCapitalization,
      'name': name,
      'phone': phone,
      'shareOutstanding': shareOutstanding,
      'ticker': ticker,
      'weburl': weburl,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      country: map['country'] as String,
      currency: map['currency'] as String,
      exchange: map['exchange'] as String,
      finnhubIndustry: map['finnhubIndustry'] as String,
      ipo: map['ipo'] as String,
      logo: map['logo'] as String,
      marketCapitalization: map['marketCapitalization'] as double,
      name: map['name'] as String,
      phone: map['phone'] as String,
      shareOutstanding: map['shareOutstanding'] as double,
      ticker: map['ticker'] as String,
      weburl: map['weburl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Company(country: $country, currency: $currency, exchange: $exchange, finnhubIndustry: $finnhubIndustry, ipo: $ipo, logo: $logo, marketCapitalization: $marketCapitalization, name: $name, phone: $phone, shareOutstanding: $shareOutstanding, ticker: $ticker, weburl: $weburl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        other.country == country &&
        other.currency == currency &&
        other.exchange == exchange &&
        other.finnhubIndustry == finnhubIndustry &&
        other.ipo == ipo &&
        other.logo == logo &&
        other.marketCapitalization == marketCapitalization &&
        other.name == name &&
        other.phone == phone &&
        other.shareOutstanding == shareOutstanding &&
        other.ticker == ticker &&
        other.weburl == weburl;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        currency.hashCode ^
        exchange.hashCode ^
        finnhubIndustry.hashCode ^
        ipo.hashCode ^
        logo.hashCode ^
        marketCapitalization.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        shareOutstanding.hashCode ^
        ticker.hashCode ^
        weburl.hashCode;
  }
}
