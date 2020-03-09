import 'package:jwt_login_sample/pages/login.dart';
import 'package:jwt_login_sample/pages/root_page.dart';
import 'package:flutter/material.dart';

import 'services/shared_service.dart';

class App extends StatelessWidget {
  final appTitle = '로그인샘플';
  String token = SharedService.sharedPreferences.getString('token');

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: RootPage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (token != null) 
      return null;

    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,  
    );
  }
}