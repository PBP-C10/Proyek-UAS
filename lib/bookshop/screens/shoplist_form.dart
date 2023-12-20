import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literatour/bookshop/screens/bookshop.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

const List<String> list = <String>['Transfer Bank', 'Gopay', 'OVO'];

class CartFormPage extends StatefulWidget {
  const CartFormPage({Key? key}) : super(key: key);

  @override
  State<CartFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<CartFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _paymentMethod = list.first;

  Future<void> _showPaymentInfoDialog() async {
    String message = "";

    switch (_paymentMethod) {
      case 'Gopay':
        message = "Transfer ke 0002-08979878397 a/n Literatour";
        break;
      case 'OVO':
        message = "Transfer ke 1818085683730384 a/n Literatour";
        break;
      case 'Transfer Bank':
        message = "Transfer ke bank ABC dengan kode 00298734765 a/n Literatour";
        break;
      default:
        message = "Informasi pembayaran tidak tersedia";
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informasi Pembayaran'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                submitOrder(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> submitOrder(BuildContext context) async {
    try {
      final request = context.read<CookieRequest>();
      final response = await request.post(
        'https://literatour-c10-tk.pbp.cs.ui.ac.id/BookShop/submit-order-flutter/',
        '',
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('status') &&
          response['status'] == 'success') {
        print('Order submitted successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookShopPage()),
        );
      } else {
        print('Failed to submit order. Response: $response');
      }
    } catch (e) {
      print('Error submitting order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Order Confirmation Form',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _showPaymentInfoDialog();
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white, // Warna latar belakang tombol
            ),
            child: Text(
              'Confirm Order',
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
                    hintText: "Email",
                    labelText: "Email",
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
                      return "Email tidak boleh kosong!";
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
    );
  }
}
