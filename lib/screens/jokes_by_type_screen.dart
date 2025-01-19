import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';
import '../widgets/joke_card.dart';
import 'favorite_jokes_screen.dart';

class JokesByTypeScreen extends StatefulWidget {
  final String type;
  final Set<Joke> favoriteJokes;          // <== Accept the set
  final Function(Joke) onFavoriteToggle;  // <== Accept the toggle

  const JokesByTypeScreen({
    Key? key,
    required this.type,
    required this.favoriteJokes,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _JokesByTypeScreenState createState() => _JokesByTypeScreenState();
}

class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
  late Future<List<Joke>> _jokesByType;

  @override
  void initState() {
    super.initState();
    _jokesByType = ApiService.fetchJokesByType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type.toUpperCase()} Jokes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(
                    // pass same set & toggle
                    favoriteJokes: widget.favoriteJokes,
                    onFavoriteToggle: widget.onFavoriteToggle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Joke>>(
        future: _jokesByType,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No jokes found'));
          }
          
          // Use the parent’s set to check isFavorite
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Joke joke = snapshot.data![index];
              return JokeCard(
                joke: joke,
                isFavorite: widget.favoriteJokes.contains(joke),
                onFavoriteToggle: widget.onFavoriteToggle,
              );
            },
          );
        },
      ),
    );
  }
}
