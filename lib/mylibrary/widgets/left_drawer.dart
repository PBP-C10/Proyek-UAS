// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:archive_of_ours/screens/menu.dart';
import 'package:archive_of_ours/screens/commission_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.indigo,
          ),
          child: Column(
            children: [
              Text(
                'Archive Of Ours',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("Catat seluruh keperluan belanjamu di sini!",
                    textAlign: TextAlign.center, // Center alignment
                    style: TextStyle(
                    fontSize: 15, // Font size 15
                    color: Colors.white, // White text color
                    fontWeight: FontWeight.normal, // Normal font weight
                  ),
                  ),
            ],
          ),
        ),

              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Halaman Utama'),
                // Bagian redirection ke MyHomePage
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_shopping_cart),
                title: const Text('Tambah Commission'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommissionFormPage(),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}