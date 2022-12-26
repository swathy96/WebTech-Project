// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StockQuote {
  double c;
  double d;
  double dp;
  double h;
  double l;
  double o;
  double pc;
  int t;

  StockQuote({
    required this.c,
    required this.d,
    required this.dp,
    required this.h,
    required this.l,
    required this.o,
    required this.pc,
    required this.t,
  });

  StockQuote copyWith({
    double? c,
    double? d,
    double? dp,
    double? h,
    double? l,
    double? o,
    double? pc,
    int? t,
  }) {
    return StockQuote(
      c: c ?? this.c,
      d: d ?? this.d,
      dp: dp ?? this.dp,
      h: h ?? this.h,
      l: l ?? this.l,
      o: o ?? this.o,
      pc: pc ?? this.pc,
      t: t ?? this.t,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'c': c,
      'd': d,
      'dp': dp,
      'h': h,
      'l': l,
      'o': o,
      'pc': pc,
      't': t,
    };
  }

  factory StockQuote.fromMap(Map<String, dynamic> map) {
    print(map['t'] is int);
    return StockQuote(
      c: map['c'] as double,
      d: map['d'] as double,
      dp: map['dp'] as double,
      h: map['h'] as double,
      l: map['l'] as double,
      o: map['o'] as double,
      pc: map['pc'] as double,
      t: map['t'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockQuote.fromJson(String source) {
    print("source " + source);
    return StockQuote.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'StockQuote(c: $c, d: $d, dp: $dp, h: $h, l: $l, o: $o, pc: $pc, t: $t)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StockQuote &&
        other.c == c &&
        other.d == d &&
        other.dp == dp &&
        other.h == h &&
        other.l == l &&
        other.o == o &&
        other.pc == pc &&
        other.t == t;
  }

  @override
  int get hashCode {
    return c.hashCode ^
        d.hashCode ^
        dp.hashCode ^
        h.hashCode ^
        l.hashCode ^
        o.hashCode ^
        pc.hashCode ^
        t.hashCode;
  }
}
