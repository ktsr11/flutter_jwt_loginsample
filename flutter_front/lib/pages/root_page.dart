import 'dart:convert';

import 'package:jwt_login_sample/models/user_info.dart';
import 'package:jwt_login_sample/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  SharedPreferences _pref = SharedService.sharedPreferences;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _emal = TextEditingController();
  final TextEditingController _authorities = TextEditingController();

  Future<Null> _getUserInfo() async {
    String getUrl = _pref.getString('url');
    String token = _pref.getString('token');
    Userinfo responseData;
    Map<String, String> headers = {"Content-type": "application/json","Authorization":"Bearer $token"};
    try {
      final response = await http.get('$getUrl/api/user',headers: headers);
      responseData = Userinfo.fromJson(jsonDecode(response.body));
      _username.text = responseData.username;
      _firstname.text = responseData.firstname;
      _lastname.text = responseData.lastname;
      _emal.text = responseData.email;
      print(responseData.toString());
    } catch (e) {
      
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인샘플'), 
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              Navigator.pop(context);
              _pref = await SharedPreferences.getInstance();
              _pref.setString("token", null);
            },
            child: Text("로그아웃"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[200],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {

                },
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child : Column(
            children: <Widget>[
            RaisedButton(
              child: Text("정보"),
              onPressed: (){
                _getUserInfo();
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _username,
              decoration: InputDecoration(
                filled: true,
                labelText: "아이디",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _firstname,
              decoration: InputDecoration(
                filled: true,
                labelText: "이름",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _lastname,
              decoration: InputDecoration(
                filled: true,
                labelText: "성",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emal,
              decoration: InputDecoration(
                filled: true,
                labelText: "이메일",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
