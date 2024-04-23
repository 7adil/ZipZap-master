import 'package:flutter/material.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange, Colors.deepOrange],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:80),
                Center(
                  child: Icon(
                    Icons.local_shipping_rounded,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: 50, // Set the desired height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                        height: 50, // Set the desired height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.lock),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle login logic here
                        },
                        child: Text('Login'),style: ElevatedButton.styleFrom(

                        foregroundColor: Colors.white, backgroundColor: Colors.orangeAccent, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Border radius
                        ),
                      ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Startup()),
                          );
                        },
                        child: Text('Create an Account'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
