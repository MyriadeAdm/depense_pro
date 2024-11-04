import 'package:depense_pro/services/database_service.dart';
import 'package:depense_pro/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize historique database
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DatabaseService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
