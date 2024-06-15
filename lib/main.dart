import 'package:cthulhu_solo_investigator_app/modules/home/current_session/current_session.dart';
import 'package:cthulhu_solo_investigator_app/modules/home/home.dart';
import 'package:cthulhu_solo_investigator_app/modules/menu/navBarTop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cthulhu Solo Investigator',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(88, 163, 153, 1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color.fromRGBO(88, 163, 153, 1),
          foregroundColor: Colors.white,
        ),
      ),
      
      home: const MyHomePage(title: 'Solo Investigator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBarWidget(),
      body: CurrentSessionPage(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

//Colors:
// #496989 (73, 105, 137, 1)
// #58A399 (88, 163, 153, 1)
// #A8CD9F (168, 205, 159, 1)
// #E2F4C5 (226, 244, 197, 1)