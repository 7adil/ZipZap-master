import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  final List<HelpItem> helpItems = [
    HelpItem(
      title: 'Placing an Order',
      icon: Icons.shopping_cart,
      description: 'Your order will be processed within 24 hours.',
    ),
    HelpItem(
      title: 'Order Edit and Cancellation',
      icon: Icons.edit,
      description: 'Edit orders, cancel orders, change drivers.',
    ),
    HelpItem(
      title: 'Fee, Payments and Methods',
      icon: Icons.payment,
      description: 'Request refunds, top up money, choose payment methods.',
    ),
    HelpItem(
      title: 'Goods and Size Limits',
      icon: Icons.aspect_ratio,
      description: 'Learn about goods and size restrictions.',
    ),
    HelpItem(
      title: 'Coupons and Promotions',
      icon: Icons.local_offer,
      description: 'Find information about available coupons and promotions.',
    ),
    HelpItem(
      title: 'Profile and Account',
      icon: Icons.account_circle,
      description: 'Manage your profile, account settings, and preferences.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Help Center'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: helpItems.map((item) => HelpCard(item: item)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class HelpItem {
  final String title;
  final String description;
  final IconData icon;

  HelpItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class HelpCard extends StatelessWidget {
  final HelpItem item;

  const HelpCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  item.icon,
                  size: 36,
                  color: Colors.blue,
                ),
                SizedBox(width: 16),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            SizedBox(height: 8),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
