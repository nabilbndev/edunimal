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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Edunimal',
        theme: ThemeData(
          fontFamily: edunimalFont.fontFamily,
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: edunimalTextTheme,
          colorScheme: ColorScheme.fromSeed(seedColor: brandColor),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
