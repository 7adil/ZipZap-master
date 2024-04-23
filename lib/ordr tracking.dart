import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  String _orderNumber = "";
  bool _isTracking = false;
  List<String> _trackingHistory = []; // Track dummy history

  // Dummy tracking data
  Map<String, List<String>> dummyTrackingData = {
    "123456789": [
      "Package accepted",
      "Package in warehouse",
      "Package in transit",
      "Package is on delivery",
      "Package handed over"
    ],
    "987654321": [
      "Package accepted",
      "Package in warehouse",
      "Package in transit",
      "Package is on delivery",
      "Package handed over"
    ],
  };

  // Icon mapping for different statuses
  Map<String, IconData> statusIcons = {
    "Package accepted": Icons.check_circle,
    "Package in transit": Icons.directions_bus,
    "Package is on delivery": Icons.local_shipping,
    "Package handed over": Icons.supervisor_account,
    "Package in warehouse": Icons.home,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.orange[600],
        elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade600,
              Colors.orange.shade300,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded( // Wrap the Container with Expanded
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        // labelText: 'Enter Order/Tracking Number',
                        hintText: 'Tracking Number',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _orderNumber = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Simulating API call with dummy data
                          if (dummyTrackingData.containsKey(_orderNumber)) {
                            setState(() {
                              _isTracking = true;
                              _trackingHistory =
                              dummyTrackingData[_orderNumber]!;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Track',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.0),
                    _isTracking
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _trackingHistory
                          .map((status) => _buildTrackingCard(status))
                          .toList(),
                    )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingCard(String status) {
    // Check if the status matches the latest status in the tracking history
    bool isCurrentStatus = _trackingHistory.isNotEmpty && status == _trackingHistory.last;

    // Check if the current order is the one to highlight
    bool isHighlightedOrder = _orderNumber == "987654321";

    // Check if the current status is "Package in warehouse" and the previous status was "Package handed over"
    bool isTransitionHighlight = _trackingHistory.isNotEmpty && _trackingHistory.last ==  "Package in warehouse" ;

    // Check if the order has transitioned from "Package handed over" to "Package in warehouse" and if it is the last tracked order
    bool isLastHighlightedOrder = isHighlightedOrder && isTransitionHighlight && isCurrentStatus;

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: isLastHighlightedOrder ? Colors.white : isCurrentStatus ? Colors.orange[100] : isHighlightedOrder ? isTransitionHighlight ? Colors.yellow[100] : Colors.white : Colors.white, // Highlight current status or specific order
      child: ListTile(
        leading: Icon(
          statusIcons.containsKey(status) ? statusIcons[status] : Icons.info,
          color: isLastHighlightedOrder ? Colors.blue : isCurrentStatus ? Colors.orange : isHighlightedOrder ? isTransitionHighlight ? Colors.yellow[700] : Colors.blue : Colors.blue, // Change icon color for current status or specific order
        ),
        title: Text(
          status,
          style: TextStyle(
            fontWeight: isLastHighlightedOrder || isCurrentStatus || isHighlightedOrder || isTransitionHighlight ? FontWeight.bold : FontWeight.normal, // Bold text for current status or specific order
          ),
        ),
      ),
    );
  }
}