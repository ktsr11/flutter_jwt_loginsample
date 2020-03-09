import 'package:jwt_login_sample/models/response_error.dart';
import 'package:jwt_login_sample/models/toekn.dart';
import 'package:jwt_login_sample/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';



class LoginPage extends StatefulWidget {

  @override 
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SharedPreferences  _prefs = SharedService.sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController(); 
  final _useridController = TextEditingController();
  final _passwordController = TextEditingController();
  var responseData;
  String getUrl = "";

  @override 
  void initState() {
    super.initState();
    _loadLoginPage();
  }

  _loadLoginPage() {
    setState(() {
      //SharedPreferences에 url로 저장된 값을 읽어 필드에 저장. 없으면 http:// 대입 
      getUrl = (_prefs.getString('url') ?? 'http://');
      _controller.text = getUrl;
    });
  }

  void _showErrorDialog(String str) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("로그인 실패"),
          content: Text("$str"),
          actions: <Widget>[
            FlatButton(
              child: Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<bool> _fetchPosts(String username, String password) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"username": "$username", "password": "$password"}';

    try {
      final response = await http.post('$getUrl/api/authenticate',headers: headers, body: json);
      
      if(response.statusCode == 200){
        responseData = Token.fromJson(jsonDecode(response.body));
        _prefs.setString("token", responseData.idToken);
        return true;
      }else{
        responseData = ResponseError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        _prefs.setString("token", null);
        _showErrorDialog(responseData.message);
        return false;
      }
    } catch (e) {
      _showErrorDialog("서버 접속 실패");
      return false;
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.link, 
              color: Colors.grey,
            ),
            onPressed: () {
              return showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15)
                      )
                    ),
                    title: Text("서버 URL 주소 입력"),
                    content: Container(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: false, 
                          labelText: 'URL 주소',
                          hintText: 'http://test.co.kr'
                        ),
                      )
                    ),
                    actions: <Widget>[
                      FlatButton( 
                        child: Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _prefs.setString("url", _controller.text);
                        },
                      ),
                      FlatButton( 
                        child: Text('취소'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }, 
            tooltip: 'Show me the value!',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child : SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0), 
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'), 
                SizedBox(height: 16.0),
                Text('로그인샘플'),
                SizedBox(height: 200.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '아이디를 입력해주세요.';
                    }
                    return null;
                  },
                  controller: _useridController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '아이디',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '패스워드를 입력해주세요.';
                    }
                    return null;
                  }, 
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: '패스워드',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 80.0),
                SizedBox(
                  width: double.infinity, 
                  height: 50.0,
                  child: RaisedButton(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.blueAccent, 
                    child: Text('로그인', style: TextStyle(fontSize: 20.0, color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _fetchPosts(_useridController.text, _passwordController.text).then((result){
                          if(result)
                            Navigator.pushNamed(context,'/');
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 120.0),
          ],
        ),
      ),
      ),
    );
  }
}