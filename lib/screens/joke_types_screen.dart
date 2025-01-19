import 'package:flutter/material.dart';
import '../models/joke.dart';        // IMPORTANT: import Joke
import '../models/joke_type.dart';
import '../services/api_services.dart';
import 'favorite_jokes_screen.dart';
import 'jokes_by_type_screen.dart';
import 'random_joke_screen.dart';

class JokeTypesScreen extends StatefulWidget {
  @override
  _JokeTypesScreenState createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  late Future<List<JokeType>> _jokeTypes;

  // ONE GLOBAL-ish SET:
  final Set<Joke> _favoriteJokes = {};

  @override
  void initState() {
    super.initState();
    _jokeTypes = ApiService.fetchJokeTypes();
  }

  // A single toggle function that modifies our one set
  void _toggleFavorite(Joke joke) {
    setState(() {
      if (_favoriteJokes.contains(joke)) {
        _favoriteJokes.remove(joke);
      } else {
        _favoriteJokes.add(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        actions: [
          // 1) Random Joke
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomJokeScreen(
                    favoriteJokes: _favoriteJokes,
                    onFavoriteToggle: _toggleFavorite,
                  ),
                ),
              );
            },
            child: Text(
              'Random Joke',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 2) Favorites
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(
                    favoriteJokes: _favoriteJokes,
                    onFavoriteToggle: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // Show the list/grid of joke types
      body: FutureBuilder<List<JokeType>>(
        future: _jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No joke types found'));
          }

          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              JokeType jokeType = snapshot.data![index];
              return Card(
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    // Pass the same set & toggle to JokesByTypeScreen too
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokesByTypeScreen(
                          type: jokeType.name,
                          favoriteJokes: _favoriteJokes,
                          onFavoriteToggle: _toggleFavorite,
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      jokeType.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
