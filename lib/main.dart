import 'package:edunimal/screens/home_screen.dart';
import 'package:edunimal/logic/signin_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EdunimalApp());
}

class EdunimalApp extends StatelessWidget {
  const EdunimalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Edunimal',
        theme: ThemeData(
          fontFamily: edunimalFont.fontFamily,
          textTheme: edunimalTextTheme,
          colorScheme: ColorScheme.fromSeed(seedColor: brandColor),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
