import 'package:flutter/material.dart';
import '../models/superhero.dart';
import '../screens/hero_detail_screen.dart'; // Ensure this imports your SuperheroDetailScreen

class HeroListTile extends StatelessWidget {
  final Superhero hero;

  HeroListTile({required this.hero});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(hero.images.sm, width: 50, height: 50, fit: BoxFit.cover), // Use a small image
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
  }
}
