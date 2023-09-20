import 'package:flutter/material.dart';
import 'package:login/app.dart';
import 'package:login/dependeny_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const LoginApp());
}
