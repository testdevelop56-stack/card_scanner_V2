import '../pages/collection_page.dart';
import 'package:flutter/material.dart';

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
