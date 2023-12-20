// ignore_for_file: unused_import, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:archive_of_ours/widgets/left_drawer.dart';

class CommissionFormPage extends StatefulWidget {
  const CommissionFormPage({super.key});

  @override
  State<CommissionFormPage> createState() => _CommissionFormPageState();
}

class _CommissionFormPageState extends State<CommissionFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  int _wordCount = 0;
  String _description = "";
  String _genre = "";
  String _characterSource = "";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Center(
            child: Text(
                'Form Tambah Commission',
            ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
        ),
        // TODO: Tambahkan drawer yang sudah dibuat di sini
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                            hintText: "Title",
                            labelText: "Title",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
                            });
                            },
                            validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Title tidak boleh kosong!";
                            }
                            return null;
                            },
                        ),
                        ),

                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                            hintText: "Word Count",
                            labelText: "Word Count",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            // TODO: Tambahkan variabel yang sesuai
                            onChanged: (String? value) {
                            setState(() {
                                _wordCount = int.parse(value!);
                            });
                            },
                            validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Word Count tidak boleh kosong!";
                            }
                            if (int.tryParse(value) == null) {
                                return "Word Count harus berupa angka!";
                            }
                            return null;
                            },
                        ),
                        ),

                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                            hintText: "Description",
                            labelText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                // TODO: Tambahkan variabel yang sesuai
                                _description = value!;
                            });
                            },
                            validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Description tidak boleh kosong!";
                            }
                            return null;
                            },
                        ),
                        ),
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                            hintText: "Genre",
                            labelText: "Genre",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _genre = value!;
                            });
                            },
                            validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Genre tidak boleh kosong!";
                            }
                            return null;
                            },
                        ),
                        ),
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                            hintText: "Character Source",
                            labelText: "Character Source",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _characterSource = value!;
                            });
                            },
                            validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Character Source tidak boleh kosong!";
                            }
                            return null;
                            },
                        ),
                        ),
                        Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.indigo),
                                ),
                                onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                        return AlertDialog(
                                            title: const Text('Produk berhasil tersimpan'),
                                            content: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                Text('Title: $_title'),
                                                Text('Word Count: $_wordCount'),                                                
                                                Text('Description: $_description'),                                                
                                                Text('Genre: $_genre'),                                                
                                                Text('Character Source: $_characterSource'),                                                
                                                ],
                                            ),
                                            ),
                                            actions: [
                                            TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                Navigator.pop(context);
                                                },
                                            ),
                                            ],
                                        );
                                        },
                                    );
                                    }
                                    _formKey.currentState!.reset();
                                },
                                child: const Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                ),
                                ),

                        ),
                        ),
                ])
            ),
        ),
        );
    }
}