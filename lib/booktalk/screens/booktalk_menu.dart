import 'package:flutter/material.dart';
import 'package:literatour/booktalk/screens/booktalk_form.dart';
import 'package:literatour/booktalk/screens/booktalk_menu.dart';
import 'package:literatour/booktalk/widgets/booktalk_card.dart';

// that it has a State object (defined below) that contains fields that affect
class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

class BookTalkPage extends StatelessWidget {
  BookTalkPage({Key? key}) : super(key: key);
  final List<ShopItem> items = [
    ShopItem("Add Review", Icons.checklist),
    ShopItem("Lihat Review", Icons.reviews),
    // ShopItem("Figma Home", Icons.home_filled),
    ShopItem("List Review Fetch", Icons.list_alt),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping List',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'BookTalk', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return BookTalkCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
