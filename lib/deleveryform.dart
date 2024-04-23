import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DatabaseHelper.dart';

class dForm extends StatefulWidget {
  @override
  _dFormState createState() => _dFormState();
}

class _dFormState extends State<dForm> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData prefixIcon) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(prefixIcon),
    );
  }

  Widget _buildDateFormField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Pick a Date: ${DateFormat('MM-dd-yyyy').format(_selectedDate)}',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade400, Colors.orange.shade300],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration('Name', Icons.person),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              decoration: _buildInputDecoration('Address', Icons.location_on),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneNumberController,
              decoration: _buildInputDecoration('Phone Number', Icons.phone),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: _buildInputDecoration('Email', Icons.email),
            ),
            SizedBox(height: 20),
            _buildDateFormField(),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                FormData formData = FormData(
                  name: _nameController.text,
                  address: _addressController.text,
                  phoneNumber: _phoneNumberController.text,
                  email: _emailController.text,
                  date: DateFormat('MM-dd-yyyy').format(_selectedDate),
                );
                int id = await DatabaseHelper.instance.insertForm(formData);
                print('Form data inserted with id: $id');

                // Print the details inserted into the form
                print('Name: ${formData.name}');
                print('Address: ${formData.address}');
                print('Phone Number: ${formData.phoneNumber}');
                print('Date: ${formData.date}');
                print('Email: ${formData.email}');

                // Show a confirmation dialog or navigate to another screen
              },
              child: Text('Submit'), // Add the text "Submit" here
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orangeAccent, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
              ),
            ),


            // Button style and child widget remains the same


          ],
        ),
      ),
    );
  }
}