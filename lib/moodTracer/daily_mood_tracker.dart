// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mapfeature_project/moodTracer/mood_selector.dart';
import 'package:mapfeature_project/moodTracer/rounded_bar_chart.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';

class DailyMoodTracker extends StatefulWidget {
  @override
  _DailyMoodTrackerState createState() => _DailyMoodTrackerState();
}

class _DailyMoodTrackerState extends State<DailyMoodTracker> {
  List<SentimentRecording> moodRecordings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MoodSelector(
              onSelected: (moodRecording) {
                setState(() {
                  moodRecordings.add(moodRecording);
                });
              },
            ),

            const SizedBox(height: 30),
            // Expanded(
            //   child: _buildChart(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return RoundedBarChart(
      moodRecordings: moodRecordings,
      getColorForSentiment: _getColorForSentiment,
      animate: true,
    );
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

  String moodString(Sentiment sentiment) {
    switch (sentiment) {
      case Sentiment.happy:
        return "Happy";
      case Sentiment.veryHappy:
        return "Very Happy";
      case Sentiment.unhappy:
        return "Unhappy";
      case Sentiment.veryUnhappy:
        return "Very Unhappy";
      default:
        return "Meh!";
    }
  }
}
