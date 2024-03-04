import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'sentiment.dart';

class MoodSelector extends StatefulWidget {
  final Function(SentimentRecording) onSelected;
  const MoodSelector({Key? key, required this.onSelected}) : super(key: key);

  @override
  createState() => new MoodSelectorState(onSelected);
}

class MoodSelectorState extends State<MoodSelector> {
  var timeFormatter = new DateFormat('jm');
  var dayFormatter = new DateFormat('MMMd');
  DateTime selectedDate = DateTime.now();

  final ValueSetter<SentimentRecording> onSelected;
  String comment = "";
  TextEditingController controller = new TextEditingController();

  MoodSelectorState(this.onSelected);

  void _handleSentiment(Sentiment sentiment) {
    final newMoodRecording = SentimentRecording(sentiment, selectedDate,
        comment: comment, activities: []);
    onSelected(newMoodRecording);
    controller = TextEditingController(); // Clear the text controller
  }

  void _commentChanged(String newComment) {
    comment = newComment;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(200),
          bottomRight: Radius.circular(200),
          topLeft: Radius.circular(200),
          topRight: Radius.circular(200),
        ),
      ),
      color: const Color.fromARGB(255, 217, 224, 226),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(top: 2),
            //   child: Text(
            //     'How are you feeling today ? ',
            //     style: const TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 15,
            //         fontFamily: 'Langar',
            //         color: Colors.white),
            //   ),
            // ),
            // Row(
            //   children: <Widget>[
            //     const Icon(
            //       Icons.calendar_today,
            //       color: Colors.purple,
            //       size: 20.0,
            //     ),
            //     TextButton(
            //       onPressed: () => _selectDate(context),
            //       style: TextButton.styleFrom(
            //         primary: Colors.white,
            //         textStyle: const TextStyle(
            //           color: Colors.purple,
            //           decoration: TextDecoration.underline,
            //           fontSize: 20,
            //         ),
            //       ),
            //       child: Row(
            //         children: [
            //           Text(
            //             "${dayFormatter.format(selectedDate.toLocal())}",
            //           ),
            //           const SizedBox(width: 10.0),
            //           const Text("\u{1F4C5}"), // Emoji for calendar
            //         ],
            //       ),
            //     ),
            //     const SizedBox(height: 10.0, width: 10),
            //     const Icon(
            //       Icons.access_time,
            //       color: Colors.purple,
            //       size: 20.0,
            //     ),
            //     TextButton(
            //       onPressed: () => _selectDate(context),
            //       style: TextButton.styleFrom(
            //         primary: Colors.white,
            //         textStyle: const TextStyle(
            //           color: Colors.purple,
            //           decoration: TextDecoration.underline,
            //           fontSize: 20,
            //         ),
            //       ),
            //       child: Row(
            //         children: [
            //           Text(
            //             "${timeFormatter.format(selectedDate.toLocal())}",
            //           ),
            //           const SizedBox(width: 10.0),
            //           const Text("\u{1F553}"), // Emoji for clock
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            ButtonBar(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => _handleSentiment(Sentiment.veryHappy),
                        icon: const Icon(Icons.sentiment_very_satisfied),
                        iconSize: 40.0,
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () => _handleSentiment(Sentiment.happy),
                        icon: const Icon(Icons.sentiment_satisfied),
                        iconSize: 40.0,
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () => _handleSentiment(Sentiment.neutral),
                        icon: const Icon(Icons.sentiment_neutral),
                        iconSize: 40.0,
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () => _handleSentiment(Sentiment.unhappy),
                        icon: const Icon(Icons.sentiment_dissatisfied),
                        iconSize: 40.0,
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () =>
                            _handleSentiment(Sentiment.veryUnhappy),
                        icon: const Icon(Icons.sentiment_very_dissatisfied),
                        iconSize: 40.0,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
