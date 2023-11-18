import 'package:flutter/material.dart';
import 'package:tif_task/screens/event_details_screen.dart';
import 'package:tif_task/screens/events_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      home: const EventsScreen(),
      routes: {
        'events_screen': (context) => const EventsScreen(),
        'event_details_screen': (context) => const EventDetailsScreen(),
      },
    );
  }
}
