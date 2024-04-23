import 'package:flutter/material.dart';
import 'package:shipment/Employee.dart';
import 'Business.dart';
import 'Individual.dart';
import 'home.dart';
import 'login.dart';

class AccountType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              // Add your logic for the "Skip" button
            },
            child: Text('Skip'),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height, // Set height to screen height
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/box.jpg'),
              fit: BoxFit.fill, // Use BoxFit.fill to cover the entire container
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Choose Your Account Type',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Description
                  Text(
                    'What type of delivery do you need?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  // SizedBox(height: 20),
                  // // Individual Button
                  // buildAccountTypeButton(
                  //   icon:Icons.account_circle,
                  //   label: 'Employ',
                  //   description: 'For company employ use only.####### ',
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => empos()),
                  //     );
                  //   },
                  // ),
                  SizedBox(height: 20),
                  // Individual Button
                  buildAccountTypeButton(
                    icon: Icons.account_box_rounded,
                    label: 'Individual',
                    description: 'For both basic personal and small businesses use',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Individual()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  // Business Button
                  buildAccountTypeButton(
                    icon: Icons.business_center_rounded,
                    label: 'Business',
                    description: 'SignUp for exclusive business features and submit your enquiry',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Business()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  // Already have an account Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAccountTypeButton({
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 120,
      width: 300,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.black,
            ),
            SizedBox(width: 10),
          ],
        ),
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
