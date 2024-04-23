import 'package:flutter/material.dart';
import 'package:shipment/Employee.dart';
import 'package:shipment/Settings.dart';
import 'package:shipment/deleveryform.dart';
import 'package:shipment/drivers.dart';
import 'package:shipment/helpcenter.dart';
import 'package:shipment/wallet.dart';
import 'Pickup.dart';
import 'availablevehicles.dart';
import 'order.dart';
import 'ordr tracking.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double _opacity = 1.0; // Initial opacity value
  late AnimationController _controller; // Declare AnimationController
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _startBreathingAnimation();
  }

  void _startBreathingAnimation() {
    Tween<double> tween = Tween<double>(begin: 1.0, end: 0.6);
    _controller.repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _opacity = tween.animate(_controller).value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shipment'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Implement notifications functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _opacity, // Use the animated opacity value
                    duration: Duration(milliseconds: 200),
                    child: Image.asset(
                      'assets/adil.png',
                      height: 100,
                      fit: BoxFit.contain, // Adjust the fit property to maintain the aspect ratio
                    ),
                  ),

                  Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
            drawerListTile(Icons.shopping_bag, 'Orders', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => orderss()),
              );
            }),
            drawerListTile(Icons.account_balance_wallet, 'Wallet', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPage()),
              );
            }),
            drawerListTile(Icons.local_shipping, 'Delivery Form', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => dForm()),
              );
            }),
            drawerListTile(Icons.people, 'My Drivers', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriversScreen()),
              );
            }),
            drawerListTile(Icons.people, 'Tracking', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderTrackingPage()),
              );
            }),
            drawerListTile(Icons.help, 'Help Center', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpCenter()),
              );
            }),
            drawerListTile(Icons.settings, 'Settings', () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Setting()),
            );}),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildButton(
                    'Place previous orders faster',
                    'Find order by address, contact info, remarks, or ID.',
                    'assets/Delivery.png',
                    Colors.orange,
                        () {},
                  ),
                  SizedBox(width: 20),
                  buildButton(
                    'For and Personal and business deliveries',
                    'Send anything to friends, family, or customers >',
                    'assets/od.webp',
                    Colors.deepPurple,
                        () {},
                  ),
                  SizedBox(width: 20),
                  buildButton(
                    'Vehicles for all types of deliveries',
                    'Easily transport large and small items >',
                    'assets/all.png',
                    Colors.red,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Vehicles()),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  buildButton(
                    'Blog',
                    'Description for Button 4',
                    'assets/blog.png',
                    Colors.blueAccent,
                        () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            for (var item in cartItems) pickUpCard(item),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNewWidget,
              child: Text('Add+', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget buildButton(String text, String description, String imagePath, Color color, Function()? onPressed) {
    return Container(
      height: 150.0,
      width: 300.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(description, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imagePath, height: 100, width: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pickUpCard(Map<String, dynamic> item) {
    String selectedOption = item['selectedOption'];
    DateTime? selectedDateTime = item['selectedDateTime'];

    return InkWell(
      onTap: () => _showPickUpDialog(item),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_shipping),
                  SizedBox(width: 10),
                  Text(
                    'Pick-up: $selectedOption',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('Pick-up'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pickup()),
                  );
                },
              ),
              ListTile(
                title: Text('Drop-off'),
                onTap: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dForm()),
                );},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPickUpDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            String selectedOption = item['selectedOption'];
            DateTime? selectedDateTime = item['selectedDateTime'];

            return AlertDialog(
              title: Text('Pick-up'),
              content: selectedDateTime == null
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Schedule pick-up for:'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          setState(() {
                            item['selectedDateTime'] = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text('Select Date & Time'),
                  ),
                ],
              )
                  : Text(
                  'Pick-up scheduled for: ${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}.${selectedDateTime.millisecond.toString().padLeft(3, '0')}'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      item['selectedOption'] = selectedDateTime != null ? '${selectedDateTime.toString()}' : '';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addNewWidget() {
    setState(() {
      cartItems.add({'selectedOption': '', 'selectedDateTime': null});
    });
  }
}