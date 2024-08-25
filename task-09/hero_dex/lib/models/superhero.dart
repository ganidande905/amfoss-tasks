import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Dex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuperheroListScreen(),
    );
  }
}

class SuperheroListScreen extends StatefulWidget {
  @override
  _SuperheroListScreenState createState() => _SuperheroListScreenState();
}

class _SuperheroListScreenState extends State<SuperheroListScreen> {
  late Future<List<Superhero>> _superheroes;

  @override
  void initState() {
    super.initState();
    _superheroes = _loadSuperheroes();
  }

  Future<List<Superhero>> _loadSuperheroes() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites') ?? [];
    final jsonString = await rootBundle.loadString('assets/hero.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final heroes = jsonList.map((json) => Superhero.fromJson(json)).toList();

    // Update the isFavorite property based on favorites
    for (var hero in heroes) {
      if (favoriteIds.contains(hero.id.toString())) {
        hero.isFavorite = true;
      }
    }

    return heroes;
  }

  Future<void> _toggleFavorite(Superhero hero) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites') ?? [];

    setState(() {
      if (hero.isFavorite) {
        favoriteIds.remove(hero.id.toString());
      } else {
        favoriteIds.add(hero.id.toString());
      }
      hero.isFavorite = !hero.isFavorite;
    });

    await prefs.setStringList('favorites', favoriteIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Superheroes'),
      ),
      body: FutureBuilder<List<Superhero>>(
        future: _superheroes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No superheroes found.'));
          }

          final superheroes = snapshot.data!;

          return ListView.builder(
            itemCount: superheroes.length,
            itemBuilder: (context, index) {
              final superhero = superheroes[index];
              return ListTile(
                leading: Image.network(superhero.images.sm),
                title: Text(superhero.name),
                subtitle: Text(superhero.biography.fullName),
                trailing: IconButton(
                  icon: Icon(
                    superhero.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: superhero.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => _toggleFavorite(superhero),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Superhero {
  final int id;
  final String name;
  final String slug;
  final Powerstats powerstats;
  final Appearance appearance;
  final Biography biography;
  final Work work;
  final Connections connections;
  final Images images;
  bool isFavorite;

  Superhero({
    required this.id,
    required this.name,
    required this.slug,
    required this.powerstats,
    required this.appearance,
    required this.biography,
    required this.work,
    required this.connections,
    required this.images,
    this.isFavorite = false,
  });

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      slug: json['slug'] ?? 'Unknown',
      powerstats: Powerstats.fromJson(json['powerstats'] ?? {}),
      appearance: Appearance.fromJson(json['appearance'] ?? {}),
      biography: Biography.fromJson(json['biography'] ?? {}),
      work: Work.fromJson(json['work'] ?? {}),
      connections: Connections.fromJson(json['connections'] ?? {}),
      images: Images.fromJson(json['images'] ?? {}),
    );
  }
}

class Powerstats {
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory Powerstats.fromJson(Map<String, dynamic> json) {
    return Powerstats(
      intelligence: json['intelligence'] ?? 0,
      strength: json['strength'] ?? 0,
      speed: json['speed'] ?? 0,
      durability: json['durability'] ?? 0,
      power: json['power'] ?? 0,
      combat: json['combat'] ?? 0,
    );
  }
}

class Appearance {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'] ?? 'Unknown',
      race: json['race'] ?? 'Unknown',
      height: List<String>.from(json['height'] ?? []),
      weight: List<String>.from(json['weight'] ?? []),
      eyeColor: json['eyeColor'] ?? 'Unknown',
      hairColor: json['hairColor'] ?? 'Unknown',
    );
  }
}

class Biography {
  final String fullName;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  Biography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['fullName'] ?? 'Unknown',
      alterEgos: json['alterEgos'] ?? 'No alter egos found.',
      aliases: List<String>.from(json['aliases'] ?? []),
      placeOfBirth: json['placeOfBirth'] ?? 'Unknown',
      firstAppearance: json['firstAppearance'] ?? 'Unknown',
      publisher: json['publisher'] ?? 'Unknown',
      alignment: json['alignment'] ?? 'Unknown',
    );
  }
}

class Work {
  final String occupation;
  final String base;

  Work({
    required this.occupation,
    required this.base,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'] ?? 'Unknown',
      base: json['base'] ?? 'Unknown',
    );
  }
}

class Connections {
  final String groupAffiliation;
  final String relatives;

  Connections({
    required this.groupAffiliation,
    required this.relatives,
  });

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['groupAffiliation'] ?? 'Unknown',
      relatives: json['relatives'] ?? 'Unknown',
    );
  }
}

class Images {
  final String xs;
  final String sm;
  final String md;
  final String lg;

  Images({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      xs: json['xs'] ?? 'Unknown',
      sm: json['sm'] ?? 'Unknown',
      md: json['md'] ?? 'Unknown',
      lg: json['lg'] ?? 'Unknown',
    );
  }
}
