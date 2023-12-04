import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya aman
// import 'package:shopping_list/widgets/left_drawer.dart';

class ReviewFormPage extends StatefulWidget {
  const ReviewFormPage({super.key});

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  // String _name = "";
  int _rating = 0;
  String _review = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Review',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini aman
      // drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       hintText: "Nama Produk",
          //       labelText: "Nama Produk",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5.0),
          //       ),
          //     ),
          //     onChanged: (String? value) {
          //       setState(() {
          //         _name = value!;
          //       });
          //     },
          //     validator: (String? value) {
          //       if (value == null || value.isEmpty) {
          //         return "Nama tidak boleh kosong!";
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Rating",
                labelText: "Rating",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              // TODO: Tambahkan variabel yang sesuai aman
              onChanged: (String? value) {
                setState(() {
                  _rating = int.parse(value!);
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Harga tidak boleh kosong!";
                }
                if (int.tryParse(value) == null) {
                  return "Harga harus berupa angka!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Review",
                labelText: "Review",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  // TODO: Tambahkan variabel yang sesuai aman
                  _review = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Review tidak boleh kosong!";
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
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Review berhasil tersimpan'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Nama: $_name'),
                                // TODO: Munculkan value-value lainnya
                                Text('Rating: $_rating'),
                                Text('Review: $_review')
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
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
