import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastypal/auth/start_screen.dart';
import 'package:tastypal/homescreen.dart';
import 'package:tastypal/main_homescreen.dart';
import 'package:tastypal/utils/colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:FirebaseAuth.instance.currentUser != null?const Mainhome():const GetStarted(),
      theme: ThemeData(
        dialogBackgroundColor:  CustomColor.lightgreen(),
        scaffoldBackgroundColor: CustomColor.lightgreen(),
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent,elevation: 0),
        textTheme: GoogleFonts.dmSansTextTheme(),
        useMaterial3: true,
      ),
    );
  }
}
