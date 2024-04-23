import 'package:flutter/material.dart';

class orderss extends StatefulWidget {
  @override
  _orderssState createState() => _orderssState();
}

class _orderssState extends State<orderss> {
  String _selectedOption = 'Ongoing';

  Widget _buildTaskContainer(String option) {
    if (option == 'Ongoing') {
      // Return white container for ongoing tasks
      return Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            'Ongoing orders',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: option == 'Completed' ? Colors.pinkAccent : Colors.orange,
        child: Center(
          child: Text(
            '$option orders',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Ongoing';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: _selectedOption == 'Ongoing'
                        ? Colors.blue.withOpacity(0.5)
                        : null,
                    child: Text('Ongoing'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Completed';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: _selectedOption == 'Completed'
                        ? Colors.green.withOpacity(0.5)
                        : null,
                    child: Text('Completed'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Canceled';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: _selectedOption == 'Canceled'
                        ? Colors.red.withOpacity(0.5)
                        : null,
                    child: Text('Canceled'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildTaskContainer(_selectedOption),
          ),
        ],
      ),
    );
  }
}