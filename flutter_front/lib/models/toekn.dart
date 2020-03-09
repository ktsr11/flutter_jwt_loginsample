// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

class Token {
    String idToken;

    Token({
        this.idToken,
    });

    factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        idToken: json["id_token"],
    );

    Map<String, dynamic> toJson() => {
        "id_token": idToken,
    };
}
