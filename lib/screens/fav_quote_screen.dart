import 'package:flutter/material.dart';
import 'package:random_quote_generator/models/quote.dart';

class FavoriteQuotesPage extends StatelessWidget {
  final List<Map<String, String>> randomQuotes; // Update the type

  FavoriteQuotesPage({required this.randomQuotes});

  @override
  Widget build(BuildContext context) {
    final List<Quote> favoriteQuotes = randomQuotes
        .map((quote) => Quote(quote: quote['quote']!, author: quote['author']!))
        .toList(); // Convert to List<Quote>

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Quotes'),
        backgroundColor: Colors.pink.shade900,
        foregroundColor: Colors.white,
      ),
      body: favoriteQuotes.isEmpty
          ? const Center(
              child: Text(
                'No favorite quotes added yet!',
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(136, 14, 79, 1)),
              ),
            )
          : ListView.builder(
              itemCount: favoriteQuotes.length,
              itemBuilder: (context, index) {
                final quote = favoriteQuotes[index];
                return Card(
                  elevation: 8,
                  surfaceTintColor: Colors.pink.shade900,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.quote,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '- ' + quote.author,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
