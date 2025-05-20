import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  CustomerScreenState createState() => CustomerScreenState();
}

class CustomerScreenState extends State<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _message;
  Color _messageColor = Colors.red;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _validateCustomer() async {
    if (_formKey.currentState!.validate()) {
      String customerName = _customerNameController.text;
      String phoneNumber = _phoneNumberController.text;

      try{
        if(!RegExp(r"^[A-Za-z]+([ ]?[A-Za-z]+)*$").hasMatch(customerName)){
          setState(() {
            _message = 'Customer Name must contains only alphabets';
            _messageColor = Colors.red;
          });
        }
        else{
          setState(() {
            _message = 'Customer Added Successfully';
            _messageColor = Colors.green;
          });


        }
      }catch(e){
        setState(() {
          _message = 'An error occurred: $e';
          _messageColor = Colors.red;
        });
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Screen'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _message!,
                    style: TextStyle(color: _messageColor, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),

              TextFormField(
                controller: _customerNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Customer Name';
                  }else if(!RegExp(r"^[A-Za-z]+([ ]?[A-Za-z]+)*$").hasMatch(value)){
                    return 'Customer Name must contains only alphabets';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Customer Phone Number';
                  }else if(!RegExp(r"^\d{11}$").hasMatch(value)){
                    return 'Customer Number must contains only 11 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _validateCustomer,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Add Customer', style: TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
