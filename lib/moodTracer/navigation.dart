// // Navigation file
// import 'package:flutter/material.dart';
// import 'package:mapfeature_project/moodTracer/sentiment.dart';
// import 'package:mapfeature_project/screens/home.dart';
// import 'package:mapfeature_project/screens/profile.dart';
// // import 'package:trial_project/directoryScreen.dart';
// // import 'package:trial_project/moodTracer/sentiment.dart';
// // import 'package:trial_project/profile.dart';

// class MyTabs extends StatefulWidget {
//   final List<SentimentRecording> moodRecordings;
//   final ValueSetter<SentimentRecording> onMoodSelected;

//   MyTabs({
//     required this.moodRecordings,
//     required this.onMoodSelected,
//   });

//   @override
//   _MyTabsState createState() => _MyTabsState();
// }

// class _MyTabsState extends State<MyTabs> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentIndex == 0
//           ? DirectoryScreen(onMoodSelected: widget.onMoodSelected)
//           : Profile(moodRecordings: widget.moodRecordings),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: ' ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: ' ',
//           ),
//         ],
//       ),
//     );
//   }
// }
