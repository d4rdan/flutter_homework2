import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';
import '../widgets/joke_card.dart';

class RandomJokeScreen extends StatefulWidget {
  final Set<Joke> favoriteJokes;
  final Function(Joke) onFavoriteToggle;

  const RandomJokeScreen({
    Key? key,
    required this.favoriteJokes,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  RandomJokeScreenState createState() => RandomJokeScreenState();
}

class RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Joke> _randomJoke;

  @override
  void initState() {
    super.initState();
    _loadRandomJoke();
  }

  void _loadRandomJoke() {
    setState(() {
      _randomJoke = ApiService.fetchRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke of the Day'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadRandomJoke,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Joke>(
          future: _randomJoke,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No joke found');
            }

            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Random Joke',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 20),
                  JokeCard(
                    joke: joke,
                    isFavorite: widget.favoriteJokes.contains(joke),
                    onFavoriteToggle: widget.onFavoriteToggle,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
