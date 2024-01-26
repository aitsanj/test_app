import 'package:ap_for_interview/notifier/profile_info.notifier.dart';
import 'package:ap_for_interview/notifier/tab.notifier.dart';
import 'package:ap_for_interview/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TabProvider(),
          child: const MyApp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
          child: const MyApp(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegisterScreen(),
      ),
    );
  }
}
