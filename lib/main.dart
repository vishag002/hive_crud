import 'package:flutter/material.dart';
import 'package:hive_crud/view/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controller/hive_boxess.dart';
import 'model/person.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  boxPersons = await Hive.openBox<Person>('personBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
