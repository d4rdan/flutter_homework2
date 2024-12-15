import 'package:flutter/material.dart';
import '../models/joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({Key? key, required this.joke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              joke.setup,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              joke.punchline,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Type: ${joke.type}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}