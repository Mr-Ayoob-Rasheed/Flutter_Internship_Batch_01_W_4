import 'package:flutter/material.dart';
import 'appointmentPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: AppointmentPage(),
    );
  }

}