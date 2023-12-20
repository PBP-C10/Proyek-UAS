import 'package:flutter/material.dart';
import 'package:archive_of_ours/widgets/left_drawer.dart';
import 'package:archive_of_ours/widgets/commission_card.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

    final List<Commission> items = [
        Commission("Lihat Commission", Icons.checklist, Colors.red),
        Commission("Tambah Commission", Icons.add_shopping_cart, Colors.blue),
        Commission("Logout", Icons.logout, Colors.yellow),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                'Archive Of Ours',
                ),
            ),
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
                        'Archive Of Ours', // Text yang menandakan toko
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
                        children: items.map((Commission item) {
                        // Iterasi untuk setiap item
                        return CommissionCard(item);
                        }).toList(),
                    ),
                    ],
                ),
                ),
            ),
            drawer: const LeftDrawer(),
            );
            }
    }

class Commission {
  final String name;
  final IconData icon;
  final Color color;

  Commission(this.name, this.icon, this.color);
}