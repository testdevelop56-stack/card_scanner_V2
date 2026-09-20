import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // The Material App manage the entire rules of the general App.
    return MaterialApp(
      // Application name
      title: 'Magic Scanner',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ).copyWith(
          secondary: Colors.blue,
        ),
        useMaterial3: true,
      ),
      //degub baner removal
      debugShowCheckedModeBanner: false,
      // A widget which will be started on application startup
      home: const HomeScreen(),
    );
  }
}

//Structure of the first page
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Magic Scanner'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Intializing scanning...')));
              },
              child: const Text('Scan card'),
            ),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CollectionPage()));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening the vault')));
              },
              child: const Text('Collection'),
            ),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Packing data in CSV....')));
              },
              child: const Text('Export CSV'),
            ),
          ]),
        ));
  }
}

// stateful widget che incrementa il valore delle carte quando si preme il bottone.
class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<MagicCard> cards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('The Vault'),
        ),
        body: Center(
            child: Column(
          children: [
            // Text('Card in the vault = ${cards.length}'),
            for (card in cards){
              cards[0].name,
              cards[1].manaCost,
              cards[2].type,
              cards[0].name,
            }
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cards.add(MagicCard(
                    name: "Lightning Bolt",
                    manaCost: "R",
                    type: "Instant",
                    colors: "Red",
                    oracleText: "Deal 3 damage to any target",
                  ));
                });
              },
              child: const Text('Add card'),
            )
          ],
        )));
  }
}

// object for see which field is mandatory and optional
class MagicCard {
  String name;
  String manaCost;
  String type;
  String oracleText;
  int? power;
  int? toughness;

  MagicCard(
      {required this.name,
      required this.manaCost,
      required this.type,
      required this.oracleText,
      int? power,
      int? toughness});
}

// Second Page Collection statelesslWidget
// class CollectionPage extends StatelessWidget {
//   const CollectionPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('The Vault'),
//       ),
//       body: Center(
//           child: Row(
//         children: [Text('Your Collection')],
//       )),
//     );
//   }
// }
