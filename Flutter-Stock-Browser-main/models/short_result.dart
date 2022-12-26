// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShortResult {
  String description;
  String displaySymbol;
  String symbol;
  String type;

  ShortResult({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
    required this.type,
  });

  ShortResult copyWith({
    String? description,
    String? displaySymbol,
    String? symbol,
    String? type,
  }) {
    return ShortResult(
      description: description ?? this.description,
      displaySymbol: displaySymbol ?? this.displaySymbol,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'displaySymbol': displaySymbol,
      'symbol': symbol,
      'type': type,
    };
  }

  factory ShortResult.fromMap(Map<String, dynamic> map) {
    return ShortResult(
      description: map['description'],
      displaySymbol: map['displaySymbol'],
      symbol: map['symbol'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortResult.fromJson(String source) {
    return ShortResult.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'ShortResult(description: $description, displaySymbol: $displaySymbol, symbol: $symbol, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShortResult &&
        other.description == description &&
        other.displaySymbol == displaySymbol &&
        other.symbol == symbol &&
        other.type == type;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        displaySymbol.hashCode ^
        symbol.hashCode ^
        type.hashCode;
  }
}
