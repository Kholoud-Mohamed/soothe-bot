import 'package:flutter/material.dart';
import 'package:mapfeature_project/moodTracer/rounded_bar_chart.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';
// import 'package:trial_project/moodTracer/sentiment.dart';
// import 'package:trial_project/moodTracer/rounded_bar_chart.dart';

class Profile extends StatelessWidget {
  final List<SentimentRecording> moodRecordings;

  Profile({required this.moodRecordings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'images/photo_2024-01-17_04-23-53-removebg-preview.png'), // Add your image asset
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe', // Add user's name
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RoundedBarChart(
                moodRecordings: moodRecordings,
                getColorForSentiment: _getColorForSentiment,
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getColorForSentiment(Sentiment sentiment) {
  switch (sentiment) {
    case Sentiment.veryUnhappy:
      return const Color.fromARGB(255, 184, 199, 210);
    case Sentiment.unhappy:
      return const Color.fromARGB(255, 200, 207, 218).withAlpha(200);
    case Sentiment.neutral:
      return const Color.fromARGB(255, 190, 194, 194);
    case Sentiment.happy:
      return const Color.fromARGB(255, 186, 221, 238);
    case Sentiment.veryHappy:
      return const Color.fromARGB(255, 158, 195, 214);
    default:
      return Colors.grey;
  }
}
