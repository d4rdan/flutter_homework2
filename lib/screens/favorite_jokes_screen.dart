import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../widgets/joke_card.dart';

class FavoriteJokesScreen extends StatefulWidget {
  final Set<Joke> favoriteJokes;
  final Function(Joke) onFavoriteToggle;

  const FavoriteJokesScreen({
    Key? key,
    required this.favoriteJokes,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _FavoriteJokesScreenState createState() => _FavoriteJokesScreenState();
}

class _FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Jokes'),
      ),
      body: widget.favoriteJokes.isEmpty
          ? Center(
              child: Text(
                'No favorite jokes yet!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = widget.favoriteJokes.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: JokeCard(
                    joke: joke,
                    isFavorite: true,
                    onFavoriteToggle: widget.onFavoriteToggle,
                  ),
                );
              },
            ),
    );
  }
}
