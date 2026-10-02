import 'package:flutter/material.dart';
import '../models/magic_card.dart';
import 'dart:math';

// stateless widget for Simulate scan card
//
class ScanPage extends StatelessWidget {
  ScanPage({Key? key}) : super(key: key);

  final newCard = MagicCard(
    name: "Lightning Bolt",
    manaCost: "R",
    type: "Instant",
    oracleText: "Deal 3 damage to any target",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Page"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, newCard);
            },
            child: const Text("Scan"),
          ),
        ],
      ),
    );
  }
}

// random list for card pool for test the creation of a card everytime different.
//
final cardsPool = [
  MagicCard(
    name: "Lightning Bolt",
    manaCost: "R",
    type: "Instant",
    oracleText: "Deal 3 damage to any target",
  ),
  MagicCard(
    name: "Black Lotus",
    manaCost: "0",
    type: "Artifact",
    oracleText: "Add three mana of any one color",
  ),
  MagicCard(
    name: "Counterspell",
    manaCost: "UU",
    type: "Instant",
    oracleText: "Counter target spell",
  ),
  MagicCard(
    name: "Shock",
    manaCost: "R",
    type: "Instant",
    oracleText: "Deal 2 damage to any target",
  ),
  MagicCard(
    name: "Llanowar Elves",
    manaCost: "G",
    type: "Creature",
    oracleText: "Tap: add G",
    power: 1,
    toughness: 1,
  ),
  MagicCard(
    name: "Serra Angel",
    manaCost: "3WW",
    type: "Creature",
    oracleText: "Flying, vigilance",
    power: 4,
    toughness: 4,
  ),
  MagicCard(
    name: "Sol Ring",
    manaCost: "1",
    type: "Artifact",
    oracleText: "Tap: Add CC",
  ),
];
