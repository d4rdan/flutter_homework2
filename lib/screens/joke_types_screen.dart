
import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke_type.dart';
import 'jokes_by_type_screen.dart';
import 'random_joke_screen.dart';

class JokeTypesScreen extends StatefulWidget {
  @override
  _JokeTypesScreenState createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  late Future<List<JokeType>> _jokeTypes;

  @override
  void initState() {
    super.initState();
    _jokeTypes = ApiService.fetchJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomJokeScreen(),
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
        ],
      ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokesByTypeScreen(type: jokeType.name),
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