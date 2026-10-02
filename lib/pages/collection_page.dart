import 'package:flutter/material.dart';
import '../models/magic_card.dart';
import 'card_detail_page.dart';
import 'scan_page.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardDetailPage(card: card)));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text(card.name),
                        Text(card.manaCost),
                        Text(card.type),
                        Text(card.oracleText),
                        if (card.power != null) ...[
                          const SizedBox(height: 10),
                          Text("${card.power}/${card.toughness}"),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // change the on pressed button with async for the OCR phase and the await navigator.push changing.
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ScanPage()));
              setState(() {
                if (result != null && result is MagicCard) {
                  cards.add(result);
                }
              });
            },
            child: const Text('Scan new card'),
          ),
        ],
      ),
    );
  }
}
