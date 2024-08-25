import 'package:flutter/material.dart';
import '../models/superhero.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final Superhero superhero;

  SuperheroDetailScreen({required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(superhero.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.network(superhero.images.lg),
            SizedBox(height: 16.0),
            Text(
              'Full Name: ${superhero.biography.fullName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('Alter Egos: ${superhero.biography.alterEgos}'),
            Text('Aliases: ${superhero.biography.aliases.join(', ')}'),
            Text('Place of Birth: ${superhero.biography.placeOfBirth}'),
            Text('First Appearance: ${superhero.biography.firstAppearance}'),
            Text('Publisher: ${superhero.biography.publisher}'),
            Text('Alignment: ${superhero.biography.alignment}'),
            SizedBox(height: 16.0),
            Text(
              'Powerstats:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('Intelligence: ${superhero.powerstats.intelligence}'),
            Text('Strength: ${superhero.powerstats.strength}'),
            Text('Speed: ${superhero.powerstats.speed}'),
            Text('Durability: ${superhero.powerstats.durability}'),
            Text('Power: ${superhero.powerstats.power}'),
            Text('Combat: ${superhero.powerstats.combat}'),
            SizedBox(height: 16.0),
            Text(
              'Appearance:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('Gender: ${superhero.appearance.gender}'),
            Text('Race: ${superhero.appearance.race}'),
            Text('Height: ${superhero.appearance.height.join(', ')}'),
            Text('Weight: ${superhero.appearance.weight.join(', ')}'),
            Text('Eye Color: ${superhero.appearance.eyeColor}'),
            Text('Hair Color: ${superhero.appearance.hairColor}'),
            SizedBox(height: 16.0),
            Text(
              'Work:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('Occupation: ${superhero.work.occupation}'),
            Text('Base: ${superhero.work.base}'),
            SizedBox(height: 16.0),
            Text(
              'Connections:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('Group Affiliation: ${superhero.connections.groupAffiliation}'),
            Text('Relatives: ${superhero.connections.relatives}'),
          ],
        ),
      ),
    );
  }
}
