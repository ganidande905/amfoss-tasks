import 'package:flutter/material.dart';
import 'screens/hero_detail_screen.dart';
import 'models/superhero.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Dex',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SuperheroListScreen(),
    );
  }
}

class SuperheroListScreen extends StatefulWidget {
  @override
  _SuperheroListScreenState createState() => _SuperheroListScreenState();
}

class _SuperheroListScreenState extends State<SuperheroListScreen> {
  List<Superhero> _superheroes = [];

  @override
  void initState() {
    super.initState();
    _loadSuperheroes();
  }

  Future<void> _loadSuperheroes() async {
    final String response = await rootBundle.loadString('assets/heroes.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _superheroes = data.map((json) => Superhero.fromJson(json)).toList();
    });
  }

  void _startSearch() {
    showSearch(
      context: context,
      delegate: SuperheroSearchDelegate(_superheroes),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Dex'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _startSearch,
          ),
        ],
      ),
      body: _superheroes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _superheroes.length,
              itemBuilder: (context, index) {
                final superhero = _superheroes[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(superhero.name, style: Theme.of(context).textTheme.titleLarge),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        superhero.images.sm,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuperheroDetailScreen(superhero: superhero),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class SuperheroSearchDelegate extends SearchDelegate {
  final List<Superhero> superheroes;

  SuperheroSearchDelegate(this.superheroes);

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = superheroes.where((hero) {
      final nameLower = hero.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final superhero = suggestions[index];
        return ListTile(
          title: Text(superhero.name),
          leading: Image.network(superhero.images.sm),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuperheroDetailScreen(superhero: superhero),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
