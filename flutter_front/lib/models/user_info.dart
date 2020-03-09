// To parse this JSON data, do
//
//     final userinfo = userinfoFromJson(jsonString);

import 'dart:convert';

class Userinfo {
    String username;
    String firstname;
    String lastname;
    String email;
    List<Authority> authorities;

    Userinfo({
        this.username,
        this.firstname,
        this.lastname,
        this.email,
        this.authorities,
    });

    factory Userinfo.fromRawJson(String str) => Userinfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
    };
}

class Authority {
    String name;

    Authority({
        this.name,
    });

    factory Authority.fromRawJson(String str) => Authority.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}