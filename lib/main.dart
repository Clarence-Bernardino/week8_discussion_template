import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/expense_entry.dart';
import 'screens/expense_history.dart';
import 'Utilities/theme.dart';
import 'package:week8datapersistence/firebase_options.dart';
import 'providers/todo_provider.dart';
import 'providers/expenses_provider.dart';
import 'screens/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => ExpenseListProvider()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: rusticTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const TodoPage(),
        '/home': (context) => const HomeScreen(),
        '/add-expense': (context) => const ExpenseEntry(),
        '/expense-history': (context) => const HistoryScreen(),
      },
    );
  }
}
