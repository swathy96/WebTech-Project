// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'short_result.dart';

class SearchResult {
  int count;
  List<ShortResult> result;
  SearchResult({
    required this.count,
    required this.result,
  });

  SearchResult copyWith({
    int? count,
    List<ShortResult>? result,
  }) {
    return SearchResult(
      count: count ?? this.count,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    List<ShortResult> results = [];
    for (int i = 0; i < map['count']; i++) {
      results.add(ShortResult.fromMap(map['result'][i]));
    }
    return SearchResult(
      count: map['count'],
      result: results,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchResult.fromJson(String source) {
    //print(source);
    return SearchResult.fromMap(json.decode(source) as Map<String, dynamic>);
  }
  @override
  String toString() => 'SearchResult(count: $count, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchResult &&
        other.count == count &&
        listEquals(other.result, result);
  }

  @override
  int get hashCode => count.hashCode ^ result.hashCode;
}
