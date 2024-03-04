import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
  final List<String> selectedCategories;

  QuoteScreen({required this.selectedCategories});

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<String> _quoteFuture;
  late String _currentQuote;

  @override
  void initState() {
    super.initState();
    _quoteFuture = fetchRandomQuote(widget.selectedCategories);
  }

  Future<String> fetchRandomQuote(List<String> categories) async {
    const apiKey = 'QYuiWgKspPsWt589ocVpoQ==FusysL7c5sX0eKG9';
    final apiUrl = 'https://api.api-ninjas.com/v1/quotes';

    // Build query parameter for multiple categories
    final categoryQuery = categories.join(',');

    final response = await http.get(
      Uri.parse('$apiUrl?category=$categoryQuery'),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> quotes = json.decode(response.body);
      if (quotes.isNotEmpty) {
        final randomIndex = Random().nextInt(quotes.length);
        final randomQuote = quotes[randomIndex]['quote'] as String;
        return randomQuote;
      }
    }
    return 'Failed to fetch quote';
  }

  void _fetchAnotherQuote() {
    setState(() {
      _quoteFuture = fetchRandomQuote(widget.selectedCategories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote'),
        backgroundColor: const Color.fromARGB(255, 102, 163, 176),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _quoteFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Failed to fetch quote');
            } else {
              _currentQuote = snapshot.data ?? '';
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 102, 163, 176),
                      Color.fromARGB(255, 133, 168, 177),
                      Color.fromARGB(255, 162, 197, 197),
                      Color.fromARGB(255, 234, 237, 237),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 400,
                        decoration: BoxDecoration(
                          border: const Border(
                            top: BorderSide(width: 1.5, color: Colors.white),
                            left: BorderSide(width: 1.5, color: Colors.white),
                            right: BorderSide(width: 1, color: Colors.white),
                            bottom: BorderSide.none,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentQuote,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 355,
                      left: 135,
                      // right: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.repeat_rounded),
                            onPressed: _fetchAnotherQuote,
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            onPressed: () {
                              // Favorite functionality
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
