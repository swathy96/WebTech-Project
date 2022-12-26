// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Favorite {
  String symbol;
  String name;
  Favorite({
    required this.symbol,
    required this.name,
  });

  Favorite copyWith({
    String? symbol,
    String? name,
  }) {
    return Favorite(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symbol': symbol,
      'name': name,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      symbol: map['symbol'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Favorite(symbol: $symbol, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favorite && other.symbol == symbol && other.name == name;
  }

  @override
  int get hashCode => symbol.hashCode ^ name.hashCode;
}
