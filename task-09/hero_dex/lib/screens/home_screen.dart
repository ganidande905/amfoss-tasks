import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/superhero.dart';
import '../widgets/hero_list_tile.dart';
import 'favorites_screen.dart';
import 'hero_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Superhero> heroes = [];
  List<Superhero> filteredHeroes = [];
  List<Superhero> suggestions = [];
  String selectedType = 'all';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadHeroes();
  }

  Future<void> loadHeroes() async {
    final String response = await rootBundle.loadString('assets/heroes.json');
    final List<dynamic> data = jsonDecode(response);
    setState(() {
      heroes = data.map((json) => Superhero.fromJson(json)).toList();
      filteredHeroes = heroes;
      suggestions = heroes;
    });
  }

  void filterHeroes(String query) {
    setState(() {
      filteredHeroes = heroes.where((hero) {
        final isMatching = hero.name.toLowerCase().contains(query.toLowerCase());
        final isTypeMatching = selectedType == 'all' || hero.biography.alterEgos == selectedType;
        return isMatching && isTypeMatching;
      }).toList();
      suggestions = filteredHeroes.where((hero) => hero.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void filterByType(String type) {
    setState(() {
      selectedType = type;
      filterHeroes(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero DEX'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritesScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search Heroes',
                  ),
                  onChanged: (query) {
                    filterHeroes(query);
                  },
                ),
                if (suggestions.isNotEmpty)
                  Container(
                    height: 200,
                    child: ListView(
                      children: suggestions.map((hero) {
                        return ListTile(
                          title: Text(hero.name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuperheroDetailScreen(superhero: hero),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => filterByType('all'),
                child: Text('All'),
              ),
              ElevatedButton(
                onPressed: () => filterByType('hero'),
                child: Text('Heroes'),
              ),
              ElevatedButton(
                onPressed: () => filterByType('villain'),
                child: Text('Villains'),
              ),
              ElevatedButton(
                onPressed: () => filterByType('anti-hero'),
                child: Text('Anti-Heroes'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHeroes.length,
              itemBuilder: (context, index) {
                final hero = filteredHeroes[index];
                return HeroListTile(hero: hero);
              },
            ),
          ),
        ],
      ),
    );
  }
}
