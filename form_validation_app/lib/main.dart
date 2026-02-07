import 'package:flutter/material.dart';
import 'registration_form.dart';
import 'theme_controller.dart';

void main(){
  runApp(const MyApp());
}

// final ValueNotifier<ThemeMode> themeNotifier=ValueNotifier(ThemeMode.dark);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (_,mode,_){
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: mode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.yellow,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ),

      // 🌙 DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.yellow,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.yellow,
        ),
      ),
      home:RegistrationForm(),
    );
      }
    );
    
  }
}