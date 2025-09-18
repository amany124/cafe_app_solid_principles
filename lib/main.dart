import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:mentor3/managers/order_manager.dart';
import 'package:mentor3/repository/order_repository.dart';
import 'package:mentor3/ui/screens/home_screen.dart';
import 'package:mentor3/ui/screens/report_screen.dart';
import 'models/beverage.dart';

void main() {
  final repo = OrderRepository();
  final manager = OrderManager(repo);

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(manager: manager),
    ),
  );
}

class MyApp extends StatelessWidget {
  final OrderManager manager;

  const MyApp({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahwa ala kefak',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: HomeScreen(manager: manager),
      routes: {
        '/report': (_) => ReportScreen(manager: manager),
      },
    );
  }
}
