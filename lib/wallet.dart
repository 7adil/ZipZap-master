import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '\$500.00', // Example balance, replace with actual balance
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Example, replace with actual transaction count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Payment to John Doe'),
                    subtitle: Text('23 Jan 2024'),
                    trailing: Text('-\$50.00'), // Example transaction amount, replace with actual amount
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}