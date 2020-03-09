import 'package:jwt_login_sample/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    SharedService.sharedPreferences = instance;
    runApp(App());
  });
}