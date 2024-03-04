import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mapfeature_project/Test/firstscreen.dart';
import 'package:mapfeature_project/Test/result.dart';
import 'package:mapfeature_project/screens/QuotesCategoryScreen.dart';
import 'package:mapfeature_project/screens/soothe_screen.dart';
import 'firebase_options.dart';
import 'package:mapfeature_project/NavigationBar.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';
import 'package:mapfeature_project/screens/ChatScreen.dart';
import 'package:mapfeature_project/screens/LogInScreen.dart';
import 'package:mapfeature_project/screens/RecommendationScreen.dart';
import 'package:mapfeature_project/screens/SignUpScreen.dart';

int userScore = 0;
int cognitiveScore = 0;
int somaticScore = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SentimentRecording> moodRecordings = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (context) => const LogInScreen(),
        'signup': (context) => const SignUpScreen(),
        'chat': (context) => const ChatBot(),
        'test': (context) => const testScreen(),
        'QCategory': (context) => QuotesCategoryScreen(),
        'sothee': (context) => const sotheeScreen(),
        'recommendation': (context) => const RecommendationScreen(),
        'navigator': (context) => NavigationTabs(
              moodRecordings: moodRecordings,
              onMoodSelected: (moodRecording) {
                setState(() {
                  moodRecordings.add(moodRecording);
                });
              },
            ),
      },
      initialRoute: 'sothee',
    );
  }
}
