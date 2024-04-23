import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'Accountype.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Startup(), // Set Startup as the home page
    );
  }
}

class Startup extends StatefulWidget {
  @override
  _StartupState createState() => _StartupState();
}

class _StartupState extends State<Startup> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = Tween<Offset>(
      begin: Offset(-0.5, 0.0), // Start from the left side
      end: Offset(1.0, 0.0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation(BuildContext context) {
    _controller.forward().then((_) {
      // Navigate to AccountType page after the animation is complete
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => AccountType(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange, Colors.deepOrange],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedButton(
                    onPressed: () {
                      _startAnimation(context); // Start the van animation
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                    width: 250, // Set the width here
                  ),
                  SizedBox(height: 10), // Add some space between the buttons
                  TextButton(
                    onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                      // Add your onPressed logic here
                    },
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 25,
              right: 20,
              child: TextButton(
                onPressed: () {
                  // Add your onPressed logic here
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'SignUp or login to place an order',
                        textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: Duration(seconds: 2),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  SizedBox(height: 20),
                  SlideTransition(
                    position: _animation,
                    child: Image.asset(
                      'assets/van.png',
                      height: 300
                      ,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double width;

  const AnimatedButton({Key? key, this.onPressed, required this.child, this.width = 200}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: SizedBox(
              width: widget.width,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Set circular radius here
                    ),
                  ),
                ),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}
