import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter/services.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  // Controllers for text fields
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  // State variables
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
              // Title
              Text('Create a business account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              // Owner Name TextField
              _buildTextField(_ownerNameController, 'Owner Name', TextInputType.text),
              SizedBox(height: 20),
              // Company Name TextField
              _buildTextField(_companyNameController, 'Company Name', TextInputType.text),
              SizedBox(height: 20),
              // Email TextField
              _buildTextField(_emailController, 'Email', TextInputType.emailAddress),
            SizedBox(height: 20),
            _buildTextField(_phoneNumberController, 'Phone Number', TextInputType.phone,),
              SizedBox(height: 20),
              // Password TextField
              _buildPasswordTextField(),
              SizedBox(height: 20),
              // Agreement Checkbox
              Row(
                children: [
                  Checkbox(value: _isChecked, onChanged: (value) => setState(() => _isChecked = value ?? false)),
                  Text('I agree to the terms and conditions'),
                ],
              ),
              SizedBox(height: 20),
              // Agreement Text
              Text('By checking this box, you agree to abide by our terms and conditions.', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Add your sign-up logic here
                },
                child: SizedBox(
                  width: 250, // Set width to match the parent width
                  child: Text('Sign Up', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              SizedBox(height: 10),
              // Social Login Text
              Text('To Continue with', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(height: 10),
              // Social Login Buttons
              Row(
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
              ),
              SizedBox(height: 10),
              // Already have an account TextButton
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                child: Text('Already have an account?', style: TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(TextEditingController controller, String labelText, TextInputType keyboardType, [int? maxLength]) {
    return SizedBox(
      height: 50, // Set height to 50
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allow digits
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: 'Enter $labelText',
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
}
