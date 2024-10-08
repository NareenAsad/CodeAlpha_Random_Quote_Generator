import 'package:flutter/material.dart';
import 'package:random_quote_generator/screens/fav_quote_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({super.key});

  @override
  _RandomQuoteScreenState createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  String _quote = "Tap the button below to generate a random quote!";
  String _author = "";
  List<Map<String, String>> favoriteQuotes =
      []; // List to store favorite quotes

  // Fetch a random quote from the DummyJSON API
  Future<void> _fetchRandomQuote() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/quotes'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> quotesJson = data['quotes'];

        // Get a random quote from the fetched list
        final random = Random();
        final quoteIndex = random.nextInt(quotesJson.length);

        setState(() {
          final quoteData = quotesJson[quoteIndex];
          _quote = quoteData['quote'];
          _author = quoteData['author'];
        });
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      setState(() {
        _quote = "Error fetching quote.";
        _author = "";
      });
    }
  }

  // Share the quote
  void _shareQuote() {
    Share.share('$_quote - $_author');
  }

  // Add quote to favorites
  void _addToFavorites() {
    setState(() {
      favoriteQuotes.add({
        'quote': _quote,
        'author': _author,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to Favorites!')),
    );
  }

  // Navigate to FavoriteQuotesPage
  void _goToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteQuotesPage(
          randomQuotes: favoriteQuotes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Random Quote Generator'),
        backgroundColor: Colors.pink.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quote display area
            Expanded(
              child: Center(
                child: Text(
                  '"$_quote"\n\n- $_author',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),

            // Button Row
            Column(
              children: [
                // Get Quote button
                ElevatedButton(
                  onPressed: _fetchRandomQuote,
                  child: const Text('Get a New Quote'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade900,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Button Row with three buttons below
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Add to Favorites button with heart icon only
                    ElevatedButton(
                      onPressed: _addToFavorites,
                      child: const Icon(Icons.favorite), // Heart icon only
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade900,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    // Share button with share icon only
                    ElevatedButton(
                      onPressed: _shareQuote,
                      child: const Icon(Icons.share), // Share icon only
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade900,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    // Go to Favorites button with eye icon
                    ElevatedButton(
                      onPressed: _goToFavorites,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade900,
                        foregroundColor: Colors.white,
                      ),
                      child: const Icon(Icons.visibility), // Eye icon only
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
