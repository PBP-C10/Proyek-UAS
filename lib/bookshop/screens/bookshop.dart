import 'package:flutter/material.dart';
import 'package:literatour/bookshop/widgets/book_details.dart';
import 'package:literatour/bookshop/screens/shoplist_form.dart';

import 'package:flutter/material.dart';

class BookshopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Shop'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Book Shop',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Filter',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // Display Total Price Here
                        Text(
                          'Total Price',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Total Price: \$${total_price}',
                            style: TextStyle(fontSize: 16)),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press for creating order
                            // Ganti dengan tindakan yang sesuai untuk membuat pesanan
                          },
                          child: Text('Create Order'), // Ganti label tombol
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: book_data.isNotEmpty
                          ? ListView.builder(
                              itemCount: book_data.length,
                              itemBuilder: (context, index) {
                                var bookInfo = book_data[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(bookInfo.title),
                                    subtitle:
                                        Text('Price: \$${bookInfo.price}'),
                                    leading: Image.network(
                                      bookInfo.thumbnail,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        // Handle button press for deleting book
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text('Your shopping cart is empty.'),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press for creating order
            // Ganti dengan tindakan yang sesuai untuk membuat pesanan
          },
          child: Text('Create Order'), // Ganti label tombol
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
