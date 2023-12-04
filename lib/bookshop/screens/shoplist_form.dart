import 'package:flutter/material.dart';

const List<String> list = <String>['Dropdown', 'Transfer Bank', 'Gopay', 'OVO'];

class CartFormPage extends StatefulWidget {
  const CartFormPage({super.key});

  @override
  State<CartFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<CartFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _paymentMethod = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Produk',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
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
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _email = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama Produk tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: _paymentMethod,
                  icon: const Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    labelText: 'Metode Pembayaran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: list.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _paymentMethod = newValue!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Pilih metode pembayaran!";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Tombol "Confirm Order"
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk mengonfirmasi order di sini
              if (_formKey.currentState!.validate()) {
                // Lakukan aksi setelah konfirmasi order
                // Contoh: Navigator.push, showDialog, dsb.
                print("Order confirmed!");
              }
            },
            child: Text("Confirm Order"),
          ),
        ),
      ),
    );
  }
}
