import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter

class Individual extends StatefulWidget {
  @override
  _IndividualState createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(),
              SizedBox(height: 20),
              _buildTextField(_phoneNumberController, 'Phone Number', TextInputType.phone),
              SizedBox(height: 10),
              _buildTextField(_emailController, 'Email', TextInputType.emailAddress),
              SizedBox(height: 20),
              _buildPasswordTextField(),
              SizedBox(height: 20),
              _buildAgreementCheckbox(),
              SizedBox(height: 20),
              _buildSignUpButton(),
              SizedBox(height: 10),
              _buildSocialLoginText(),
              SizedBox(height: 10),
              _buildSocialLoginButtons(),
              SizedBox(height: 10),
              _buildAlreadyHaveAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Create a personal account',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, TextInputType keyboardType) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allow digits
        decoration: InputDecoration(
          labelText: labelText,
          hintText: 'Enter your $labelText',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: _passwordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your password',
          suffixIcon: IconButton(
            icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
        ),
        Text('I agree to the terms and conditions'),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        // Add your sign-up logic here
      },
      child: SizedBox(
        width: 250,
        child: Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Widget _buildSocialLoginText() {
    return Text(
      'To Continue with',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey, fontSize: 14),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: Image.asset('assets/google.png'),
            onPressed: () {
              // Implement Google sign-in logic
            },
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: Image.asset('assets/facebook.png'),
            onPressed: () {
              // Implement Facebook sign-in logic
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAlreadyHaveAccountButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        ); // Implement your custom sign-in logic
      },
      child: Text(
        'Already have an account?',
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}
