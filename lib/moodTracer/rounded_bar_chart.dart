import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';

class RoundedBarChart extends StatelessWidget {
  final List<SentimentRecording> moodRecordings;
  final Color Function(Sentiment) getColorForSentiment;
  final bool animate;

  const RoundedBarChart({
    required this.moodRecordings,
    required this.getColorForSentiment,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SentimentRecording, String>> seriesList = [
      charts.Series<SentimentRecording, String>(
        id: 'Mood',
        data: moodRecordings,
        domainFn: (SentimentRecording mood, _) =>
            DateFormat('E').format(mood.time),
        measureFn: (SentimentRecording mood, _) =>
            mood.sentiment.index.toDouble(),
        colorFn: (SentimentRecording mood, _) => charts.ColorUtil.fromDartColor(
            getColorForSentiment(mood.sentiment)),
        labelAccessorFn: (SentimentRecording mood, _) =>
            moodString(mood.sentiment),
      ),
    ];

    return charts.BarChart(
      seriesList,
      animate: animate,
      domainAxis: const charts.OrdinalAxisSpec(
        tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
          [
            charts.TickSpec('Mon'),
            charts.TickSpec('Tue'),
            charts.TickSpec('Wed'),
            charts.TickSpec('Thu'),
            charts.TickSpec('Fri'),
            charts.TickSpec('Sat'),
            charts.TickSpec('Sun'),
          ],
        ),
      ),
      primaryMeasureAxis:
          const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      defaultRenderer: charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(70),
      ),
    );
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
