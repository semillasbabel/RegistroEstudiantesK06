import 'package:flutter/material.dart';
import 'package:studentregistration/Views/Loggin.dart';
import 'package:studentregistration/Views/StudentsList.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REGISTRO ESTUDIANTES',
      initialRoute: "Loggin",
      routes: {
        "Loggin": (context) => Loggin(),
        "ViewStudents": (context) => StudentView(),
      },
    );
  }
}
