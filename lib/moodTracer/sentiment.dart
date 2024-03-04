// sentiment.dart
// import 'package:flutter/material.dart';

enum Sentiment { veryUnhappy, unhappy, neutral, happy, veryHappy }

class SentimentRecording {
  // id is not final because it can be set after insertion into the database
  int? id;
  List<String> activities;
  final DateTime time;
  final Sentiment sentiment;
  final String comment;

  SentimentRecording(this.sentiment, this.time,
      {this.id, this.comment = "", required this.activities});

  SentimentRecording.fromMap(Map map)
      : id = map["id"],
        time = DateTime.parse(map["timestamp"]),
        sentiment = parseSentiment(map["sentiment"]),
        comment = map["comment"],
        activities = (map["activities"] as String).split(',');

  Map<String, dynamic> toMap() {
    return {
      "timestamp": time.toIso8601String(),
      "sentiment": sentimentString(sentiment),
      "comment": comment,
      "activities": activities.join(','),
    }..removeWhere((key, value) => value == null);
  }
}

String sentimentString(Sentiment sentiment) {
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

Sentiment parseSentiment(String string) {
  switch (string) {
    case "Very Unhappy":
      return Sentiment.veryUnhappy;
    case "Unhappy":
      return Sentiment.unhappy;
    case "Happy":
      return Sentiment.happy;
    case "Very Happy":
      return Sentiment.veryHappy;
    default:
      return Sentiment.neutral;
  }
}
