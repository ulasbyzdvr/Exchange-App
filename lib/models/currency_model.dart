// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Currency {
  String? id;
  String? description;
  String? code;

  Currency({
    this.id,
    this.description,
    this.code,
  });

  Currency copyWith({
    String? id,
    String? description,
    String? code,
  }) {
    return Currency(
      id: id ?? this.id,
      description: description ?? this.description,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'code': code,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      description:
          map['description'] != null ? map['description'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Currency(id: $id, description: $description, code: $code)';

  @override
  bool operator ==(covariant Currency other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.code == code;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ code.hashCode;
}
