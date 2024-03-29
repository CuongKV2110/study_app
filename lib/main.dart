import 'package:study_app/page/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
