import 'package:flutter/material.dart';
import 'package:archive_of_ours/screens/menu.dart';
import 'package:archive_of_ours/screens/commission_form.dart';

class CommissionCard extends StatelessWidget {
  final Commission item;

  const CommissionCard(this.item, {Key? key}) : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      // color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        
                if (item.name == "Tambah Commission") {
                  // TODO: Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CommissionFormPage(),
                  ),
                );
                }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}